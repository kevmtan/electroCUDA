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

static emlrtRTEInfo emlrtRTEI{ 1,      // lineNo
  1,                                   // colNo
  "_coder_ec_filtfilt_api",            // fName
  ""                                   // pName
};

static emlrtRTEInfo b_emlrtRTEI{ 132,  // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo c_emlrtRTEI{ 130,  // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo d_emlrtRTEI{ 138,  // lineNo
  56,                                  // colNo
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

static emlrtRTEInfo l_emlrtRTEI{ 397,  // lineNo
  5,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo m_emlrtRTEI{ 829,  // lineNo
  21,                                  // colNo
  "unaryMinOrMax",                     // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/unaryMinOrMax.m"// pName
};

static emlrtRTEInfo n_emlrtRTEI{ 266,  // lineNo
  17,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo o_emlrtRTEI{ 145,  // lineNo
  8,                                   // colNo
  "filtord",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtord.m"// pName
};

static emlrtRTEInfo p_emlrtRTEI{ 6,    // lineNo
  5,                                   // colNo
  "ec_filtfilt",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/bin/src_mex/ec_filtfilt.m"// pName
};

static emlrtRTEInfo q_emlrtRTEI{ 291,  // lineNo
  5,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo r_emlrtRTEI{ 162,  // lineNo
  25,                                  // colNo
  "filtord",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtord.m"// pName
};

static emlrtRTEInfo s_emlrtRTEI{ 76,   // lineNo
  9,                                   // colNo
  "eml_mtimes_helper",                 // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/ops/eml_mtimes_helper.m"// pName
};

static emlrtRTEInfo t_emlrtRTEI{ 149,  // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo u_emlrtRTEI{ 143,  // lineNo
  20,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo v_emlrtRTEI{ 145,  // lineNo
  20,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo w_emlrtRTEI{ 267,  // lineNo
  17,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo x_emlrtRTEI{ 60,   // lineNo
  20,                                  // colNo
  "bsxfun",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/elmat/bsxfun.m"// pName
};

static emlrtRTEInfo y_emlrtRTEI{ 88,   // lineNo
  9,                                   // colNo
  "eml_mtimes_helper",                 // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/ops/eml_mtimes_helper.m"// pName
};

static emlrtRTEInfo ab_emlrtRTEI{ 1,   // lineNo
  1,                                   // colNo
  "gpufilterImpl",                     // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/datafun/private/gpufilterImpl.p"// pName
};

static emlrtRTEInfo bb_emlrtRTEI{ 211, // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo cb_emlrtRTEI{ 212, // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo db_emlrtRTEI{ 149, // lineNo
  16,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo eb_emlrtRTEI{ 268, // lineNo
  17,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo fb_emlrtRTEI{ 1,   // lineNo
  1,                                   // colNo
  "stencil_codegen",                   // fName
  "/usr/local/MATLAB/R2022b/toolbox/gpucoder/gpucoder/+gpucoder/+internal/stencil_codegen.p"// pName
};

static emlrtRTEInfo gb_emlrtRTEI{ 401, // lineNo
  44,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo hb_emlrtRTEI{ 172, // lineNo
  20,                                  // colNo
  "colon",                             // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/ops/colon.m"// pName
};

static emlrtRTEInfo ib_emlrtRTEI{ 1653,// lineNo
  27,                                  // colNo
  "sparse",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/shared/coder/coder/+coder/+internal/@sparse/sparse.m"// pName
};

static emlrtRTEInfo jb_emlrtRTEI{ 125, // lineNo
  44,                                  // colNo
  "sparse",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/shared/coder/coder/+coder/+internal/@sparse/sparse.m"// pName
};

static emlrtRTEInfo kb_emlrtRTEI{ 1682,// lineNo
  5,                                   // colNo
  "sparse",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/shared/coder/coder/+coder/+internal/@sparse/sparse.m"// pName
};

static emlrtRTEInfo lb_emlrtRTEI{ 295, // lineNo
  5,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo mb_emlrtRTEI{ 13,  // lineNo
  1,                                   // colNo
  "sparse",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/sparfun/sparse.m"// pName
};

static emlrtRTEInfo nb_emlrtRTEI{ 193, // lineNo
  42,                                  // colNo
  "sparse",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/shared/coder/coder/+coder/+internal/@sparse/sparse.m"// pName
};

static emlrtRTEInfo ob_emlrtRTEI{ 395, // lineNo
  13,                                  // colNo
  "sparse",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/shared/coder/coder/+coder/+internal/@sparse/sparse.m"// pName
};

static emlrtRTEInfo pb_emlrtRTEI{ 406, // lineNo
  57,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo qb_emlrtRTEI{ 409, // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo rb_emlrtRTEI{ 143, // lineNo
  13,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo sb_emlrtRTEI{ 164, // lineNo
  9,                                   // colNo
  "filter",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/datafun/filter.m"// pName
};

static emlrtRTEInfo tb_emlrtRTEI{ 407, // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo ub_emlrtRTEI{ 373, // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo vb_emlrtRTEI{ 1,   // lineNo
  14,                                  // colNo
  "ec_filtfilt",                       // fName
  "/home/kt/Gdrive/Git/electroCUDA/bin/src_mex/ec_filtfilt.m"// pName
};

static emlrtRTEInfo wb_emlrtRTEI{ 144, // lineNo
  22,                                  // colNo
  "filtord",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtord.m"// pName
};

static emlrtRTEInfo xb_emlrtRTEI{ 144, // lineNo
  5,                                   // colNo
  "filtord",                           // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtord.m"// pName
};

static emlrtRTEInfo yb_emlrtRTEI{ 400, // lineNo
  29,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo ac_emlrtRTEI{ 400, // lineNo
  9,                                   // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo bc_emlrtRTEI{ 270, // lineNo
  24,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo cc_emlrtRTEI{ 119, // lineNo
  13,                                  // colNo
  "sparse",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/shared/coder/coder/+coder/+internal/@sparse/sparse.m"// pName
};

static emlrtRTEInfo dc_emlrtRTEI{ 120, // lineNo
  13,                                  // colNo
  "sparse",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/shared/coder/coder/+coder/+internal/@sparse/sparse.m"// pName
};

static emlrtRTEInfo ec_emlrtRTEI{ 125, // lineNo
  13,                                  // colNo
  "sparse",                            // fName
  "/usr/local/MATLAB/R2022b/toolbox/shared/coder/coder/+coder/+internal/@sparse/sparse.m"// pName
};

static emlrtRTEInfo fc_emlrtRTEI{ 403, // lineNo
  29,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo gc_emlrtRTEI{ 404, // lineNo
  15,                                  // colNo
  "filtfilt",                          // fName
  "/usr/local/MATLAB/R2022b/toolbox/signal/signal/filtfilt.m"// pName
};

static emlrtRTEInfo hc_emlrtRTEI{ 457, // lineNo
  63,                                  // colNo
  "CXSparseAPI",                       // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/CXSparseAPI.m"// pName
};

static emlrtRTEInfo ic_emlrtRTEI{ 19,  // lineNo
  9,                                   // colNo
  "indexDivide",                       // fName
  "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/indexDivide.m"// pName
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
static void binary_expand_op(emxArray_real_T *in1, int32_T in3, const
  emxArray_real_T *in4);
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
  emxArray_real_T xCol);
static __global__ void ec_filtfilt_kernel10(const int32_T y_data[134217726],
  int32_T idx, const int32_T coef_dim1, emxArray_int32_T rows);
static __global__ void ec_filtfilt_kernel100(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ec_filtfilt_kernel101(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ec_filtfilt_kernel102(emxArray_real_T a);
static __global__ void ec_filtfilt_kernel103(const int32_T b_dim0, uint32_T
  zfSize[2]);
static __global__ void ec_filtfilt_kernel104(int32_T c, emxArray_real_T expanded);
static __global__ void ec_filtfilt_kernel105(const int32_T offsetH, const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv5);
static __global__ void ec_filtfilt_kernel106(const emxArray_int32_T y, int32_T
  b_y, emxArray_int32_T iv6);
static __global__ void ec_filtfilt_kernel107(const emxArray_real_T xCol, const
  emxArray_int32_T iv6, const emxArray_int32_T iv5, const int32_T b_xCol,
  int32_T c_xCol, const int32_T expanded_dim0, const int32_T xCol_dim0,
  emxArray_real_T expanded);
static __global__ void ec_filtfilt_kernel108(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, const int32_T c, int32_T
  zfSize_idx_0, const int32_T b_dim0, const int32_T convOut_dim0, const int32_T
  expanded_dim0, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel109(const emxArray_real_T zfIIR, const
  emxArray_real_T convOut, const int32_T i, int32_T b_convOut, const int32_T
  convOut_dim0, const int32_T b_convOut_dim0, const int32_T zfIIR_dim0,
  emxArray_real_T c_convOut);
static __global__ void ec_filtfilt_kernel11(const int32_T counts_data[134217727],
  const int32_T y_size_dim1, int32_T idx, const int32_T coef_dim1,
  emxArray_int32_T rows);
static __global__ void ec_filtfilt_kernel110(const emxArray_real_T convOut,
  const int32_T b_convOut, int32_T c_convOut, const int32_T convOut_dim0, const
  int32_T b_convOut_dim0, emxArray_real_T d_convOut);
static __global__ void ec_filtfilt_kernel111(const emxArray_real_T zfIIR,
  int32_T ns, const int32_T zfIIR_dim0, const int32_T convOut_dim0,
  emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel112(const emxArray_real_T zfIIR,
  int32_T ns, const int32_T zfIIR_dim1, const int32_T convOut_dim0, const
  int32_T zfIIR_dim0, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel113(const emxArray_real_T a, int32_T ns,
  const int32_T xCol_dim0, const int32_T a_dim0, const int32_T convOut_dim0,
  emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel114(const emxArray_real_T convOut,
  const int32_T ns, const int32_T ny, int32_T b_convOut, const int32_T
  zfIIR_dim0, const int32_T convOut_dim0, emxArray_real_T zfIIR);
static __global__ void ec_filtfilt_kernel115(const emxArray_real_T convOut,
  const emxArray_real_T a, const int32_T b_a, int32_T ns, const int32_T a_dim0,
  const int32_T zfIIR_dim0, const int32_T xCol_dim0, const int32_T convOut_dim0,
  emxArray_real_T zfIIR);
static __global__ void ec_filtfilt_kernel116(const emxArray_real_T convOut,
  const int32_T xCol, int32_T b_convOut, const int32_T convOut_dim0, const
  int32_T b_convOut_dim0, emxArray_real_T c_convOut);
static __global__ void ec_filtfilt_kernel117(const emxArray_real_T convOut,
  int32_T ny, int32_T ns, emxArray_real_T yc2);
static __global__ void ec_filtfilt_kernel118(const emxArray_real_T xCol, const
  int32_T ny, int32_T b_xCol, const int32_T xCol_dim0, emxArray_real_T y);
static __global__ void ec_filtfilt_kernel119(const emxArray_real_T xCol, const
  emxArray_real_T y, const real_T nfact, const int32_T ny, const int32_T ns,
  const int32_T xt, int32_T vlen, const int32_T xt_dim0, const int32_T xCol_dim0,
  emxArray_real_T b_xt);
static __global__ void ec_filtfilt_kernel12(int32_T coef, int32_T y_data
  [134217726]);
static __global__ void ec_filtfilt_kernel120(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ec_filtfilt_kernel121(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static __global__ void ec_filtfilt_kernel122(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ec_filtfilt_kernel123(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ec_filtfilt_kernel124(emxArray_real_T a);
static __global__ void ec_filtfilt_kernel125(int32_T c, emxArray_real_T expanded);
static __global__ void ec_filtfilt_kernel126(const int32_T offsetH, const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv10);
static __global__ void ec_filtfilt_kernel127(const emxArray_int32_T y, int32_T
  b_y, emxArray_int32_T iv11);
static __global__ void ec_filtfilt_kernel128(const emxArray_real_T xt, const
  emxArray_int32_T iv11, const emxArray_int32_T iv10, const int32_T b_xt,
  int32_T c_xt, const int32_T expanded_dim0, const int32_T xt_dim0,
  emxArray_real_T expanded);
static __global__ void ec_filtfilt_kernel129(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, const int32_T c, int32_T
  zfSize_idx_0, const int32_T b_dim0, const int32_T convOut_dim0, const int32_T
  expanded_dim0, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel13(int32_T coef, int32_T y_data
  [134217726]);
static __global__ void ec_filtfilt_kernel130(const emxArray_real_T zfIIR, const
  emxArray_real_T convOut, const int32_T i, int32_T b_convOut, const int32_T
  convOut_dim0, const int32_T b_convOut_dim0, const int32_T zfIIR_dim0,
  emxArray_real_T c_convOut);
static __global__ void ec_filtfilt_kernel131(const emxArray_real_T convOut,
  const int32_T b_convOut, int32_T c_convOut, const int32_T convOut_dim0, const
  int32_T b_convOut_dim0, emxArray_real_T d_convOut);
static __global__ void ec_filtfilt_kernel132(const emxArray_real_T zfIIR,
  int32_T ns, const int32_T zfIIR_dim0, const int32_T convOut_dim0,
  emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel133(const emxArray_real_T zfIIR,
  int32_T ns, const int32_T zfIIR_dim1, const int32_T convOut_dim0, const
  int32_T zfIIR_dim0, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel134(const emxArray_real_T a, int32_T ns,
  const int32_T xt_dim0, const int32_T a_dim0, const int32_T convOut_dim0,
  emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel135(const emxArray_real_T convOut,
  const int32_T xt, int32_T b_convOut, const int32_T convOut_dim0, const int32_T
  b_convOut_dim0, emxArray_real_T c_convOut);
static __global__ void ec_filtfilt_kernel136(const emxArray_real_T convOut,
  int32_T ns, int32_T ny, emxArray_real_T y);
static __global__ void ec_filtfilt_kernel137(const emxArray_real_T y, const
  int32_T vlen, const real_T zi_data[134217727], const int32_T zi_size, int32_T
  idx, const int32_T y_dim0, const int32_T b_y_dim0, emxArray_real_T b_y);
static __global__ void ec_filtfilt_kernel138(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ec_filtfilt_kernel139(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static __global__ void ec_filtfilt_kernel14(int32_T idx, emxArray_int32_T cols);
static __global__ void ec_filtfilt_kernel140(const emxArray_real_T y, const
  int32_T vlen, const real_T zi_data[134217727], const int32_T zi_size, int32_T
  idx, const int32_T y_dim0, const int32_T zi_dim0, emxArray_real_T zi);
static __global__ void ec_filtfilt_kernel141(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ec_filtfilt_kernel142(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ec_filtfilt_kernel143(emxArray_real_T a);
static __global__ void ec_filtfilt_kernel144(int32_T c, emxArray_real_T expanded);
static __global__ void ec_filtfilt_kernel145(const int32_T offsetH, const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv13);
static __global__ void ec_filtfilt_kernel146(const emxArray_int32_T y, int32_T
  b_y, emxArray_int32_T iv14);
static __global__ void ec_filtfilt_kernel147(const emxArray_real_T y, const
  emxArray_int32_T iv14, const emxArray_int32_T iv13, const int32_T b_y, int32_T
  c_y, const int32_T expanded_dim0, const int32_T y_dim0, emxArray_real_T
  expanded);
static __global__ void ec_filtfilt_kernel148(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, const int32_T c, int32_T
  zfSize_idx_0, const int32_T b_dim0, const int32_T convOut_dim0, const int32_T
  expanded_dim0, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel149(const emxArray_real_T zi, const
  emxArray_real_T convOut, const int32_T ns, int32_T b_convOut, const int32_T
  convOut_dim0, const int32_T b_convOut_dim0, const int32_T zi_dim0,
  emxArray_real_T c_convOut);
static __global__ void ec_filtfilt_kernel15(const int32_T y_data[134217726],
  const int32_T y_size_dim1, int32_T idx, emxArray_int32_T cols);
static __global__ void ec_filtfilt_kernel150(const emxArray_real_T convOut,
  const int32_T b_convOut, int32_T c_convOut, const int32_T convOut_dim0, const
  int32_T b_convOut_dim0, emxArray_real_T d_convOut);
static __global__ void ec_filtfilt_kernel151(const emxArray_real_T y, const
  int32_T zi, int32_T ns, const int32_T convOut_dim0, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel152(const emxArray_real_T y, const
  int32_T zi, int32_T ns, const int32_T convOut_dim0, const int32_T y_dim0,
  emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel153(const emxArray_real_T a, int32_T ns,
  const int32_T y_dim0, const int32_T a_dim0, const int32_T convOut_dim0,
  emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel154(const emxArray_real_T convOut,
  const int32_T ns, const int32_T ny, int32_T b_convOut, const int32_T
  zfIIR_dim0, const int32_T convOut_dim0, emxArray_real_T zfIIR);
static __global__ void ec_filtfilt_kernel155(const emxArray_real_T convOut,
  const emxArray_real_T a, const int32_T b_a, int32_T ns, const int32_T a_dim0,
  const int32_T zfIIR_dim0, const int32_T y_dim0, const int32_T convOut_dim0,
  emxArray_real_T zfIIR);
static __global__ void ec_filtfilt_kernel156(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ec_filtfilt_kernel157(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static __global__ void ec_filtfilt_kernel158(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ec_filtfilt_kernel159(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ec_filtfilt_kernel16(const int32_T y_data[134217726],
  const int32_T y_size_dim1_dup0, const int32_T y_size_dim1, int32_T idx,
  emxArray_int32_T cols);
static __global__ void ec_filtfilt_kernel160(emxArray_real_T a);
static __global__ void ec_filtfilt_kernel161(int32_T c, emxArray_real_T expanded);
static __global__ void ec_filtfilt_kernel162(const int32_T offsetH, const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv15);
static __global__ void ec_filtfilt_kernel163(const emxArray_int32_T y, int32_T
  b_y, emxArray_int32_T iv16);
static __global__ void ec_filtfilt_kernel164(const emxArray_real_T yc2, const
  emxArray_int32_T iv16, const emxArray_int32_T iv15, const int32_T b_yc2,
  int32_T c_yc2, const int32_T expanded_dim0, const int32_T yc2_dim0,
  emxArray_real_T expanded);
static __global__ void ec_filtfilt_kernel165(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, const int32_T c, int32_T
  zfSize_idx_0, const int32_T b_dim0, const int32_T convOut_dim0, const int32_T
  expanded_dim0, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel166(const emxArray_real_T zfIIR, const
  emxArray_real_T convOut, const int32_T i, int32_T b_convOut, const int32_T
  convOut_dim0, const int32_T b_convOut_dim0, const int32_T zfIIR_dim0,
  emxArray_real_T c_convOut);
static __global__ void ec_filtfilt_kernel167(const emxArray_real_T convOut,
  const int32_T b_convOut, int32_T c_convOut, const int32_T convOut_dim0, const
  int32_T b_convOut_dim0, emxArray_real_T d_convOut);
static __global__ void ec_filtfilt_kernel168(const emxArray_real_T zfIIR,
  int32_T ns, const int32_T zfIIR_dim0, const int32_T convOut_dim0,
  emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel169(const emxArray_real_T zfIIR,
  int32_T ns, const int32_T zfIIR_dim1, const int32_T convOut_dim0, const
  int32_T zfIIR_dim0, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel17(const emxArray_real_T a2,
  emxArray_int8_T vals);
static __global__ void ec_filtfilt_kernel170(const emxArray_real_T a, int32_T ns,
  const int32_T yc2_dim0, const int32_T a_dim0, const int32_T convOut_dim0,
  emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel171(const emxArray_real_T convOut,
  const int32_T yc2, int32_T b_convOut, const int32_T convOut_dim0, const
  int32_T b_convOut_dim0, emxArray_real_T c_convOut);
static __global__ void ec_filtfilt_kernel172(const emxArray_real_T convOut,
  int32_T ns, int32_T ny, emxArray_real_T yc5);
static __global__ void ec_filtfilt_kernel173(const emxArray_real_T yc5, const
  int32_T b_yc5, int32_T c_yc5, const int32_T xCol_dim0, const int32_T yc5_dim0,
  emxArray_real_T xCol);
static __global__ void ec_filtfilt_kernel174(const emxArray_real_T a2, real_T
  *a1, real_T *b_a1, real_T *c_a1, real_T *d_a1, real_T *e_a1);
static __global__ void ec_filtfilt_kernel175(const real_T *d1, const
  emxArray_real_T xCol, const int32_T i, real_T rhs_data[134217727]);
static __global__ void ec_filtfilt_kernel176(const real_T rhs_data[134217727],
  real_T *val);
static __global__ void ec_filtfilt_kernel177(const real_T *val, const real_T
  zi_data[134217727], int32_T zi_size, real_T outBuff_data[134217727]);
static __global__ void ec_filtfilt_kernel178(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ec_filtfilt_kernel179(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static __global__ void ec_filtfilt_kernel18(const emxArray_real_T a2, const
  int32_T offsetH, int32_T idx, emxArray_int8_T vals);
static __global__ void ec_filtfilt_kernel180(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ec_filtfilt_kernel181(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ec_filtfilt_kernel182(emxArray_real_T a);
static __global__ void ec_filtfilt_kernel183(int32_T c, emxArray_real_T expanded);
static __global__ void ec_filtfilt_kernel184(const int32_T offsetH, const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv1);
static __global__ void ec_filtfilt_kernel185(const real_T rhs_data[134217727],
  const emxArray_int32_T iv1, int32_T xt_size, emxArray_real_T expanded);
static __global__ void ec_filtfilt_kernel186(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, int32_T c, const int32_T
  b_dim0, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel187(const real_T outBuff_data[134217727],
  int32_T ns, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel188(const real_T outBuff_data[134217727],
  emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel189(const emxArray_real_T convOut,
  const int32_T ns, int32_T ny, emxArray_real_T zfIIR);
static __global__ void ec_filtfilt_kernel19(const int32_T offsetH, const int32_T
  ny, int32_T idx, emxArray_int8_T vals);
static __global__ void ec_filtfilt_kernel190(const emxArray_real_T convOut,
  const int32_T xt_size_dim0, const emxArray_real_T a, int32_T ns, const int32_T
  a_dim0, emxArray_real_T zfIIR);
static __global__ void ec_filtfilt_kernel191(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ec_filtfilt_kernel192(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static __global__ void ec_filtfilt_kernel193(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ec_filtfilt_kernel194(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ec_filtfilt_kernel195(emxArray_real_T a);
static __global__ void ec_filtfilt_kernel196(int32_T c, emxArray_real_T expanded);
static __global__ void ec_filtfilt_kernel197(const int32_T offsetH, const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv9);
static __global__ void ec_filtfilt_kernel198(const emxArray_real_T xCol, const
  emxArray_int32_T iv9, int32_T i1, emxArray_real_T expanded);
static __global__ void ec_filtfilt_kernel199(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, int32_T c, const int32_T
  b_dim0, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel2(const emxArray_real_T x, const
  int32_T b_x, int32_T c_x, const int32_T xCol_dim0, const int32_T x_dim0,
  emxArray_real_T xCol);
static __global__ void ec_filtfilt_kernel20(const int32_T y_size_dim1, const
  int32_T offsetH, const int32_T ny, int32_T idx, emxArray_int8_T vals);
static __global__ void ec_filtfilt_kernel200(const emxArray_real_T zfIIR,
  int32_T ns, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel201(const emxArray_real_T zfIIR,
  emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel202(const emxArray_real_T convOut,
  const int32_T ns, int32_T ny, emxArray_real_T zfIIR);
static __global__ void ec_filtfilt_kernel203(const emxArray_real_T convOut,
  const emxArray_real_T a, int32_T ns, const int32_T a_dim0, const int32_T
  xCol_dim0, emxArray_real_T zfIIR);
static __global__ void ec_filtfilt_kernel204(const real_T *d1, const
  emxArray_real_T xCol, const int32_T ny, real_T d, real_T rhs_data[134217727]);
static __global__ void ec_filtfilt_kernel205(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ec_filtfilt_kernel206(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static __global__ void ec_filtfilt_kernel207(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ec_filtfilt_kernel208(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ec_filtfilt_kernel209(emxArray_real_T a);
static __global__ void ec_filtfilt_kernel21(const emxArray_real_T b2, real_T
  *val);
static __global__ void ec_filtfilt_kernel210(int32_T c, emxArray_real_T expanded);
static __global__ void ec_filtfilt_kernel211(const int32_T offsetH, const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv12);
static __global__ void ec_filtfilt_kernel212(const real_T rhs_data[134217727],
  const emxArray_int32_T iv12, int32_T xt_size, emxArray_real_T expanded);
static __global__ void ec_filtfilt_kernel213(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, int32_T c, const int32_T
  b_dim0, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel214(const emxArray_real_T zfIIR,
  int32_T ns, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel215(const emxArray_real_T zfIIR,
  emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel216(const real_T *val, const real_T
  zi_data[134217727], int32_T zi_size, real_T outBuff_data[134217727]);
static __global__ void ec_filtfilt_kernel217(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ec_filtfilt_kernel218(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static __global__ void ec_filtfilt_kernel219(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ec_filtfilt_kernel22(const emxArray_real_T a2, const
  real_T *val, const emxArray_real_T b2, int32_T coef, real_T rhs_data[134217727]);
static __global__ void ec_filtfilt_kernel220(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ec_filtfilt_kernel221(emxArray_real_T a);
static __global__ void ec_filtfilt_kernel222(int32_T c, emxArray_real_T expanded);
static __global__ void ec_filtfilt_kernel223(const int32_T offsetH, const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv17);
static __global__ void ec_filtfilt_kernel224(const emxArray_real_T convOut,
  const int32_T i1, const emxArray_int32_T iv17, int32_T vlen, emxArray_real_T
  expanded);
static __global__ void ec_filtfilt_kernel225(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, int32_T c, const int32_T
  b_dim0, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel226(const real_T outBuff_data[134217727],
  int32_T ns, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel227(const real_T outBuff_data[134217727],
  emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel228(const emxArray_real_T convOut,
  const int32_T csz_idx_0, int32_T ns, emxArray_real_T zfIIR);
static __global__ void ec_filtfilt_kernel229(const emxArray_real_T convOut,
  const int32_T xt_size_dim0, const emxArray_real_T a, int32_T ns, const int32_T
  a_dim0, emxArray_real_T zfIIR);
static __global__ void ec_filtfilt_kernel23(const emxArray_int32_T rows, int32_T
  ns, emxArray_int32_T ridxInt);
static __global__ void ec_filtfilt_kernel230(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ec_filtfilt_kernel231(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static __global__ void ec_filtfilt_kernel232(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ec_filtfilt_kernel233(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ec_filtfilt_kernel234(emxArray_real_T a);
static __global__ void ec_filtfilt_kernel235(int32_T c, emxArray_real_T expanded);
static __global__ void ec_filtfilt_kernel236(const int32_T offsetH, const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv18);
static __global__ void ec_filtfilt_kernel237(const emxArray_real_T convOut,
  const int32_T i1, const emxArray_int32_T iv18, int32_T vlen, emxArray_real_T
  expanded);
static __global__ void ec_filtfilt_kernel238(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, int32_T c, const int32_T
  b_dim0, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel239(const emxArray_real_T zfIIR,
  int32_T ns, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel24(const emxArray_int32_T cols, int32_T
  ns, emxArray_int32_T cidxInt);
static __global__ void ec_filtfilt_kernel240(const emxArray_real_T zfIIR,
  emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel241(const emxArray_real_T convOut,
  const int32_T i1, emxArray_real_T b_convOut);
static __global__ void ec_filtfilt_kernel242(const emxArray_real_T convOut,
  int32_T ny, emxArray_real_T xCol);
static __global__ void ec_filtfilt_kernel243(const emxArray_real_T a2, real_T
  *a1, real_T *b_a1);
static __global__ void ec_filtfilt_kernel244(const emxArray_real_T xCol, real_T *
  d1);
static __global__ void ec_filtfilt_kernel245(const emxArray_real_T xCol, const
  int32_T i, const real_T *d1, int32_T idx, emxArray_real_T ytemp);
static __global__ void ec_filtfilt_kernel246(const real_T *val, const real_T
  zi_data[134217727], int32_T zi_size, real_T outBuff_data[134217727]);
static __global__ void ec_filtfilt_kernel247(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ec_filtfilt_kernel248(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static __global__ void ec_filtfilt_kernel249(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ec_filtfilt_kernel25(int32_T nc, emxArray_int32_T
  sortedIndices);
static __global__ void ec_filtfilt_kernel250(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ec_filtfilt_kernel251(emxArray_real_T a);
static __global__ void ec_filtfilt_kernel252(int32_T c, emxArray_real_T expanded);
static __global__ void ec_filtfilt_kernel253(const int32_T offsetH, const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv2);
static __global__ void ec_filtfilt_kernel254(const emxArray_real_T ytemp, const
  emxArray_int32_T iv2, int32_T b_ytemp, emxArray_real_T expanded);
static __global__ void ec_filtfilt_kernel255(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, int32_T c, const int32_T
  b_dim0, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel256(const real_T outBuff_data[134217727],
  int32_T ns, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel257(const real_T outBuff_data[134217727],
  emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel258(const emxArray_real_T convOut,
  int32_T ytemp, emxArray_real_T dv3);
static __global__ void ec_filtfilt_kernel259(const emxArray_real_T convOut,
  const int32_T i1, emxArray_real_T ytemp);
static __global__ void ec_filtfilt_kernel26(const emxArray_int32_T cidxInt,
  int32_T b_cidxInt, emxArray_int32_T t);
static __global__ void ec_filtfilt_kernel260(const real_T *val, const real_T
  zi_data[134217727], int32_T zi_size, real_T outBuff_data[134217727]);
static __global__ void ec_filtfilt_kernel261(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ec_filtfilt_kernel262(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static __global__ void ec_filtfilt_kernel263(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ec_filtfilt_kernel264(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ec_filtfilt_kernel265(emxArray_real_T a);
static __global__ void ec_filtfilt_kernel266(int32_T c, emxArray_real_T expanded);
static __global__ void ec_filtfilt_kernel267(const int32_T offsetH, const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv8);
static __global__ void ec_filtfilt_kernel268(const emxArray_real_T convOut,
  const int32_T i1, const emxArray_int32_T iv8, int32_T vlen, emxArray_real_T
  expanded);
static __global__ void ec_filtfilt_kernel269(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, int32_T c, const int32_T
  b_dim0, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel27(const emxArray_int32_T t, const
  emxArray_int32_T sortedIndices, int32_T ny, emxArray_int32_T cidxInt);
static __global__ void ec_filtfilt_kernel270(const real_T outBuff_data[134217727],
  int32_T ns, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel271(const real_T outBuff_data[134217727],
  emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel272(const emxArray_real_T convOut,
  const int32_T ny, const int32_T ns, int32_T vlen, emxArray_real_T xCol);
static __global__ void ec_filtfilt_kernel273(const emxArray_real_T xCol, const
  int32_T b_xCol, int32_T c_xCol, const int32_T x_dim0, const int32_T xCol_dim0,
  emxArray_real_T x);
static __global__ void ec_filtfilt_kernel274(const emxArray_real_T xCol, const
  int32_T b_xCol, int32_T c_xCol, const int32_T x_dim0, const int32_T xCol_dim0,
  emxArray_real_T x);
static __global__ void ec_filtfilt_kernel28(const emxArray_int32_T ridxInt,
  int32_T b_ridxInt, emxArray_int32_T t);
static __global__ void ec_filtfilt_kernel29(const emxArray_int32_T t, const
  emxArray_int32_T sortedIndices, int32_T ny, emxArray_int32_T ridxInt);
static __global__ void ec_filtfilt_kernel3(const emxArray_real_T coef, int32_T
  b_coef, emxArray_real_T b);
static __global__ void ec_filtfilt_kernel30(int32_T cols, emxArray_int32_T
  y_rowidx, emxArray_real_T y_d);
static __global__ void ec_filtfilt_kernel31(const emxArray_int8_T vals, const
  emxArray_int32_T sortedIndices, int32_T nc, emxArray_real_T y_d);
static __global__ void ec_filtfilt_kernel32(int32_T ns, emxArray_int32_T
  y_rowidx, emxArray_real_T y_d);
static __global__ void ec_filtfilt_kernel33(int32_T thism, emxArray_int32_T
  y_colidx);
static __global__ void ec_filtfilt_kernel34(int32_T ny, emxArray_int32_T
  y_colidx);
static __global__ void ec_filtfilt_kernel35(const int32_T y_colidx_dim0,
  emxArray_int32_T y_colidx);
static __global__ void ec_filtfilt_kernel36(int32_T ns, emxArray_int32_T
  y_colidx);
static __global__ void ec_filtfilt_kernel37(int32_T thism, int32_T counts_data
  [134217727]);
static __global__ void ec_filtfilt_kernel38(const real_T rhs_data[134217727],
  int32_T zfSize_idx_0, real_T outBuff_data[134217727]);
static __global__ void ec_filtfilt_kernel39(const real_T outBuff_data[134217727],
  int32_T i, real_T zi_data[134217727]);
static __global__ void ec_filtfilt_kernel4(const emxArray_real_T coef, int32_T
  b_coef, emxArray_real_T b2);
static __global__ void ec_filtfilt_kernel40(int32_T ns, emxArray_int32_T
  y_rowidx, emxArray_real_T y_d);
static __global__ void ec_filtfilt_kernel41(int32_T thism, emxArray_int32_T
  y_colidx);
static __global__ void ec_filtfilt_kernel42(int32_T ny, emxArray_int32_T
  y_colidx);
static __global__ void ec_filtfilt_kernel43(const int32_T y_colidx_dim0,
  emxArray_int32_T y_colidx);
static __global__ void ec_filtfilt_kernel44(int32_T ns, emxArray_int32_T
  y_colidx);
static __global__ void ec_filtfilt_kernel45(int32_T thism, int32_T counts_data
  [134217727]);
static __global__ void ec_filtfilt_kernel46(const real_T rhs_data[134217727],
  int32_T zfSize_idx_0, real_T zi_data[134217727]);
static __global__ void ec_filtfilt_kernel47(int32_T ns, emxArray_int32_T
  y_rowidx, emxArray_real_T y_d);
static __global__ void ec_filtfilt_kernel48(int32_T thism, emxArray_int32_T
  y_colidx);
static __global__ void ec_filtfilt_kernel49(int32_T ny, emxArray_int32_T
  y_colidx);
static __global__ void ec_filtfilt_kernel5(emxArray_real_T a2);
static __global__ void ec_filtfilt_kernel50(const int32_T y_colidx_dim0,
  emxArray_int32_T y_colidx);
static __global__ void ec_filtfilt_kernel51(int32_T ns, emxArray_int32_T
  y_colidx);
static __global__ void ec_filtfilt_kernel52(int32_T thism, int32_T counts_data
  [134217727]);
static __global__ void ec_filtfilt_kernel53(const real_T rhs_data[134217727],
  int32_T zfSize_idx_0, real_T outBuff_data[134217727]);
static __global__ void ec_filtfilt_kernel54(const real_T outBuff_data[134217727],
  int32_T i, real_T zi_data[134217727]);
static __global__ void ec_filtfilt_kernel55(const emxArray_real_T coef,
  emxArray_real_T b);
static __global__ void ec_filtfilt_kernel56(const emxArray_real_T b, int32_T b_b,
  emxArray_real_T b1);
static __global__ void ec_filtfilt_kernel57(const emxArray_real_T b,
  emxArray_real_T b1);
static __global__ void ec_filtfilt_kernel58(const emxArray_real_T b1, int32_T ny,
  emxArray_real_T y);
static __global__ void ec_filtfilt_kernel59(const int32_T vlen, const
  emxArray_real_T y, const int32_T ny, const int32_T ns, emxArray_real_T
  maxCoefNum);
static __global__ void ec_filtfilt_kernel6(int32_T idx, emxArray_real_T a2);
static __global__ void ec_filtfilt_kernel60(const emxArray_real_T maxCoefNum,
  int32_T b_maxCoefNum, emxArray_boolean_T x);
static __global__ void ec_filtfilt_kernel61(const real_T *val, int32_T i,
  emxArray_real_T b1);
static __global__ void ec_filtfilt_kernel62(const emxArray_real_T b1, int32_T
  b_b1, emxArray_boolean_T x);
static __global__ void ec_filtfilt_kernel63(const int32_T ii_data_dim0, int32_T
  ns, uint32_T nZeroLastDen_data[1]);
static __global__ void ec_filtfilt_kernel64(uint32_T nZeroLastDen_data[1]);
static __global__ void ec_filtfilt_kernel65(const emxArray_real_T b, real_T a0[3]);
static __global__ void ec_filtfilt_kernel66(const emxArray_real_T b, const
  real_T a0[3], emxArray_real_T b2, emxArray_real_T a2);
static __global__ void ec_filtfilt_kernel67(const emxArray_real_T a2, const
  real_T *val, const emxArray_real_T b2, real_T rhs[2]);
static __global__ void ec_filtfilt_kernel68(int8_T b_I[4]);
static __global__ void ec_filtfilt_kernel69(int8_T b_I[4]);
static __global__ void ec_filtfilt_kernel7(int32_T coef, int32_T y_data
  [134217726]);
static __global__ void ec_filtfilt_kernel70(const emxArray_real_T a2, const
  int8_T b_I[4], real_T A[4]);
static __global__ void ec_filtfilt_kernel71(const real_T A[4], const real_T *val,
  const int32_T ns, const real_T rhs[2], const int32_T ny, real_T Y[2]);
static __global__ void ec_filtfilt_kernel72(const real_T A[4], const real_T rhs
  [2], const int32_T ns, real_T Y[2]);
static __global__ void ec_filtfilt_kernel73(const real_T Y[2], real_T zi_data
  [134217727]);
static __global__ void ec_filtfilt_kernel74(const emxArray_real_T a2, real_T *a1,
  real_T *b_a1, real_T *c_a1, real_T *d_a1, real_T *e_a1);
static __global__ void ec_filtfilt_kernel75(const emxArray_real_T xCol, int32_T
  b_xCol, const int32_T xCol_dim0, emxArray_real_T y);
static __global__ void ec_filtfilt_kernel76(const emxArray_real_T xCol, const
  emxArray_real_T y, const real_T nfact, const int32_T ny, const int32_T ns,
  const int32_T xt, int32_T vlen, const int32_T xt_dim0, const int32_T xCol_dim0,
  emxArray_real_T b_xt);
static __global__ void ec_filtfilt_kernel77(const emxArray_real_T xt, const
  real_T zi_data[134217727], const int32_T zi_size, int32_T idx, const int32_T
  y_dim0, const int32_T xt_dim0, emxArray_real_T y);
static __global__ void ec_filtfilt_kernel78(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ec_filtfilt_kernel79(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static __global__ void ec_filtfilt_kernel8(int32_T coef, int32_T counts_data
  [134217727]);
static __global__ void ec_filtfilt_kernel80(const emxArray_real_T xt, const
  real_T zi_data[134217727], const int32_T zi_size, int32_T idx, const int32_T
  xt_dim0, const int32_T zi_dim0, emxArray_real_T zi);
static __global__ void ec_filtfilt_kernel81(const real_T *a1, int32_T nb,
  emxArray_real_T b);
static __global__ void ec_filtfilt_kernel82(const real_T *a1, int32_T na,
  emxArray_real_T a);
static __global__ void ec_filtfilt_kernel83(emxArray_real_T a);
static __global__ void ec_filtfilt_kernel84(const int32_T b_dim0, uint32_T
  zfSize[2]);
static __global__ void ec_filtfilt_kernel85(const int32_T b_dim0, uint32_T dv1[2]);
static __global__ void ec_filtfilt_kernel86(int32_T c, emxArray_real_T expanded);
static __global__ void ec_filtfilt_kernel87(const int32_T offsetH, const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv3);
static __global__ void ec_filtfilt_kernel88(const emxArray_int32_T y, int32_T
  b_y, emxArray_int32_T iv4);
static __global__ void ec_filtfilt_kernel89(const emxArray_real_T xt, const
  emxArray_int32_T iv4, const emxArray_int32_T iv3, const int32_T b_xt, int32_T
  c_xt, const int32_T expanded_dim0, const int32_T xt_dim0, emxArray_real_T
  expanded);
static __global__ void ec_filtfilt_kernel9(int32_T idx, emxArray_int32_T rows);
static __global__ void ec_filtfilt_kernel90(const emxArray_real_T expanded,
  const emxArray_int32_T rows, const emxArray_real_T b, const int32_T c, int32_T
  zfSize_idx_0, const int32_T b_dim0, const int32_T convOut_dim0, const int32_T
  expanded_dim0, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel91(const emxArray_real_T zi, const
  emxArray_real_T convOut, const int32_T ns, int32_T b_convOut, const int32_T
  convOut_dim0, const int32_T b_convOut_dim0, const int32_T zi_dim0,
  emxArray_real_T c_convOut);
static __global__ void ec_filtfilt_kernel92(const emxArray_real_T convOut, const
  int32_T b_convOut, int32_T c_convOut, const int32_T convOut_dim0, const
  int32_T b_convOut_dim0, emxArray_real_T d_convOut);
static __global__ void ec_filtfilt_kernel93(const emxArray_real_T y, const
  int32_T zi, int32_T ns, const int32_T convOut_dim0, emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel94(const emxArray_real_T y, const
  int32_T zi, int32_T ns, const int32_T convOut_dim0, const int32_T y_dim0,
  emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel95(const emxArray_real_T a, int32_T ns,
  const int32_T xt_dim0, const int32_T a_dim0, const int32_T convOut_dim0,
  emxArray_real_T convOut);
static __global__ void ec_filtfilt_kernel96(const emxArray_real_T convOut, const
  int32_T ns, const int32_T ny, int32_T b_convOut, const int32_T zfIIR_dim0,
  const int32_T convOut_dim0, emxArray_real_T zfIIR);
static __global__ void ec_filtfilt_kernel97(const emxArray_real_T convOut, const
  emxArray_real_T a, const int32_T b_a, int32_T ns, const int32_T a_dim0, const
  int32_T zfIIR_dim0, const int32_T xt_dim0, const int32_T convOut_dim0,
  emxArray_real_T zfIIR);
static __global__ void ec_filtfilt_kernel98(const emxArray_real_T b2, int32_T
  b_b2, emxArray_real_T b);
static __global__ void ec_filtfilt_kernel99(const emxArray_real_T a2, int32_T
  b_a2, emxArray_real_T a);
static void ec_filtfilt_once();
static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, char_T y[14]);
static void emlrt_marshallIn(const mxArray *x, const char_T *identifier,
  emxArray_real_T *y);
static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y);
static void emlrt_marshallIn(const mxArray *a__output_of_sprintf_, const char_T *
  identifier, char_T y[14]);
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
  int32_T i;
  int32_T i1;
  int32_T i2;
  int32_T in2_idx_1;
  int32_T stride_0_1;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  in2_idx_1 = in2->size[1];
  i = in2->size[0];
  i1 = in2->size[1];
  emxInit_real_T(&b_in1, 2, &ab_emlrtRTEI, true);
  i2 = b_in1->size[0] * b_in1->size[1];
  b_in1->size[0] = in2->size[0];
  if (in2_idx_1 == 1) {
    b_in1->size[1] = in1->size[1];
  } else {
    b_in1->size[1] = in2_idx_1;
  }

  emxEnsureCapacity_real_T(b_in1, i2, &ab_emlrtRTEI);
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
  emxInit_real_T(&b_in1, 2, &ab_emlrtRTEI, true);
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

  emxEnsureCapacity_real_T(b_in1, i, &ab_emlrtRTEI);
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
  emxArray_real_T x, int32_T b_x, emxArray_real_T xCol)
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
    xCol.data[iv0] = x.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel10(const
  int32_T y_data[134217726], int32_T idx, const int32_T coef_dim1,
  emxArray_int32_T rows)
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
    rows.data[(iv0 + coef_dim1) - 1] = y_data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel100(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel101(const
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel102
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel103(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel104(int32_T
  c, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel105(const
  int32_T offsetH, const emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv5)
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
    if ((offsetH < 0) && (i < MIN_int32_T - offsetH)) {
      i = MIN_int32_T;
    } else if ((offsetH > 0) && (i > MAX_int32_T - offsetH)) {
      i = MAX_int32_T;
    } else {
      i += offsetH;
    }

    iv5.data[iv0] = i - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel106(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel107(const
  emxArray_real_T xCol, const emxArray_int32_T iv6, const emxArray_int32_T iv5,
  const int32_T b_xCol, int32_T c_xCol, const int32_T expanded_dim0, const
  int32_T xCol_dim0, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_xCol) + 1UL) * (static_cast<uint64_T>
    (c_xCol) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_xCol) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) / (static_cast<
      uint64_T>(b_xCol) + 1UL));
    expanded.data[iv5.data[ix] + expanded_dim0 * iv6.data[iv0]] = xCol.data[ix +
      xCol_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel108(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  const int32_T c, int32_T zfSize_idx_0, const int32_T b_dim0, const int32_T
  convOut_dim0, const int32_T expanded_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c - 1) + 1UL) * (static_cast<uint64_T>
    (zfSize_idx_0) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T cv;
    int32_T iv0;
    int32_T ix;
    iv0 = static_cast<int32_T>(idx % (static_cast<uint64_T>(c - 1) + 1UL));
    ix = static_cast<int32_T>((idx - static_cast<uint64_T>(iv0)) / (static_cast<
      uint64_T>(c - 1) + 1UL));
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel109(const
  emxArray_real_T zfIIR, const emxArray_real_T convOut, const int32_T i, int32_T
  b_convOut, const int32_T convOut_dim0, const int32_T b_convOut_dim0, const
  int32_T zfIIR_dim0, emxArray_real_T c_convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(i) + 1UL) * (static_cast<uint64_T>(b_convOut)
    + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(i) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) /
      (static_cast<uint64_T>(i) + 1UL));
    c_convOut.data[ix + convOut_dim0 * iv0] = convOut.data[ix + b_convOut_dim0 *
      iv0] + zfIIR.data[ix + zfIIR_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel11(const
  int32_T counts_data[134217727], const int32_T y_size_dim1, int32_T idx, const
  int32_T coef_dim1, emxArray_int32_T rows)
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
    rows.data[((iv0 + coef_dim1) + y_size_dim1) - 1] = counts_data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel110(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel111(const
  emxArray_real_T zfIIR, int32_T ns, const int32_T zfIIR_dim0, const int32_T
  convOut_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  int32_T b_zfIIR[2];
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    b_zfIIR[0] = zfIIR_dim0;
    for (int32_T i{0}; i < b_zfIIR[0]; i++) {
      convOut.data[i + convOut_dim0 * m] += zfIIR.data[i];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel112(const
  emxArray_real_T zfIIR, int32_T ns, const int32_T zfIIR_dim1, const int32_T
  convOut_dim0, const int32_T zfIIR_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  int32_T b_zfIIR[2];
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    b_zfIIR[1] = zfIIR_dim1;
    for (int32_T i{0}; i < b_zfIIR[1]; i++) {
      convOut.data[i + convOut_dim0 * m] += zfIIR.data[zfIIR_dim0 * i];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel113(const
  emxArray_real_T a, int32_T ns, const int32_T xCol_dim0, const int32_T a_dim0,
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
    ix = (xCol_dim0 + a_dim0) - 1;
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel114(const
  emxArray_real_T convOut, const int32_T ns, const int32_T ny, int32_T b_convOut,
  const int32_T zfIIR_dim0, const int32_T convOut_dim0, emxArray_real_T zfIIR)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(ny - ns) + 1UL) * (static_cast<uint64_T>
    (b_convOut) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(ny - ns) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) / (static_cast<
      uint64_T>(ny - ns) + 1UL));
    zfIIR.data[ix + zfIIR_dim0 * iv0] = convOut.data[(ns + ix) + convOut_dim0 *
      iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel115(const
  emxArray_real_T convOut, const emxArray_real_T a, const int32_T b_a, int32_T
  ns, const int32_T a_dim0, const int32_T zfIIR_dim0, const int32_T xCol_dim0,
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
      zfIIR.data[(i + zfIIR_dim0 * m) + 1] += convOut.data[((xCol_dim0 + i) -
        iv0) + convOut_dim0 * m] * a.data[iv0 + 1];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel116(const
  emxArray_real_T convOut, const int32_T xCol, int32_T b_convOut, const int32_T
  convOut_dim0, const int32_T b_convOut_dim0, emxArray_real_T c_convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(xCol) + 1UL) * (static_cast<uint64_T>
    (b_convOut) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(xCol) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) / (static_cast<
      uint64_T>(xCol) + 1UL));
    c_convOut.data[ix + convOut_dim0 * iv0] = convOut.data[ix + b_convOut_dim0 *
      iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel117(const
  emxArray_real_T convOut, int32_T ny, int32_T ns, emxArray_real_T yc2)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ny * ns - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    yc2.data[iv0] = convOut.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel118(const
  emxArray_real_T xCol, const int32_T ny, int32_T b_xCol, const int32_T
  xCol_dim0, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_xCol);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    y.data[iv0] = 2.0 * xCol.data[ny + xCol_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel119(const
  emxArray_real_T xCol, const emxArray_real_T y, const real_T nfact, const
  int32_T ny, const int32_T ns, const int32_T xt, int32_T vlen, const int32_T
  xt_dim0, const int32_T xCol_dim0, emxArray_real_T b_xt)
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
    b_xt.data[i + xt_dim0 * m] = y.data[ns * m] - xCol.data[((xCol_dim0 - (
      static_cast<int32_T>(-((0.0 - nfact) - -1.0)) + 1 != 1) * i) + xCol_dim0 *
      (ny * m)) - 2];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel12(int32_T
  coef, int32_T y_data[134217726])
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
    y_data[iv0] = iv0 + 2;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel120(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel121(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel122(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel123(const
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel124
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel125(int32_T
  c, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel126(const
  int32_T offsetH, const emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv10)
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
    if ((offsetH < 0) && (i < MIN_int32_T - offsetH)) {
      i = MIN_int32_T;
    } else if ((offsetH > 0) && (i > MAX_int32_T - offsetH)) {
      i = MAX_int32_T;
    } else {
      i += offsetH;
    }

    iv10.data[iv0] = i - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel127(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel128(const
  emxArray_real_T xt, const emxArray_int32_T iv11, const emxArray_int32_T iv10,
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
    expanded.data[iv10.data[ix] + expanded_dim0 * iv11.data[iv0]] = xt.data[ix +
      xt_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel129(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  const int32_T c, int32_T zfSize_idx_0, const int32_T b_dim0, const int32_T
  convOut_dim0, const int32_T expanded_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c - 1) + 1UL) * (static_cast<uint64_T>
    (zfSize_idx_0) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T cv;
    int32_T iv0;
    int32_T ix;
    iv0 = static_cast<int32_T>(idx % (static_cast<uint64_T>(c - 1) + 1UL));
    ix = static_cast<int32_T>((idx - static_cast<uint64_T>(iv0)) / (static_cast<
      uint64_T>(c - 1) + 1UL));
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel13(int32_T
  coef, int32_T y_data[134217726])
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
    y_data[iv0] = iv0 + 2;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel130(const
  emxArray_real_T zfIIR, const emxArray_real_T convOut, const int32_T i, int32_T
  b_convOut, const int32_T convOut_dim0, const int32_T b_convOut_dim0, const
  int32_T zfIIR_dim0, emxArray_real_T c_convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(i) + 1UL) * (static_cast<uint64_T>(b_convOut)
    + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(i) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) /
      (static_cast<uint64_T>(i) + 1UL));
    c_convOut.data[ix + convOut_dim0 * iv0] = convOut.data[ix + b_convOut_dim0 *
      iv0] + zfIIR.data[ix + zfIIR_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel131(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel132(const
  emxArray_real_T zfIIR, int32_T ns, const int32_T zfIIR_dim0, const int32_T
  convOut_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  int32_T b_zfIIR[2];
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    b_zfIIR[0] = zfIIR_dim0;
    for (int32_T i{0}; i < b_zfIIR[0]; i++) {
      convOut.data[i + convOut_dim0 * m] += zfIIR.data[i];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel133(const
  emxArray_real_T zfIIR, int32_T ns, const int32_T zfIIR_dim1, const int32_T
  convOut_dim0, const int32_T zfIIR_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  int32_T b_zfIIR[2];
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    b_zfIIR[1] = zfIIR_dim1;
    for (int32_T i{0}; i < b_zfIIR[1]; i++) {
      convOut.data[i + convOut_dim0 * m] += zfIIR.data[zfIIR_dim0 * i];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel134(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel135(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel136(const
  emxArray_real_T convOut, int32_T ns, int32_T ny, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns * ny - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    y.data[iv0] = convOut.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel137(const
  emxArray_real_T y, const int32_T vlen, const real_T zi_data[134217727], const
  int32_T zi_size, int32_T idx, const int32_T y_dim0, const int32_T b_y_dim0,
  emxArray_real_T b_y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(zi_size) + 1UL) * (static_cast<uint64_T>(idx)
    + 1UL) - 1UL;
  for (uint64_T b_idx{threadId}; b_idx <= loopEnd; b_idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(b_idx % (static_cast<uint64_T>(zi_size) + 1UL));
    iv0 = static_cast<int32_T>((b_idx - static_cast<uint64_T>(ix)) / (
      static_cast<uint64_T>(zi_size) + 1UL));
    b_y.data[ix + y_dim0 * iv0] = zi_data[ix] * y.data[vlen + b_y_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel138(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel139(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel14(int32_T
  idx, emxArray_int32_T cols)
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
    cols.data[iv0] = 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel140(const
  emxArray_real_T y, const int32_T vlen, const real_T zi_data[134217727], const
  int32_T zi_size, int32_T idx, const int32_T y_dim0, const int32_T zi_dim0,
  emxArray_real_T zi)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(zi_size) + 1UL) * (static_cast<uint64_T>(idx)
    + 1UL) - 1UL;
  for (uint64_T b_idx{threadId}; b_idx <= loopEnd; b_idx += threadStride) {
    real_T cv;
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(b_idx % (static_cast<uint64_T>(zi_size) + 1UL));
    iv0 = static_cast<int32_T>((b_idx - static_cast<uint64_T>(ix)) / (
      static_cast<uint64_T>(zi_size) + 1UL));
    cv = zi_data[ix] * y.data[vlen + y_dim0 * iv0];
    zi.data[ix + zi_dim0 * iv0] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel141(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel142(const
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel143
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel144(int32_T
  c, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel145(const
  int32_T offsetH, const emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv13)
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
    if ((offsetH < 0) && (i < MIN_int32_T - offsetH)) {
      i = MIN_int32_T;
    } else if ((offsetH > 0) && (i > MAX_int32_T - offsetH)) {
      i = MAX_int32_T;
    } else {
      i += offsetH;
    }

    iv13.data[iv0] = i - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel146(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel147(const
  emxArray_real_T y, const emxArray_int32_T iv14, const emxArray_int32_T iv13,
  const int32_T b_y, int32_T c_y, const int32_T expanded_dim0, const int32_T
  y_dim0, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_y) + 1UL) * (static_cast<uint64_T>(c_y) +
    1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_y) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) /
      (static_cast<uint64_T>(b_y) + 1UL));
    expanded.data[iv13.data[ix] + expanded_dim0 * iv14.data[iv0]] = y.data
      [((y_dim0 - ix) + y_dim0 * iv0) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel148(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  const int32_T c, int32_T zfSize_idx_0, const int32_T b_dim0, const int32_T
  convOut_dim0, const int32_T expanded_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c - 1) + 1UL) * (static_cast<uint64_T>
    (zfSize_idx_0) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T cv;
    int32_T iv0;
    int32_T ix;
    iv0 = static_cast<int32_T>(idx % (static_cast<uint64_T>(c - 1) + 1UL));
    ix = static_cast<int32_T>((idx - static_cast<uint64_T>(iv0)) / (static_cast<
      uint64_T>(c - 1) + 1UL));
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel149(const
  emxArray_real_T zi, const emxArray_real_T convOut, const int32_T ns, int32_T
  b_convOut, const int32_T convOut_dim0, const int32_T b_convOut_dim0, const
  int32_T zi_dim0, emxArray_real_T c_convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(ns) + 1UL) * (static_cast<uint64_T>(b_convOut)
    + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(ns) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) / (static_cast<
      uint64_T>(ns) + 1UL));
    c_convOut.data[ix + convOut_dim0 * iv0] = convOut.data[ix + b_convOut_dim0 *
      iv0] + zi.data[ix + zi_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel15(const
  int32_T y_data[134217726], const int32_T y_size_dim1, int32_T idx,
  emxArray_int32_T cols)
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
    cols.data[iv0 + y_size_dim1] = y_data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel150(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel151(const
  emxArray_real_T y, const int32_T zi, int32_T ns, const int32_T convOut_dim0,
  emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(zi) + 1UL) * (static_cast<uint64_T>(ns) + 1UL)
    - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T m;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(zi) + 1UL));
    m = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
      (static_cast<uint64_T>(zi) + 1UL));
    convOut.data[i + convOut_dim0 * m] += y.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel152(const
  emxArray_real_T y, const int32_T zi, int32_T ns, const int32_T convOut_dim0,
  const int32_T y_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(zi) + 1UL) * (static_cast<uint64_T>(ns) + 1UL)
    - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T m;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(zi) + 1UL));
    m = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
      (static_cast<uint64_T>(zi) + 1UL));
    convOut.data[i + convOut_dim0 * m] += y.data[y_dim0 * i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel153(const
  emxArray_real_T a, int32_T ns, const int32_T y_dim0, const int32_T a_dim0,
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
    ix = (y_dim0 + a_dim0) - 1;
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel154(const
  emxArray_real_T convOut, const int32_T ns, const int32_T ny, int32_T b_convOut,
  const int32_T zfIIR_dim0, const int32_T convOut_dim0, emxArray_real_T zfIIR)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(ny - ns) + 1UL) * (static_cast<uint64_T>
    (b_convOut) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(ny - ns) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) / (static_cast<
      uint64_T>(ny - ns) + 1UL));
    zfIIR.data[ix + zfIIR_dim0 * iv0] = convOut.data[(ns + ix) + convOut_dim0 *
      iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel155(const
  emxArray_real_T convOut, const emxArray_real_T a, const int32_T b_a, int32_T
  ns, const int32_T a_dim0, const int32_T zfIIR_dim0, const int32_T y_dim0,
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
      zfIIR.data[(i + zfIIR_dim0 * m) + 1] += convOut.data[((y_dim0 + i) - iv0)
        + convOut_dim0 * m] * a.data[iv0 + 1];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel156(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel157(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel158(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel159(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel16(const
  int32_T y_data[134217726], const int32_T y_size_dim1_dup0, const int32_T
  y_size_dim1, int32_T idx, emxArray_int32_T cols)
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
    cols.data[(iv0 + y_size_dim1) + y_size_dim1_dup0] = y_data[iv0];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel160
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel161(int32_T
  c, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel162(const
  int32_T offsetH, const emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv15)
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
    if ((offsetH < 0) && (i < MIN_int32_T - offsetH)) {
      i = MIN_int32_T;
    } else if ((offsetH > 0) && (i > MAX_int32_T - offsetH)) {
      i = MAX_int32_T;
    } else {
      i += offsetH;
    }

    iv15.data[iv0] = i - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel163(const
  emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv16)
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
    iv16.data[iv0] = y.data[iv0] - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel164(const
  emxArray_real_T yc2, const emxArray_int32_T iv16, const emxArray_int32_T iv15,
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
    expanded.data[iv15.data[ix] + expanded_dim0 * iv16.data[iv0]] = yc2.data
      [((yc2_dim0 - ix) + yc2_dim0 * iv0) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel165(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  const int32_T c, int32_T zfSize_idx_0, const int32_T b_dim0, const int32_T
  convOut_dim0, const int32_T expanded_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c - 1) + 1UL) * (static_cast<uint64_T>
    (zfSize_idx_0) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T cv;
    int32_T iv0;
    int32_T ix;
    iv0 = static_cast<int32_T>(idx % (static_cast<uint64_T>(c - 1) + 1UL));
    ix = static_cast<int32_T>((idx - static_cast<uint64_T>(iv0)) / (static_cast<
      uint64_T>(c - 1) + 1UL));
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel166(const
  emxArray_real_T zfIIR, const emxArray_real_T convOut, const int32_T i, int32_T
  b_convOut, const int32_T convOut_dim0, const int32_T b_convOut_dim0, const
  int32_T zfIIR_dim0, emxArray_real_T c_convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(i) + 1UL) * (static_cast<uint64_T>(b_convOut)
    + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(i) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) /
      (static_cast<uint64_T>(i) + 1UL));
    c_convOut.data[ix + convOut_dim0 * iv0] = convOut.data[ix + b_convOut_dim0 *
      iv0] + zfIIR.data[ix + zfIIR_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel167(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel168(const
  emxArray_real_T zfIIR, int32_T ns, const int32_T zfIIR_dim0, const int32_T
  convOut_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  int32_T b_zfIIR[2];
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    b_zfIIR[0] = zfIIR_dim0;
    for (int32_T i{0}; i < b_zfIIR[0]; i++) {
      convOut.data[i + convOut_dim0 * m] += zfIIR.data[i];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel169(const
  emxArray_real_T zfIIR, int32_T ns, const int32_T zfIIR_dim1, const int32_T
  convOut_dim0, const int32_T zfIIR_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  int32_T b_zfIIR[2];
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    b_zfIIR[1] = zfIIR_dim1;
    for (int32_T i{0}; i < b_zfIIR[1]; i++) {
      convOut.data[i + convOut_dim0 * m] += zfIIR.data[zfIIR_dim0 * i];
    }
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel17(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel170(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel171(const
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
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) /
      (static_cast<uint64_T>(yc2) + 1UL));
    c_convOut.data[ix + convOut_dim0 * iv0] = convOut.data[ix + b_convOut_dim0 *
      iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel172(const
  emxArray_real_T convOut, int32_T ns, int32_T ny, emxArray_real_T yc5)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns * ny - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    yc5.data[iv0] = convOut.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel173(const
  emxArray_real_T yc5, const int32_T b_yc5, int32_T c_yc5, const int32_T
  xCol_dim0, const int32_T yc5_dim0, emxArray_real_T xCol)
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
    xCol.data[ix + xCol_dim0 * iv0] = yc5.data[((yc5_dim0 - ix) + yc5_dim0 * iv0)
      - 1];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel174(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel175(const
  real_T *d1, const emxArray_real_T xCol, const int32_T i, real_T rhs_data
  [134217727])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    rhs_data[iv0] = -xCol.data[i - iv0] + *d1;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel176(const
  real_T rhs_data[134217727], real_T *val)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    *val = rhs_data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel177(const
  real_T *val, const real_T zi_data[134217727], int32_T zi_size, real_T
  outBuff_data[134217727])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(zi_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    outBuff_data[iv0] = zi_data[iv0] * *val;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel178(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel179(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel18(const
  emxArray_real_T a2, const int32_T offsetH, int32_T idx, emxArray_int8_T vals)
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
    vals.data[iv0 + 1] = static_cast<int8_T>(a2.data[offsetH + iv0]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel180(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel181(const
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel182
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel183(int32_T
  c, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel184(const
  int32_T offsetH, const emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv1)
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
    if ((offsetH < 0) && (i < MIN_int32_T - offsetH)) {
      i = MIN_int32_T;
    } else if ((offsetH > 0) && (i > MAX_int32_T - offsetH)) {
      i = MAX_int32_T;
    } else {
      i += offsetH;
    }

    iv1.data[iv0] = i - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel185(const
  real_T rhs_data[134217727], const emxArray_int32_T iv1, int32_T xt_size,
  emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(xt_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv1.data[iv0]] = rhs_data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel186(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  int32_T c, const int32_T b_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T cv;
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel187(const
  real_T outBuff_data[134217727], int32_T ns, emxArray_real_T convOut)
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
    convOut.data[i] += outBuff_data[i];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel188(const
  real_T outBuff_data[134217727], emxArray_real_T convOut)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    convOut.data[0] += outBuff_data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel189(const
  emxArray_real_T convOut, const int32_T ns, int32_T ny, emxArray_real_T zfIIR)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ny - ns);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    zfIIR.data[iv0] = convOut.data[ns + iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel19(const
  int32_T offsetH, const int32_T ny, int32_T idx, emxArray_int8_T vals)
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
    vals.data[((iv0 + ny) - offsetH) + 2] = 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel190(const
  emxArray_real_T convOut, const int32_T xt_size_dim0, const emxArray_real_T a,
  int32_T ns, const int32_T a_dim0, emxArray_real_T zfIIR)
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
      zfIIR.data[i + 1] += convOut.data[(xt_size_dim0 + i) - iv0] * a.data[iv0 +
        1];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel191(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel192(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel193(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel194(const
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel195
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel196(int32_T
  c, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel197(const
  int32_T offsetH, const emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv9)
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
    if ((offsetH < 0) && (i < MIN_int32_T - offsetH)) {
      i = MIN_int32_T;
    } else if ((offsetH > 0) && (i > MAX_int32_T - offsetH)) {
      i = MAX_int32_T;
    } else {
      i += offsetH;
    }

    iv9.data[iv0] = i - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel198(const
  emxArray_real_T xCol, const emxArray_int32_T iv9, int32_T i1, emxArray_real_T
  expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv9.data[iv0]] = xCol.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel199(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  int32_T c, const int32_T b_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T cv;
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel2(const
  emxArray_real_T x, const int32_T b_x, int32_T c_x, const int32_T xCol_dim0,
  const int32_T x_dim0, emxArray_real_T xCol)
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
    xCol.data[ix + xCol_dim0 * iv0] = x.data[iv0 + x_dim0 * ix];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel20(const
  int32_T y_size_dim1, const int32_T offsetH, const int32_T ny, int32_T idx,
  emxArray_int8_T vals)
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
    vals.data[(((iv0 + ny) - offsetH) + y_size_dim1) + 2] = -1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel200(const
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel201(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel202(const
  emxArray_real_T convOut, const int32_T ns, int32_T ny, emxArray_real_T zfIIR)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ny - ns);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    zfIIR.data[iv0] = convOut.data[ns + iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel203(const
  emxArray_real_T convOut, const emxArray_real_T a, int32_T ns, const int32_T
  a_dim0, const int32_T xCol_dim0, emxArray_real_T zfIIR)
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
      zfIIR.data[i + 1] += convOut.data[(xCol_dim0 + i) - iv0] * a.data[iv0 + 1];
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel204(const
  real_T *d1, const emxArray_real_T xCol, const int32_T ny, real_T d, real_T
  rhs_data[134217727])
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
    rhs_data[iv0] = -xCol.data[(ny - iv0) - 1] + *d1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel205(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel206(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel207(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel208(const
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel209
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel21(const
  emxArray_real_T b2, real_T *val)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    *val = b2.data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel210(int32_T
  c, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel211(const
  int32_T offsetH, const emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv12)
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
    if ((offsetH < 0) && (i < MIN_int32_T - offsetH)) {
      i = MIN_int32_T;
    } else if ((offsetH > 0) && (i > MAX_int32_T - offsetH)) {
      i = MAX_int32_T;
    } else {
      i += offsetH;
    }

    iv12.data[iv0] = i - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel212(const
  real_T rhs_data[134217727], const emxArray_int32_T iv12, int32_T xt_size,
  emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(xt_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv12.data[iv0]] = rhs_data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel213(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  int32_T c, const int32_T b_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T cv;
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel214(const
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel215(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel216(const
  real_T *val, const real_T zi_data[134217727], int32_T zi_size, real_T
  outBuff_data[134217727])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(zi_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    outBuff_data[iv0] = zi_data[iv0] * *val;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel217(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel218(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel219(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel22(const
  emxArray_real_T a2, const real_T *val, const emxArray_real_T b2, int32_T coef,
  real_T rhs_data[134217727])
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
    rhs_data[iv0] = b2.data[iv0 + 1] - *val * a2.data[iv0 + 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel220(const
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel221
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel222(int32_T
  c, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel223(const
  int32_T offsetH, const emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv17)
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
    if ((offsetH < 0) && (i < MIN_int32_T - offsetH)) {
      i = MIN_int32_T;
    } else if ((offsetH > 0) && (i > MAX_int32_T - offsetH)) {
      i = MAX_int32_T;
    } else {
      i += offsetH;
    }

    iv17.data[iv0] = i - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel224(const
  emxArray_real_T convOut, const int32_T i1, const emxArray_int32_T iv17,
  int32_T vlen, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv17.data[iv0]] = convOut.data[i1 - iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel225(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  int32_T c, const int32_T b_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T cv;
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel226(const
  real_T outBuff_data[134217727], int32_T ns, emxArray_real_T convOut)
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
    convOut.data[i] += outBuff_data[i];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel227(const
  real_T outBuff_data[134217727], emxArray_real_T convOut)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    convOut.data[0] += outBuff_data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel228(const
  emxArray_real_T convOut, const int32_T csz_idx_0, int32_T ns, emxArray_real_T
  zfIIR)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns - csz_idx_0);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    zfIIR.data[iv0] = convOut.data[csz_idx_0 + iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel229(const
  emxArray_real_T convOut, const int32_T xt_size_dim0, const emxArray_real_T a,
  int32_T ns, const int32_T a_dim0, emxArray_real_T zfIIR)
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
      zfIIR.data[i + 1] += convOut.data[(xt_size_dim0 + i) - iv0] * a.data[iv0 +
        1];
    }
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel230(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel231(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel232(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel233(const
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel234
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel235(int32_T
  c, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel236(const
  int32_T offsetH, const emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv18)
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
    if ((offsetH < 0) && (i < MIN_int32_T - offsetH)) {
      i = MIN_int32_T;
    } else if ((offsetH > 0) && (i > MAX_int32_T - offsetH)) {
      i = MAX_int32_T;
    } else {
      i += offsetH;
    }

    iv18.data[iv0] = i - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel237(const
  emxArray_real_T convOut, const int32_T i1, const emxArray_int32_T iv18,
  int32_T vlen, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv18.data[iv0]] = convOut.data[i1 - iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel238(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  int32_T c, const int32_T b_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T cv;
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel239(const
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel240(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel241(const
  emxArray_real_T convOut, const int32_T i1, emxArray_real_T b_convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    b_convOut.data[iv0] = convOut.data[i1 - iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel242(const
  emxArray_real_T convOut, int32_T ny, emxArray_real_T xCol)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ny - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    xCol.data[iv0] = convOut.data[iv0];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel243(const
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel244(const
  emxArray_real_T xCol, real_T *d1)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    *d1 = 2.0 * xCol.data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel245(const
  emxArray_real_T xCol, const int32_T i, const real_T *d1, int32_T idx,
  emxArray_real_T ytemp)
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
    ytemp.data[iv0] = *d1 - xCol.data[i - iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel246(const
  real_T *val, const real_T zi_data[134217727], int32_T zi_size, real_T
  outBuff_data[134217727])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(zi_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    outBuff_data[iv0] = zi_data[iv0] * *val;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel247(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel248(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel249(const
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel251
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel252(int32_T
  c, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel253(const
  int32_T offsetH, const emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv2)
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
    if ((offsetH < 0) && (i < MIN_int32_T - offsetH)) {
      i = MIN_int32_T;
    } else if ((offsetH > 0) && (i > MAX_int32_T - offsetH)) {
      i = MAX_int32_T;
    } else {
      i += offsetH;
    }

    iv2.data[iv0] = i - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel254(const
  emxArray_real_T ytemp, const emxArray_int32_T iv2, int32_T b_ytemp,
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
    expanded.data[iv2.data[iv0]] = ytemp.data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel255(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  int32_T c, const int32_T b_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T cv;
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel256(const
  real_T outBuff_data[134217727], int32_T ns, emxArray_real_T convOut)
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
    convOut.data[i] += outBuff_data[i];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel257(const
  real_T outBuff_data[134217727], emxArray_real_T convOut)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    convOut.data[0] += outBuff_data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel258(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel259(const
  emxArray_real_T convOut, const int32_T i1, emxArray_real_T ytemp)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    ytemp.data[iv0] = convOut.data[i1 - iv0];
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel260(const
  real_T *val, const real_T zi_data[134217727], int32_T zi_size, real_T
  outBuff_data[134217727])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(zi_size);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    outBuff_data[iv0] = zi_data[iv0] * *val;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel261(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel262(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel263(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel264(const
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel265
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel266(int32_T
  c, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel267(const
  int32_T offsetH, const emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv8)
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
    if ((offsetH < 0) && (i < MIN_int32_T - offsetH)) {
      i = MIN_int32_T;
    } else if ((offsetH > 0) && (i > MAX_int32_T - offsetH)) {
      i = MAX_int32_T;
    } else {
      i += offsetH;
    }

    iv8.data[iv0] = i - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel268(const
  emxArray_real_T convOut, const int32_T i1, const emxArray_int32_T iv8, int32_T
  vlen, emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(vlen);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv8.data[iv0]] = convOut.data[i1 - iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel269(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  int32_T c, const int32_T b_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T cv;
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel27(const
  emxArray_int32_T t, const emxArray_int32_T sortedIndices, int32_T ny,
  emxArray_int32_T cidxInt)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ny);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    cidxInt.data[m] = t.data[sortedIndices.data[m] - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel270(const
  real_T outBuff_data[134217727], int32_T ns, emxArray_real_T convOut)
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
    convOut.data[i] += outBuff_data[i];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel271(const
  real_T outBuff_data[134217727], emxArray_real_T convOut)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    convOut.data[0] += outBuff_data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel272(const
  emxArray_real_T convOut, const int32_T ny, const int32_T ns, int32_T vlen,
  emxArray_real_T xCol)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>((vlen - ns) / ny);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    xCol.data[iv0] = convOut.data[(ns + ny * iv0) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel273(const
  emxArray_real_T xCol, const int32_T b_xCol, int32_T c_xCol, const int32_T
  x_dim0, const int32_T xCol_dim0, emxArray_real_T x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_xCol) + 1UL) * (static_cast<uint64_T>
    (c_xCol) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_xCol) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) / (static_cast<
      uint64_T>(b_xCol) + 1UL));
    x.data[ix + x_dim0 * iv0] = xCol.data[ix + xCol_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel274(const
  emxArray_real_T xCol, const int32_T b_xCol, int32_T c_xCol, const int32_T
  x_dim0, const int32_T xCol_dim0, emxArray_real_T x)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_xCol) + 1UL) * (static_cast<uint64_T>
    (c_xCol) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_xCol) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) /
      (static_cast<uint64_T>(b_xCol) + 1UL));
    x.data[ix + x_dim0 * iv0] = xCol.data[iv0 + xCol_dim0 * ix];
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
  emxArray_int32_T t, const emxArray_int32_T sortedIndices, int32_T ny,
  emxArray_int32_T ridxInt)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ny);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    ridxInt.data[m] = t.data[sortedIndices.data[m] - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel3(const
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
  ny, emxArray_int32_T y_colidx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ny);
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
  thism, int32_T counts_data[134217727])
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
    counts_data[iv0] = 0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel38(const
  real_T rhs_data[134217727], int32_T zfSize_idx_0, real_T outBuff_data
  [134217727])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(zfSize_idx_0 - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    outBuff_data[iv0] = rhs_data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel39(const
  real_T outBuff_data[134217727], int32_T i, real_T zi_data[134217727])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    zi_data[iv0] = outBuff_data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel4(const
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
  ny, emxArray_int32_T y_colidx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ny);
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
  thism, int32_T counts_data[134217727])
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
    counts_data[iv0] = 0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel46(const
  real_T rhs_data[134217727], int32_T zfSize_idx_0, real_T zi_data[134217727])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(zfSize_idx_0 - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    zi_data[iv0] = rhs_data[iv0];
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
  ny, emxArray_int32_T y_colidx)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ny);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    y_colidx.data[bcoef] = 1;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel5
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
  thism, int32_T counts_data[134217727])
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
    counts_data[iv0] = 0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel53(const
  real_T rhs_data[134217727], int32_T zfSize_idx_0, real_T outBuff_data
  [134217727])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(zfSize_idx_0 - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    outBuff_data[iv0] = rhs_data[iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel54(const
  real_T outBuff_data[134217727], int32_T i, real_T zi_data[134217727])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    zi_data[iv0] = outBuff_data[iv0];
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
  emxArray_real_T b1, int32_T ny, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ny);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T m;
    m = static_cast<int32_T>(idx);
    y.data[m] = fabs(b1.data[m]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel59(const
  int32_T vlen, const emxArray_real_T y, const int32_T ny, const int32_T ns,
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
    iv0 = (div_s32_device(bcoef, ns) * ny + bcoef) + 1;
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel6(int32_T
  idx, emxArray_real_T a2)
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
    a2.data[iv0 + 1] = 0.0;
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
  real_T *val, int32_T i, emxArray_real_T b1)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    b1.data[iv0] /= *val;
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
  int32_T ii_data_dim0, int32_T ns, uint32_T nZeroLastDen_data[1])
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ns - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    nZeroLastDen_data[0] = static_cast<uint32_T>(ii_data_dim0);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel64(uint32_T
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel65(const
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel66(const
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel67(const
  emxArray_real_T a2, const real_T *val, const emxArray_real_T b2, real_T rhs[2])
{
  uint64_T threadId;
  int32_T iv0;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  iv0 = static_cast<int32_T>(threadId);
  if (iv0 < 2) {
    rhs[iv0] = b2.data[iv0 + 1] - *val * a2.data[iv0 + 1];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel68(int8_T b_I
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel69(int8_T b_I
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel7(int32_T
  coef, int32_T y_data[134217726])
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
    y_data[iv0] = iv0 + 2;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel70(const
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel71(const
  real_T A[4], const real_T *val, const int32_T ns, const real_T rhs[2], const
  int32_T ny, real_T Y[2])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    Y[1] = (rhs[ny] - rhs[ns] * *val) / (A[ny + 2] - *val * A[ns + 2]);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel72(const
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel73(const
  real_T Y[2], real_T zi_data[134217727])
{
  uint64_T threadId;
  int32_T iv0;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  iv0 = static_cast<int32_T>(threadId);
  if (iv0 < 2) {
    zi_data[iv0] = Y[iv0];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel74(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel75(const
  emxArray_real_T xCol, int32_T b_xCol, const int32_T xCol_dim0, emxArray_real_T
  y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_xCol);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    y.data[iv0] = 2.0 * xCol.data[xCol_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel76(const
  emxArray_real_T xCol, const emxArray_real_T y, const real_T nfact, const
  int32_T ny, const int32_T ns, const int32_T xt, int32_T vlen, const int32_T
  xt_dim0, const int32_T xCol_dim0, emxArray_real_T b_xt)
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
    b_xt.data[i + xt_dim0 * m] = y.data[ns * m] - xCol.data
      [((static_cast<int32_T>(nfact + 1.0) - (static_cast<int32_T>(nfact + 1.0)
          - 1 != 1) * i) + xCol_dim0 * (ny * m)) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel77(const
  emxArray_real_T xt, const real_T zi_data[134217727], const int32_T zi_size,
  int32_T idx, const int32_T y_dim0, const int32_T xt_dim0, emxArray_real_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(zi_size) + 1UL) * (static_cast<uint64_T>(idx)
    + 1UL) - 1UL;
  for (uint64_T b_idx{threadId}; b_idx <= loopEnd; b_idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(b_idx % (static_cast<uint64_T>(zi_size) + 1UL));
    iv0 = static_cast<int32_T>((b_idx - static_cast<uint64_T>(ix)) / (
      static_cast<uint64_T>(zi_size) + 1UL));
    y.data[ix + y_dim0 * iv0] = zi_data[ix] * xt.data[xt_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel78(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel79(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel8(int32_T
  coef, int32_T counts_data[134217727])
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
    counts_data[iv0] = iv0 + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel80(const
  emxArray_real_T xt, const real_T zi_data[134217727], const int32_T zi_size,
  int32_T idx, const int32_T xt_dim0, const int32_T zi_dim0, emxArray_real_T zi)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(zi_size) + 1UL) * (static_cast<uint64_T>(idx)
    + 1UL) - 1UL;
  for (uint64_T b_idx{threadId}; b_idx <= loopEnd; b_idx += threadStride) {
    real_T cv;
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(b_idx % (static_cast<uint64_T>(zi_size) + 1UL));
    iv0 = static_cast<int32_T>((b_idx - static_cast<uint64_T>(ix)) / (
      static_cast<uint64_T>(zi_size) + 1UL));
    cv = zi_data[ix] * xt.data[xt_dim0 * iv0];
    zi.data[ix + zi_dim0 * iv0] = cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel81(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel82(const
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel83
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel84(const
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

static __global__ __launch_bounds__(32, 1) void ec_filtfilt_kernel85(const
  int32_T b_dim0, uint32_T dv1[2])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    dv1[0] = static_cast<uint32_T>(b_dim0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel86(int32_T c,
  emxArray_real_T expanded)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    iv0 = static_cast<int32_T>(idx);
    expanded.data[iv0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel87(const
  int32_T offsetH, const emxArray_int32_T y, int32_T b_y, emxArray_int32_T iv3)
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
    if ((offsetH < 0) && (i < MIN_int32_T - offsetH)) {
      i = MIN_int32_T;
    } else if ((offsetH > 0) && (i > MAX_int32_T - offsetH)) {
      i = MAX_int32_T;
    } else {
      i += offsetH;
    }

    iv3.data[iv0] = i - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel88(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel89(const
  emxArray_real_T xt, const emxArray_int32_T iv4, const emxArray_int32_T iv3,
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
    expanded.data[iv3.data[ix] + expanded_dim0 * iv4.data[iv0]] = xt.data[ix +
      xt_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel9(int32_T
  idx, emxArray_int32_T rows)
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
    rows.data[iv0] = iv0 + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel90(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T b,
  const int32_T c, int32_T zfSize_idx_0, const int32_T b_dim0, const int32_T
  convOut_dim0, const int32_T expanded_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = mwGetGlobalThreadIndex();
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c - 1) + 1UL) * (static_cast<uint64_T>
    (zfSize_idx_0) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T cv;
    int32_T iv0;
    int32_T ix;
    iv0 = static_cast<int32_T>(idx % (static_cast<uint64_T>(c - 1) + 1UL));
    ix = static_cast<int32_T>((idx - static_cast<uint64_T>(iv0)) / (static_cast<
      uint64_T>(c - 1) + 1UL));
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel91(const
  emxArray_real_T zi, const emxArray_real_T convOut, const int32_T ns, int32_T
  b_convOut, const int32_T convOut_dim0, const int32_T b_convOut_dim0, const
  int32_T zi_dim0, emxArray_real_T c_convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(ns) + 1UL) * (static_cast<uint64_T>(b_convOut)
    + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(ns) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) / (static_cast<
      uint64_T>(ns) + 1UL));
    c_convOut.data[ix + convOut_dim0 * iv0] = convOut.data[ix + b_convOut_dim0 *
      iv0] + zi.data[ix + zi_dim0 * iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel92(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel93(const
  emxArray_real_T y, const int32_T zi, int32_T ns, const int32_T convOut_dim0,
  emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(zi) + 1UL) * (static_cast<uint64_T>(ns) + 1UL)
    - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T m;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(zi) + 1UL));
    m = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
      (static_cast<uint64_T>(zi) + 1UL));
    convOut.data[i + convOut_dim0 * m] += y.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel94(const
  emxArray_real_T y, const int32_T zi, int32_T ns, const int32_T convOut_dim0,
  const int32_T y_dim0, emxArray_real_T convOut)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(zi) + 1UL) * (static_cast<uint64_T>(ns) + 1UL)
    - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T i;
    int32_T m;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(zi) + 1UL));
    m = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
      (static_cast<uint64_T>(zi) + 1UL));
    convOut.data[i + convOut_dim0 * m] += y.data[y_dim0 * i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel95(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel96(const
  emxArray_real_T convOut, const int32_T ns, const int32_T ny, int32_T b_convOut,
  const int32_T zfIIR_dim0, const int32_T convOut_dim0, emxArray_real_T zfIIR)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(ny - ns) + 1UL) * (static_cast<uint64_T>
    (b_convOut) + 1UL) - 1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T iv0;
    int32_T ix;
    ix = static_cast<int32_T>(idx % (static_cast<uint64_T>(ny - ns) + 1UL));
    iv0 = static_cast<int32_T>((idx - static_cast<uint64_T>(ix)) / (static_cast<
      uint64_T>(ny - ns) + 1UL));
    zfIIR.data[ix + zfIIR_dim0 * iv0] = convOut.data[(ns + ix) + convOut_dim0 *
      iv0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel97(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel98(const
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

static __global__ __launch_bounds__(1024, 1) void ec_filtfilt_kernel99(const
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

static void ec_filtfilt_once()
{
  mwMemoryManagerInit(256U, 2U, 8U, 2048U);
}

static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y)
{
  c_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, char_T y[14])
{
  b_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
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

void ec_filtfilt(ec_filtfiltStackData *SD, emxArray_real_T *x, const
                 emxArray_real_T *coef)
{
  static const int32_T iv7[2]{ 1, 6 };

  static const char_T rfmt[6]{ '%', '1', '4', '.', '6', 'e' };

  dim3 block;
  dim3 grid;
  dim3 r;
  dim3 r1;
  emxArray_boolean_T b_gpu_x;
  emxArray_boolean_T c_gpu_x;
  emxArray_boolean_T *b_x;
  emxArray_boolean_T *c_x;
  emxArray_int32_T b_gpu_rows;
  emxArray_int32_T b_gpu_t;
  emxArray_int32_T b_gpu_y_colidx;
  emxArray_int32_T b_gpu_y_rowidx;
  emxArray_int32_T c_gpu_rows;
  emxArray_int32_T c_gpu_y_colidx;
  emxArray_int32_T c_gpu_y_rowidx;
  emxArray_int32_T d_gpu_rows;
  emxArray_int32_T d_gpu_y;
  emxArray_int32_T d_gpu_y_rowidx;
  emxArray_int32_T e_gpu_rows;
  emxArray_int32_T e_gpu_y;
  emxArray_int32_T f_gpu_rows;
  emxArray_int32_T f_gpu_y;
  emxArray_int32_T g_gpu_rows;
  emxArray_int32_T gpu_cidxInt;
  emxArray_int32_T gpu_cols;
  emxArray_int32_T gpu_iv1;
  emxArray_int32_T gpu_iv10;
  emxArray_int32_T gpu_iv11;
  emxArray_int32_T gpu_iv12;
  emxArray_int32_T gpu_iv13;
  emxArray_int32_T gpu_iv14;
  emxArray_int32_T gpu_iv15;
  emxArray_int32_T gpu_iv16;
  emxArray_int32_T gpu_iv17;
  emxArray_int32_T gpu_iv18;
  emxArray_int32_T gpu_iv2;
  emxArray_int32_T gpu_iv3;
  emxArray_int32_T gpu_iv4;
  emxArray_int32_T gpu_iv5;
  emxArray_int32_T gpu_iv6;
  emxArray_int32_T gpu_iv8;
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
  emxArray_int32_T i_gpu_y;
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
  emxArray_int32_T r_gpu_y;
  emxArray_int32_T s_gpu_y;
  emxArray_int32_T t_gpu_y;
  emxArray_int32_T u_gpu_y;
  emxArray_int32_T v_gpu_y;
  emxArray_int32_T w_gpu_y;
  emxArray_int32_T *b_rows;
  emxArray_int32_T *b_t;
  emxArray_int32_T *b_y_colidx;
  emxArray_int32_T *b_y_rowidx;
  emxArray_int32_T *c_rows;
  emxArray_int32_T *c_y_colidx;
  emxArray_int32_T *c_y_rowidx;
  emxArray_int32_T *cidxInt;
  emxArray_int32_T *cols;
  emxArray_int32_T *d_rows;
  emxArray_int32_T *d_y;
  emxArray_int32_T *d_y_colidx;
  emxArray_int32_T *d_y_rowidx;
  emxArray_int32_T *e_rows;
  emxArray_int32_T *e_y;
  emxArray_int32_T *f_rows;
  emxArray_int32_T *f_y;
  emxArray_int32_T *g_rows;
  emxArray_int32_T *g_y;
  emxArray_int32_T *h_rows;
  emxArray_int32_T *i_rows;
  emxArray_int32_T *i_y;
  emxArray_int32_T *iv1;
  emxArray_int32_T *iv10;
  emxArray_int32_T *iv11;
  emxArray_int32_T *iv12;
  emxArray_int32_T *iv13;
  emxArray_int32_T *iv14;
  emxArray_int32_T *iv15;
  emxArray_int32_T *iv16;
  emxArray_int32_T *iv17;
  emxArray_int32_T *iv18;
  emxArray_int32_T *iv2;
  emxArray_int32_T *iv3;
  emxArray_int32_T *iv4;
  emxArray_int32_T *iv5;
  emxArray_int32_T *iv6;
  emxArray_int32_T *iv8;
  emxArray_int32_T *iv9;
  emxArray_int32_T *j_rows;
  emxArray_int32_T *k_rows;
  emxArray_int32_T *k_y;
  emxArray_int32_T *l_rows;
  emxArray_int32_T *l_y;
  emxArray_int32_T *m_rows;
  emxArray_int32_T *m_y;
  emxArray_int32_T *o_y;
  emxArray_int32_T *p_y;
  emxArray_int32_T *q_y;
  emxArray_int32_T *r_y;
  emxArray_int32_T *ridxInt;
  emxArray_int32_T *rows;
  emxArray_int32_T *s_y;
  emxArray_int32_T *sortedIndices;
  emxArray_int32_T *t;
  emxArray_int32_T *t_y;
  emxArray_int32_T *u_y;
  emxArray_int32_T *v_y;
  emxArray_int32_T *w_y;
  emxArray_int32_T *y_colidx;
  emxArray_int32_T *y_rowidx;
  emxArray_int8_T gpu_vals;
  emxArray_int8_T *vals;
  emxArray_real_T b_gpu_a;
  emxArray_real_T b_gpu_b;
  emxArray_real_T b_gpu_convOut;
  emxArray_real_T b_gpu_expanded;
  emxArray_real_T b_gpu_y;
  emxArray_real_T b_gpu_y_d;
  emxArray_real_T b_gpu_zfIIR;
  emxArray_real_T b_gpu_zi;
  emxArray_real_T c_gpu_a;
  emxArray_real_T c_gpu_b;
  emxArray_real_T c_gpu_convOut;
  emxArray_real_T c_gpu_expanded;
  emxArray_real_T c_gpu_y;
  emxArray_real_T c_gpu_y_d;
  emxArray_real_T c_gpu_zfIIR;
  emxArray_real_T d_gpu_a;
  emxArray_real_T d_gpu_b;
  emxArray_real_T d_gpu_convOut;
  emxArray_real_T d_gpu_expanded;
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
  emxArray_real_T f_gpu_zfIIR;
  emxArray_real_T g_gpu_a;
  emxArray_real_T g_gpu_b;
  emxArray_real_T g_gpu_convOut;
  emxArray_real_T g_gpu_expanded;
  emxArray_real_T g_gpu_y;
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
  emxArray_real_T gpu_x;
  emxArray_real_T gpu_xCol;
  emxArray_real_T gpu_xt;
  emxArray_real_T gpu_y;
  emxArray_real_T gpu_y_d;
  emxArray_real_T gpu_yc2;
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
  emxArray_real_T *b_y;
  emxArray_real_T *b_y_d;
  emxArray_real_T *b_zfIIR;
  emxArray_real_T *b_zi;
  emxArray_real_T *c_a;
  emxArray_real_T *c_b;
  emxArray_real_T *c_convOut;
  emxArray_real_T *c_expanded;
  emxArray_real_T *c_y;
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
  emxArray_real_T *f_zfIIR;
  emxArray_real_T *g_a;
  emxArray_real_T *g_b;
  emxArray_real_T *g_convOut;
  emxArray_real_T *g_expanded;
  emxArray_real_T *h_a;
  emxArray_real_T *h_b;
  emxArray_real_T *h_convOut;
  emxArray_real_T *h_expanded;
  emxArray_real_T *h_y;
  emxArray_real_T *i_a;
  emxArray_real_T *i_b;
  emxArray_real_T *i_convOut;
  emxArray_real_T *i_expanded;
  emxArray_real_T *j_a;
  emxArray_real_T *j_b;
  emxArray_real_T *j_convOut;
  emxArray_real_T *j_expanded;
  emxArray_real_T *j_y;
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
  emxArray_real_T *p_convOut;
  emxArray_real_T *q_convOut;
  emxArray_real_T *r_convOut;
  emxArray_real_T *s_convOut;
  emxArray_real_T *t_convOut;
  emxArray_real_T *u_convOut;
  emxArray_real_T *xCol;
  emxArray_real_T *xt;
  emxArray_real_T *y;
  emxArray_real_T *y_d;
  emxArray_real_T *yc2;
  emxArray_real_T *yc5;
  emxArray_real_T *ytemp;
  emxArray_real_T *zfIIR;
  emxArray_real_T *zi;
  const mxArray *m;
  const mxArray *x_y;
  const mxArray *y_y;
  real_T (*gpu_outBuff_data)[134217727];
  real_T (*gpu_rhs_data)[134217727];
  real_T (*gpu_zi_data)[134217727];
  real_T A[4];
  real_T (*gpu_A)[4];
  real_T (*gpu_a0)[3];
  real_T (*gpu_Y)[2];
  real_T (*gpu_rhs)[2];
  real_T d1;
  real_T val;
  real_T *b_gpu_a1;
  real_T *c_gpu_a1;
  real_T *d_gpu_a1;
  real_T *e_gpu_a1;
  real_T *gpu_a1;
  real_T *gpu_d1;
  real_T *gpu_val;
  int32_T (*gpu_counts_data)[134217727];
  int32_T (*b_gpu_y_data)[134217726];
  int32_T (*gpu_y_data)[134217726];
  int32_T b_y_size[2];
  int32_T y_size[2];
  int32_T ii_data[1];
  int32_T zi_size[1];
  uint32_T dv1[2];
  uint32_T zfSize[2];
  uint32_T (*gpu_dv1)[2];
  uint32_T (*gpu_zfSize)[2];
  uint32_T nZeroLastDen_data[1];
  uint32_T (*gpu_nZeroLastDen_data)[1];
  int8_T (*gpu_I)[4];
  boolean_T a_dirtyOnGpu;
  boolean_T b_a_dirtyOnGpu;
  boolean_T b_b_dirtyOnCpu;
  boolean_T b_b_dirtyOnGpu;
  boolean_T b_convOut_dirtyOnCpu;
  boolean_T b_convOut_dirtyOnGpu;
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
  boolean_T c_x_dirtyOnGpu;
  boolean_T c_y_d_dirtyOnGpu;
  boolean_T c_y_rowidx_dirtyOnGpu;
  boolean_T c_zfIIR_dirtyOnGpu;
  boolean_T cidxInt_dirtyOnGpu;
  boolean_T coef_dirtyOnCpu;
  boolean_T convOut_dirtyOnCpu;
  boolean_T convOut_dirtyOnGpu;
  boolean_T counts_data_dirtyOnCpu;
  boolean_T counts_data_dirtyOnGpu;
  boolean_T d_a_dirtyOnGpu;
  boolean_T d_b_dirtyOnCpu;
  boolean_T d_b_dirtyOnGpu;
  boolean_T d_convOut_dirtyOnCpu;
  boolean_T d_convOut_dirtyOnGpu;
  boolean_T d_y_d_dirtyOnGpu;
  boolean_T d_y_rowidx_dirtyOnGpu;
  boolean_T dv1_dirtyOnCpu;
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
  boolean_T outBuff_data_dirtyOnCpu;
  boolean_T ridxInt_dirtyOnGpu;
  boolean_T val_dirtyOnCpu;
  boolean_T xCol_dirtyOnGpu;
  boolean_T x_dirtyOnCpu;
  boolean_T x_dirtyOnGpu;
  boolean_T y_d_dirtyOnGpu;
  boolean_T y_rowidx_dirtyOnGpu;
  boolean_T ytemp_dirtyOnCpu;
  boolean_T ytemp_dirtyOnGpu;
  boolean_T zfIIR_dirtyOnGpu;
  boolean_T zfSize_dirtyOnCpu;
  boolean_T zi_data_dirtyOnCpu;
  boolean_T zi_dirtyOnGpu;
  gpuEmxReset_real_T(&u_gpu_convOut);
  gpuEmxReset_real_T(&t_gpu_convOut);
  gpuEmxReset_int32_T(&m_gpu_rows);
  gpuEmxReset_int32_T(&gpu_iv18);
  gpuEmxReset_int32_T(&w_gpu_y);
  gpuEmxReset_real_T(&l_gpu_expanded);
  gpuEmxReset_real_T(&l_gpu_a);
  gpuEmxReset_real_T(&n_gpu_b);
  gpuEmxReset_real_T(&f_gpu_zfIIR);
  gpuEmxReset_real_T(&s_gpu_convOut);
  gpuEmxReset_int32_T(&l_gpu_rows);
  gpuEmxReset_int32_T(&gpu_iv17);
  gpuEmxReset_int32_T(&v_gpu_y);
  gpuEmxReset_real_T(&r_gpu_convOut);
  gpuEmxReset_real_T(&q_gpu_convOut);
  gpuEmxReset_real_T(&k_gpu_expanded);
  gpuEmxReset_real_T(&e_gpu_zfIIR);
  gpuEmxReset_real_T(&p_gpu_convOut);
  gpuEmxReset_int32_T(&k_gpu_rows);
  gpuEmxReset_real_T(&o_gpu_convOut);
  gpuEmxReset_real_T(&k_gpu_a);
  gpuEmxReset_real_T(&m_gpu_b);
  gpuEmxReset_real_T(&n_gpu_convOut);
  gpuEmxReset_int32_T(&j_gpu_rows);
  gpuEmxReset_int32_T(&gpu_iv16);
  gpuEmxReset_int32_T(&u_gpu_y);
  gpuEmxReset_real_T(&m_gpu_convOut);
  gpuEmxReset_int32_T(&i_gpu_rows);
  gpuEmxReset_int32_T(&gpu_iv15);
  gpuEmxReset_int32_T(&t_gpu_y);
  gpuEmxReset_int32_T(&gpu_iv14);
  gpuEmxReset_int32_T(&s_gpu_y);
  gpuEmxReset_real_T(&l_gpu_convOut);
  gpuEmxReset_real_T(&k_gpu_convOut);
  gpuEmxReset_int32_T(&gpu_iv12);
  gpuEmxReset_int32_T(&r_gpu_y);
  gpuEmxReset_real_T(&j_gpu_expanded);
  gpuEmxReset_int32_T(&gpu_iv13);
  gpuEmxReset_int32_T(&q_gpu_y);
  gpuEmxReset_real_T(&gpu_yc2);
  gpuEmxReset_real_T(&j_gpu_convOut);
  gpuEmxReset_int32_T(&h_gpu_rows);
  gpuEmxReset_real_T(&i_gpu_expanded);
  gpuEmxReset_real_T(&gpu_yc5);
  gpuEmxReset_real_T(&i_gpu_convOut);
  gpuEmxReset_real_T(&h_gpu_expanded);
  gpuEmxReset_real_T(&j_gpu_a);
  gpuEmxReset_real_T(&i_gpu_a);
  gpuEmxReset_int32_T(&gpu_iv11);
  gpuEmxReset_int32_T(&p_gpu_y);
  gpuEmxReset_real_T(&l_gpu_b);
  gpuEmxReset_real_T(&d_gpu_zfIIR);
  gpuEmxReset_real_T(&k_gpu_b);
  gpuEmxReset_real_T(&h_gpu_convOut);
  gpuEmxReset_int32_T(&gpu_iv10);
  gpuEmxReset_int32_T(&o_gpu_y);
  gpuEmxReset_real_T(&b_gpu_zi);
  gpuEmxReset_real_T(&c_gpu_zfIIR);
  gpuEmxReset_real_T(&g_gpu_convOut);
  gpuEmxReset_int32_T(&g_gpu_rows);
  gpuEmxReset_real_T(&h_gpu_a);
  gpuEmxReset_real_T(&b_gpu_zfIIR);
  gpuEmxReset_real_T(&g_gpu_expanded);
  gpuEmxReset_real_T(&f_gpu_convOut);
  gpuEmxReset_int32_T(&f_gpu_rows);
  gpuEmxReset_real_T(&j_gpu_b);
  gpuEmxReset_real_T(&e_gpu_convOut);
  gpuEmxReset_real_T(&d_gpu_convOut);
  gpuEmxReset_int32_T(&e_gpu_rows);
  gpuEmxReset_real_T(&n_gpu_y);
  gpuEmxReset_real_T(&m_gpu_y);
  gpuEmxReset_int32_T(&c_gpu_y_colidx);
  gpuEmxReset_int32_T(&gpu_iv6);
  gpuEmxReset_int32_T(&l_gpu_y);
  gpuEmxReset_real_T(&c_gpu_convOut);
  gpuEmxReset_int32_T(&d_gpu_rows);
  gpuEmxReset_real_T(&d_gpu_y_d);
  gpuEmxReset_int32_T(&d_gpu_y_rowidx);
  gpuEmxReset_int32_T(&gpu_iv8);
  gpuEmxReset_int32_T(&k_gpu_y);
  gpuEmxReset_int32_T(&gpu_iv9);
  gpuEmxReset_int32_T(&j_gpu_y);
  gpuEmxReset_int32_T(&b_gpu_y_colidx);
  gpuEmxReset_int32_T(&gpu_y_colidx);
  gpuEmxReset_real_T(&c_gpu_y_d);
  gpuEmxReset_int32_T(&c_gpu_y_rowidx);
  gpuEmxReset_real_T(&b_gpu_y_d);
  gpuEmxReset_int32_T(&b_gpu_y_rowidx);
  gpuEmxReset_real_T(&g_gpu_a);
  gpuEmxReset_int32_T(&gpu_iv5);
  gpuEmxReset_int32_T(&i_gpu_y);
  gpuEmxReset_real_T(&f_gpu_expanded);
  gpuEmxReset_real_T(&i_gpu_b);
  gpuEmxReset_real_T(&e_gpu_expanded);
  gpuEmxReset_int32_T(&gpu_iv4);
  gpuEmxReset_int32_T(&h_gpu_y);
  gpuEmxReset_real_T(&d_gpu_expanded);
  gpuEmxReset_real_T(&gpu_y_d);
  gpuEmxReset_int32_T(&gpu_y_rowidx);
  gpuEmxReset_real_T(&g_gpu_y);
  gpuEmxReset_real_T(&f_gpu_a);
  gpuEmxReset_int32_T(&gpu_iv3);
  gpuEmxReset_int32_T(&f_gpu_y);
  gpuEmxReset_real_T(&e_gpu_a);
  gpuEmxReset_real_T(&h_gpu_b);
  gpuEmxReset_real_T(&g_gpu_b);
  gpuEmxReset_real_T(&c_gpu_expanded);
  gpuEmxReset_int32_T(&b_gpu_t);
  gpuEmxReset_real_T(&gpu_zfIIR);
  gpuEmxReset_real_T(&gpu_dv3);
  gpuEmxReset_real_T(&d_gpu_a);
  gpuEmxReset_int32_T(&gpu_t);
  gpuEmxReset_real_T(&f_gpu_b);
  gpuEmxReset_real_T(&b_gpu_convOut);
  gpuEmxReset_int32_T(&c_gpu_rows);
  gpuEmxReset_real_T(&gpu_convOut);
  gpuEmxReset_int32_T(&b_gpu_rows);
  gpuEmxReset_int32_T(&gpu_sortedIndices);
  mwCudaMalloc(&gpu_dv1, 8UL);
  gpuEmxReset_int32_T(&gpu_cidxInt);
  mwCudaMalloc(&gpu_zfSize, 8UL);
  gpuEmxReset_int32_T(&gpu_ridxInt);
  gpuEmxReset_real_T(&gpu_zi);
  gpuEmxReset_int32_T(&gpu_iv2);
  gpuEmxReset_int32_T(&e_gpu_y);
  gpuEmxReset_int32_T(&gpu_iv1);
  gpuEmxReset_int32_T(&d_gpu_y);
  gpuEmxReset_real_T(&c_gpu_a);
  mwCudaMalloc(&gpu_Y, 16UL);
  gpuEmxReset_real_T(&e_gpu_b);
  gpuEmxReset_real_T(&b_gpu_expanded);
  gpuEmxReset_real_T(&gpu_expanded);
  mwCudaMalloc(&gpu_A, 32UL);
  gpuEmxReset_real_T(&c_gpu_y);
  mwCudaMalloc(&gpu_I, 4UL);
  gpuEmxReset_int8_T(&gpu_vals);
  mwCudaMalloc(&gpu_rhs, 16UL);
  gpuEmxReset_real_T(&gpu_xt);
  mwCudaMalloc(&gpu_a0, 24UL);
  gpuEmxReset_real_T(&b_gpu_a);
  mwCudaMalloc(&gpu_nZeroLastDen_data, 4UL);
  gpuEmxReset_real_T(&gpu_a);
  gpuEmxReset_int32_T(&gpu_cols);
  gpuEmxReset_real_T(&d_gpu_b);
  mwCudaMalloc(&b_gpu_y_data, 536870904UL);
  gpuEmxReset_real_T(&c_gpu_b);
  gpuEmxReset_real_T(&b_gpu_y);
  gpuEmxReset_boolean_T(&c_gpu_x);
  mwCudaMalloc(&gpu_outBuff_data, 1073741816UL);
  mwCudaMalloc(&gpu_zi_data, 1073741816UL);
  mwCudaMalloc(&gpu_val, 8UL);
  mwCudaMalloc(&gpu_rhs_data, 1073741816UL);
  gpuEmxReset_real_T(&gpu_ytemp);
  gpuEmxReset_boolean_T(&b_gpu_x);
  gpuEmxReset_int32_T(&gpu_rows);
  mwCudaMalloc(&gpu_d1, 8UL);
  gpuEmxReset_real_T(&gpu_maxCoefNum);
  mwCudaMalloc(&gpu_counts_data, 536870908UL);
  mwCudaMalloc(&e_gpu_a1, 8UL);
  mwCudaMalloc(&d_gpu_a1, 8UL);
  mwCudaMalloc(&c_gpu_a1, 8UL);
  mwCudaMalloc(&gpu_y_data, 536870904UL);
  mwCudaMalloc(&b_gpu_a1, 8UL);
  mwCudaMalloc(&gpu_a1, 8UL);
  gpuEmxReset_real_T(&gpu_y);
  gpuEmxReset_real_T(&gpu_a2);
  gpuEmxReset_real_T(&b_gpu_b);
  gpuEmxReset_real_T(&gpu_b1);
  gpuEmxReset_real_T(&gpu_b2);
  gpuEmxReset_real_T(&gpu_b);
  gpuEmxReset_real_T(&gpu_coef);
  gpuEmxReset_real_T(&gpu_xCol);
  gpuEmxReset_real_T(&gpu_x);
  l_convOut_dirtyOnGpu = false;
  g_a_dirtyOnGpu = false;
  l_b_dirtyOnGpu = false;
  k_convOut_dirtyOnGpu = false;
  c_zfIIR_dirtyOnGpu = false;
  j_convOut_dirtyOnGpu = false;
  f_a_dirtyOnGpu = false;
  k_b_dirtyOnGpu = false;
  i_convOut_dirtyOnGpu = false;
  h_convOut_dirtyOnGpu = false;
  g_convOut_dirtyOnGpu = false;
  e_a_dirtyOnGpu = false;
  j_b_dirtyOnGpu = false;
  b_zfIIR_dirtyOnGpu = false;
  i_b_dirtyOnGpu = false;
  b_zi_dirtyOnGpu = false;
  f_convOut_dirtyOnGpu = false;
  zfIIR_dirtyOnGpu = false;
  e_convOut_dirtyOnGpu = false;
  h_b_dirtyOnGpu = false;
  d_convOut_dirtyOnGpu = false;
  c_convOut_dirtyOnGpu = false;
  d_y_d_dirtyOnGpu = false;
  d_y_rowidx_dirtyOnGpu = false;
  c_y_d_dirtyOnGpu = false;
  c_y_rowidx_dirtyOnGpu = false;
  b_y_d_dirtyOnGpu = false;
  b_y_rowidx_dirtyOnGpu = false;
  g_b_dirtyOnGpu = false;
  y_d_dirtyOnGpu = false;
  y_rowidx_dirtyOnGpu = false;
  d_a_dirtyOnGpu = false;
  c_a_dirtyOnGpu = false;
  f_b_dirtyOnGpu = false;
  e_b_dirtyOnGpu = false;
  dv3_dirtyOnGpu = false;
  d_b_dirtyOnGpu = false;
  b_convOut_dirtyOnGpu = false;
  convOut_dirtyOnGpu = false;
  cidxInt_dirtyOnGpu = false;
  ridxInt_dirtyOnGpu = false;
  zi_dirtyOnGpu = false;
  c_b_dirtyOnGpu = false;
  b_a_dirtyOnGpu = false;
  nZeroLastDen_data_dirtyOnGpu = false;
  a_dirtyOnGpu = false;
  b_b_dirtyOnGpu = false;
  b_dirtyOnGpu = false;
  c_x_dirtyOnGpu = false;
  ytemp_dirtyOnGpu = false;
  b_x_dirtyOnGpu = false;
  maxCoefNum_dirtyOnGpu = false;
  counts_data_dirtyOnGpu = false;
  xCol_dirtyOnGpu = false;
  l_convOut_dirtyOnCpu = false;
  l_b_dirtyOnCpu = false;
  k_convOut_dirtyOnCpu = false;
  j_convOut_dirtyOnCpu = false;
  k_b_dirtyOnCpu = false;
  i_convOut_dirtyOnCpu = false;
  h_convOut_dirtyOnCpu = false;
  g_convOut_dirtyOnCpu = false;
  j_b_dirtyOnCpu = false;
  i_b_dirtyOnCpu = false;
  f_convOut_dirtyOnCpu = false;
  e_convOut_dirtyOnCpu = false;
  h_b_dirtyOnCpu = false;
  d_convOut_dirtyOnCpu = false;
  c_convOut_dirtyOnCpu = false;
  g_b_dirtyOnCpu = false;
  f_b_dirtyOnCpu = false;
  e_b_dirtyOnCpu = false;
  d_b_dirtyOnCpu = false;
  b_convOut_dirtyOnCpu = false;
  convOut_dirtyOnCpu = false;
  dv1_dirtyOnCpu = false;
  zfSize_dirtyOnCpu = false;
  c_b_dirtyOnCpu = false;
  b_b_dirtyOnCpu = false;
  b_dirtyOnCpu = false;
  outBuff_data_dirtyOnCpu = false;
  zi_data_dirtyOnCpu = false;
  val_dirtyOnCpu = false;
  ytemp_dirtyOnCpu = false;
  counts_data_dirtyOnCpu = false;
  coef_dirtyOnCpu = true;
  x_dirtyOnGpu = false;
  x_dirtyOnCpu = true;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);

  //  Add kernelfun pragma to trigger kernel creation
  //  Zero-phase filtering
  emxInit_real_T(&xCol, 2, &c_emlrtRTEI, true);
  emxInit_real_T(&b, 2, &d_emlrtRTEI, true);
  emxInit_real_T(&b2, 1, &vb_emlrtRTEI, true);
  emxInit_real_T(&a2, 1, &vb_emlrtRTEI, true);
  emxInit_real_T(&b1, 2, &i_emlrtRTEI, true);
  emxInit_real_T(&y, 2, &wb_emlrtRTEI, true);
  emxInit_boolean_T(&b_x, 1, &r_emlrtRTEI, true);
  emxInit_int32_T(&rows, 2, &n_emlrtRTEI, true);
  emxInit_real_T(&maxCoefNum, 1, &xb_emlrtRTEI, true);
  emxInit_boolean_T(&c_x, 1, &o_emlrtRTEI, true);
  emxInit_real_T(&b_y, 2, &yb_emlrtRTEI, true);
  emxInit_int32_T(&cols, 2, &w_emlrtRTEI, true);
  emxInit_real_T(&b_b, 1, &v_emlrtRTEI, true);
  emxInit_real_T(&a, 1, &v_emlrtRTEI, true);
  emxInit_real_T(&ytemp, 1, &q_emlrtRTEI, true);
  emxInit_real_T(&c_b, 1, &u_emlrtRTEI, true);
  emxInit_real_T(&xt, 2, &ac_emlrtRTEI, true);
  emxInit_real_T(&b_a, 1, &u_emlrtRTEI, true);
  emxInit_int8_T(&vals, 2, &eb_emlrtRTEI, true);
  emxInit_real_T(&c_y, 2, &gb_emlrtRTEI, true);
  emxInit_real_T(&d_b, 1, &db_emlrtRTEI, true);
  emxInit_real_T(&c_a, 1, &db_emlrtRTEI, true);
  emxInit_real_T(&zi, 2, &gb_emlrtRTEI, true);
  emxInit_real_T(&y_d, 1, &bc_emlrtRTEI, true);
  emxInit_int32_T(&y_colidx, 1, &bc_emlrtRTEI, true);
  emxInit_int32_T(&y_rowidx, 1, &bc_emlrtRTEI, true);
  emxInit_int32_T(&ridxInt, 1, &cc_emlrtRTEI, true);
  emxInit_real_T(&expanded, 1, &fb_emlrtRTEI, true);
  emxInit_int32_T(&d_y, 2, &fb_emlrtRTEI, true);
  emxInit_real_T(&b_expanded, 1, &fb_emlrtRTEI, true);
  emxInit_int32_T(&e_y, 2, &fb_emlrtRTEI, true);
  emxInit_int32_T(&cidxInt, 1, &dc_emlrtRTEI, true);
  emxInit_real_T(&e_b, 1, &db_emlrtRTEI, true);
  emxInit_int32_T(&iv1, 1, &vb_emlrtRTEI, true);
  emxInit_int32_T(&sortedIndices, 1, &ec_emlrtRTEI, true);
  emxInit_real_T(&d_a, 1, &db_emlrtRTEI, true);
  emxInit_int32_T(&iv2, 1, &vb_emlrtRTEI, true);
  emxInit_int32_T(&b_rows, 2, &fb_emlrtRTEI, true);
  emxInit_int32_T(&c_rows, 2, &fb_emlrtRTEI, true);
  emxInit_real_T(&c_expanded, 2, &fb_emlrtRTEI, true);
  emxInit_int32_T(&t, 1, &kb_emlrtRTEI, true);
  emxInit_int32_T(&f_y, 2, &fb_emlrtRTEI, true);
  emxInit_real_T(&convOut, 1, &ab_emlrtRTEI, true);
  emxInit_int32_T(&b_t, 1, &kb_emlrtRTEI, true);
  emxInit_real_T(&b_convOut, 1, &ab_emlrtRTEI, true);
  emxInit_int32_T(&iv3, 1, &vb_emlrtRTEI, true);
  emxInit_int32_T(&g_y, 2, &fb_emlrtRTEI, true);
  emxInit_real_T(&yc2, 2, &vb_emlrtRTEI, true);
  emxInit_real_T(&h_y, 2, &fc_emlrtRTEI, true);
  emxInit_real_T(&dv3, 1, &vb_emlrtRTEI, true);
  emxInit_real_T(&zfIIR, 1, &ab_emlrtRTEI, true);
  emxInit_int32_T(&iv4, 1, &vb_emlrtRTEI, true);
  emxInit_real_T(&d_expanded, 2, &fb_emlrtRTEI, true);
  emxInit_int32_T(&i_y, 2, &fb_emlrtRTEI, true);
  emxInit_int32_T(&d_rows, 2, &fb_emlrtRTEI, true);
  emxInit_real_T(&f_b, 1, &u_emlrtRTEI, true);
  emxInit_real_T(&g_b, 1, &v_emlrtRTEI, true);
  emxInit_real_T(&e_a, 1, &u_emlrtRTEI, true);
  emxInit_real_T(&f_a, 1, &v_emlrtRTEI, true);
  emxInit_real_T(&j_y, 2, &gc_emlrtRTEI, true);
  emxInit_real_T(&c_convOut, 2, &ab_emlrtRTEI, true);
  emxInit_int32_T(&iv5, 1, &vb_emlrtRTEI, true);
  emxInit_real_T(&h_b, 1, &db_emlrtRTEI, true);
  emxInit_int32_T(&k_y, 2, &fb_emlrtRTEI, true);
  emxInit_real_T(&g_a, 1, &db_emlrtRTEI, true);
  emxInit_real_T(&b_y_d, 1, &hc_emlrtRTEI, true);
  emxInit_real_T(&c_y_d, 1, &hc_emlrtRTEI, true);
  emxInit_int32_T(&b_y_colidx, 1, &hc_emlrtRTEI, true);
  emxInit_int32_T(&c_y_colidx, 1, &hc_emlrtRTEI, true);
  emxInit_int32_T(&b_y_rowidx, 1, &hc_emlrtRTEI, true);
  emxInit_int32_T(&c_y_rowidx, 1, &hc_emlrtRTEI, true);
  emxInit_int32_T(&iv6, 1, &vb_emlrtRTEI, true);
  emxInit_real_T(&b_zfIIR, 2, &ab_emlrtRTEI, true);
  emxInit_int32_T(&e_rows, 2, &fb_emlrtRTEI, true);
  emxInit_real_T(&e_expanded, 1, &fb_emlrtRTEI, true);
  emxInit_int32_T(&l_y, 2, &fb_emlrtRTEI, true);
  emxInit_real_T(&f_expanded, 1, &fb_emlrtRTEI, true);
  emxInit_real_T(&i_b, 1, &v_emlrtRTEI, true);
  emxInit_real_T(&d_y_d, 1, &hc_emlrtRTEI, true);
  emxInit_int32_T(&m_y, 2, &fb_emlrtRTEI, true);
  emxInit_real_T(&h_a, 1, &v_emlrtRTEI, true);
  emxInit_int32_T(&d_y_colidx, 1, &hc_emlrtRTEI, true);
  emxInit_real_T(&d_convOut, 2, &ab_emlrtRTEI, true);
  emxInit_real_T(&n_y, 2, &pb_emlrtRTEI, true);
  emxInit_int32_T(&d_y_rowidx, 1, &hc_emlrtRTEI, true);
  emxInit_real_T(&j_b, 1, &db_emlrtRTEI, true);
  emxInit_real_T(&i_a, 1, &db_emlrtRTEI, true);
  emxInit_int32_T(&iv8, 1, &vb_emlrtRTEI, true);
  emxInit_real_T(&g_expanded, 2, &fb_emlrtRTEI, true);
  emxInit_real_T(&b_zi, 2, &pb_emlrtRTEI, true);
  emxInit_int32_T(&o_y, 2, &fb_emlrtRTEI, true);
  emxInit_int32_T(&iv9, 1, &vb_emlrtRTEI, true);
  emxInit_int32_T(&f_rows, 2, &fb_emlrtRTEI, true);
  emxInit_int32_T(&g_rows, 2, &fb_emlrtRTEI, true);
  emxInit_int32_T(&iv10, 1, &vb_emlrtRTEI, true);
  emxInit_real_T(&e_convOut, 1, &ab_emlrtRTEI, true);
  emxInit_int32_T(&p_y, 2, &fb_emlrtRTEI, true);
  emxInit_real_T(&c_zfIIR, 2, &ab_emlrtRTEI, true);
  emxInit_real_T(&f_convOut, 1, &ab_emlrtRTEI, true);
  emxInit_real_T(&h_expanded, 1, &fb_emlrtRTEI, true);
  emxInit_int32_T(&q_y, 2, &fb_emlrtRTEI, true);
  emxInit_int32_T(&iv11, 1, &vb_emlrtRTEI, true);
  emxInit_int32_T(&h_rows, 2, &fb_emlrtRTEI, true);
  emxInit_real_T(&k_b, 1, &db_emlrtRTEI, true);
  emxInit_int32_T(&iv12, 1, &vb_emlrtRTEI, true);
  emxInit_real_T(&i_expanded, 2, &fb_emlrtRTEI, true);
  emxInit_real_T(&j_a, 1, &db_emlrtRTEI, true);
  emxInit_int32_T(&r_y, 2, &fb_emlrtRTEI, true);
  emxInit_real_T(&d_zfIIR, 1, &ab_emlrtRTEI, true);
  emxInit_int32_T(&i_rows, 2, &fb_emlrtRTEI, true);
  emxInit_real_T(&g_convOut, 2, &ab_emlrtRTEI, true);
  emxInit_int32_T(&iv13, 1, &vb_emlrtRTEI, true);
  emxInit_real_T(&h_convOut, 1, &ab_emlrtRTEI, true);
  emxInit_int32_T(&s_y, 2, &fb_emlrtRTEI, true);
  emxInit_real_T(&yc5, 2, &tb_emlrtRTEI, true);
  emxInit_int32_T(&iv14, 1, &vb_emlrtRTEI, true);
  emxInit_int32_T(&j_rows, 2, &fb_emlrtRTEI, true);
  emxInit_real_T(&j_expanded, 2, &fb_emlrtRTEI, true);
  emxInit_real_T(&l_b, 1, &v_emlrtRTEI, true);
  emxInit_int32_T(&t_y, 2, &fb_emlrtRTEI, true);
  emxInit_real_T(&k_a, 1, &v_emlrtRTEI, true);
  emxInit_real_T(&i_convOut, 2, &ab_emlrtRTEI, true);
  emxInit_int32_T(&iv15, 1, &vb_emlrtRTEI, true);
  emxInit_int32_T(&u_y, 2, &fb_emlrtRTEI, true);
  emxInit_real_T(&e_zfIIR, 2, &ab_emlrtRTEI, true);
  emxInit_int32_T(&iv16, 1, &vb_emlrtRTEI, true);
  emxInit_real_T(&k_expanded, 1, &fb_emlrtRTEI, true);
  emxInit_int32_T(&k_rows, 2, &fb_emlrtRTEI, true);
  emxInit_int32_T(&v_y, 2, &fb_emlrtRTEI, true);
  emxInit_real_T(&j_convOut, 2, &ab_emlrtRTEI, true);
  emxInit_int32_T(&iv17, 1, &vb_emlrtRTEI, true);
  emxInit_int32_T(&l_rows, 2, &fb_emlrtRTEI, true);
  emxInit_real_T(&k_convOut, 1, &ab_emlrtRTEI, true);
  emxInit_real_T(&f_zfIIR, 1, &ab_emlrtRTEI, true);
  emxInit_real_T(&m_b, 1, &v_emlrtRTEI, true);
  emxInit_real_T(&l_a, 1, &v_emlrtRTEI, true);
  emxInit_real_T(&l_expanded, 1, &fb_emlrtRTEI, true);
  emxInit_int32_T(&w_y, 2, &fb_emlrtRTEI, true);
  emxInit_int32_T(&iv18, 1, &vb_emlrtRTEI, true);
  emxInit_int32_T(&m_rows, 2, &fb_emlrtRTEI, true);
  emxInit_real_T(&l_convOut, 1, &ab_emlrtRTEI, true);
  emxInit_real_T(&n_b, 1, &f_emlrtRTEI, true);
  emxInit_real_T(&m_convOut, 2, &ab_emlrtRTEI, true);
  emxInit_real_T(&n_convOut, 2, &ab_emlrtRTEI, true);
  emxInit_real_T(&o_convOut, 2, &ab_emlrtRTEI, true);
  emxInit_real_T(&p_convOut, 2, &ab_emlrtRTEI, true);
  emxInit_real_T(&q_convOut, 2, &ab_emlrtRTEI, true);
  emxInit_real_T(&r_convOut, 2, &ab_emlrtRTEI, true);
  emxInit_real_T(&s_convOut, 2, &ab_emlrtRTEI, true);
  emxInit_real_T(&t_convOut, 2, &ab_emlrtRTEI, true);
  emxInit_real_T(&u_convOut, 1, &v_emlrtRTEI, true);
  if ((coef->size[1] == 0) || ((x->size[0] == 0) || (x->size[1] == 0))) {
    x->size[0] = 0;
    x->size[1] = 0;
  } else {
    real_T nfact;
    int32_T d_x;
    int32_T idx;
    int32_T iv0;
    int32_T nc;
    int32_T ns;
    int32_T ny;
    int32_T offsetH;
    int32_T thism;
    int32_T vlen;
    int32_T xCol_dim0;
    int32_T zfSize_idx_0;
    boolean_T issos;
    boolean_T validLaunchParams;
    if (x->size[0] == 1) {
      iv0 = xCol->size[0] * xCol->size[1];
      xCol->size[0] = x->size[1];
      xCol->size[1] = x->size[0];
      emxEnsureCapacity_real_T(xCol, iv0, &c_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(xCol, &gpu_xCol);
      iv0 = x->size[0] - 1;
      d_x = x->size[1] - 1;
      xCol_dim0 = xCol->size[0];
      offsetH = x->size[0];
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((d_x + 1L)
        * (iv0 + 1L)), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, x);
        x_dirtyOnCpu = false;
        ec_filtfilt_kernel2<<<grid, block>>>(gpu_x, d_x, iv0, xCol_dim0, offsetH,
          gpu_xCol);
        xCol_dirtyOnGpu = true;
      }
    } else {
      iv0 = xCol->size[0] * xCol->size[1];
      xCol->size[0] = x->size[0];
      xCol->size[1] = x->size[1];
      emxEnsureCapacity_real_T(xCol, iv0, &b_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(xCol, &gpu_xCol);
      iv0 = x->size[0] * x->size[1] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, x);
        x_dirtyOnCpu = false;
        ec_filtfilt_kernel1<<<grid, block>>>(gpu_x, iv0, gpu_xCol);
        xCol_dirtyOnGpu = true;
      }
    }

    iv0 = b->size[0] * b->size[1];
    b->size[0] = 1;
    b->size[1] = coef->size[1];
    emxEnsureCapacity_real_T(b, iv0, &d_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(b, &gpu_b);
    iv0 = coef->size[1] - 1;
    validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
      &grid, &block, 1024U, 65535U);
    if (validLaunchParams) {
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_coef, coef);
      coef_dirtyOnCpu = false;
      ec_filtfilt_kernel3<<<grid, block>>>(gpu_coef, iv0, gpu_b);
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

    zi_size[0] = 2;
    if (issos) {
      boolean_T exitg1;
      if (coef_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_coef, coef);
      }

      ec_filtfilt_kernel55<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_coef,
        gpu_b);
      if (b->size[1] == 1) {
        iv0 = n_b->size[0];
        n_b->size[0] = 1;
        emxEnsureCapacity_real_T(n_b, iv0, &f_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(n_b, &b_gpu_b);
        gpuEmxMemcpyGpuToCpu_real_T(b, &gpu_b);
        n_b->data[0] = b->data[0];
        iv0 = b1->size[0] * b1->size[1];
        b1->size[0] = 1;
        b1->size[1] = 1;
        emxEnsureCapacity_real_T(b1, iv0, &i_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b1, &gpu_b1);
        gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_b, n_b);
        ec_filtfilt_kernel57<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(b_gpu_b,
          gpu_b1);
      } else {
        iv0 = b1->size[0] * b1->size[1];
        b1->size[0] = 1;
        b1->size[1] = b->size[1];
        emxEnsureCapacity_real_T(b1, iv0, &h_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b1, &gpu_b1);
        iv0 = b->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel56<<<grid, block>>>(gpu_b, iv0, gpu_b1);
        }
      }

      ny = b1->size[1] - 1;
      for (iv0 = 0; iv0 < 2; iv0++) {
        dv1[iv0] = static_cast<uint32_T>(b1->size[iv0]);
        dv1_dirtyOnCpu = true;
      }

      iv0 = y->size[0] * y->size[1];
      y->size[0] = static_cast<int32_T>(dv1[0]);
      y->size[1] = static_cast<int32_T>(dv1[1]);
      emxEnsureCapacity_real_T(y, iv0, &k_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(y, &gpu_y);
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ny + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_filtfilt_kernel58<<<grid, block>>>(gpu_b1, ny, gpu_y);
      }

      iv0 = maxCoefNum->size[0];
      maxCoefNum->size[0] = y->size[0];
      emxEnsureCapacity_real_T(maxCoefNum, iv0, &m_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(maxCoefNum, &gpu_maxCoefNum);
      vlen = y->size[1];
      ns = y->size[0];
      ny = y->size[0] * (y->size[1] - 1);
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ns - 1) +
        1L), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_filtfilt_kernel59<<<grid, block>>>(vlen, gpu_y, ny, ns,
          gpu_maxCoefNum);
        maxCoefNum_dirtyOnGpu = true;
      }

      iv0 = c_x->size[0];
      c_x->size[0] = maxCoefNum->size[0];
      emxEnsureCapacity_boolean_T(c_x, iv0, &o_emlrtRTEI);
      gpuEmxEnsureCapacity_boolean_T(c_x, &b_gpu_x);
      iv0 = maxCoefNum->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_filtfilt_kernel60<<<grid, block>>>(gpu_maxCoefNum, iv0, b_gpu_x);
        b_x_dirtyOnGpu = true;
      }

      d_x = 1;
      exitg1 = false;
      while ((!exitg1) && (d_x <= c_x->size[0])) {
        if (b_x_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_boolean_T(c_x, &b_gpu_x);
        }

        b_x_dirtyOnGpu = false;
        if (!c_x->data[d_x - 1]) {
          issos = false;
          exitg1 = true;
        } else {
          d_x++;
        }
      }

      if (issos) {
        if (maxCoefNum_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(maxCoefNum, &gpu_maxCoefNum);
        }

        val = maxCoefNum->data[0];
        iv0 = b1->size[1];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0 - 1)
          + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          cudaMemcpy(gpu_val, &val, 8UL, cudaMemcpyHostToDevice);
          ec_filtfilt_kernel61<<<grid, block>>>(gpu_val, iv0, gpu_b1);
        }
      }

      iv0 = b_x->size[0];
      b_x->size[0] = b1->size[1];
      emxEnsureCapacity_boolean_T(b_x, iv0, &r_emlrtRTEI);
      gpuEmxEnsureCapacity_boolean_T(b_x, &c_gpu_x);
      iv0 = b1->size[1] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_filtfilt_kernel62<<<grid, block>>>(gpu_b1, iv0, c_gpu_x);
        c_x_dirtyOnGpu = true;
      }

      iv0 = b_x->size[0];
      idx = 0;
      ns = 1;
      exitg1 = false;
      while ((!exitg1) && (iv0 > 0)) {
        if (c_x_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_boolean_T(b_x, &c_gpu_x);
        }

        c_x_dirtyOnGpu = false;
        if (b_x->data[iv0 - 1]) {
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

      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ns - 1) +
        1L), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_filtfilt_kernel63<<<grid, block>>>(ii_data[0], ns,
          *gpu_nZeroLastDen_data);
        nZeroLastDen_data_dirtyOnGpu = true;
      }

      if (ns == 0) {
        ec_filtfilt_kernel64<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
          (*gpu_nZeroLastDen_data);
        nZeroLastDen_data_dirtyOnGpu = true;
      }

      ec_filtfilt_kernel65<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_b,
        *gpu_a0);
      iv0 = a2->size[0];
      a2->size[0] = 3;
      emxEnsureCapacity_real_T(a2, iv0, &bb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(a2, &gpu_a2);
      iv0 = b2->size[0];
      b2->size[0] = 3;
      emxEnsureCapacity_real_T(b2, iv0, &cb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(b2, &gpu_b2);
      ec_filtfilt_kernel66<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_b,
        *gpu_a0, gpu_b2, gpu_a2);
      issos = false;
      maxCoefNum_dirtyOnGpu = true;
      if (nZeroLastDen_data_dirtyOnGpu) {
        cudaMemcpy(nZeroLastDen_data, *gpu_nZeroLastDen_data, 4UL,
                   cudaMemcpyDeviceToHost);
      }

      nfact = std::fmax(1.0, 3.0 * (std::fmax(1.0, static_cast<real_T>
        (nZeroLastDen_data[0])) - 1.0));
      gpuEmxMemcpyGpuToCpu_real_T(b2, &gpu_b2);
      val = b2->data[0];
      cudaMemcpy(gpu_val, &val, 8UL, cudaMemcpyHostToDevice);
      ec_filtfilt_kernel67<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_a2,
        gpu_val, gpu_b2, *gpu_rhs);
      ec_filtfilt_kernel68<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_I);
      ec_filtfilt_kernel69<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_I);
      ec_filtfilt_kernel70<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_a2,
        *gpu_I, *gpu_A);
      cudaMemcpy(A, *gpu_A, 32UL, cudaMemcpyDeviceToHost);
      if (std::abs(A[1]) > std::abs(A[0])) {
        ns = 1;
        ny = 0;
      } else {
        ns = 0;
        ny = 1;
      }

      val = A[ny] / A[ns];
      cudaMemcpy(gpu_val, &val, 8UL, cudaMemcpyHostToDevice);
      ec_filtfilt_kernel71<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_A,
        gpu_val, ns, *gpu_rhs, ny, *gpu_Y);
      ec_filtfilt_kernel72<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_A,
        *gpu_rhs, ns, *gpu_Y);
      ec_filtfilt_kernel73<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_Y,
        *gpu_zi_data);
    } else {
      iv0 = b2->size[0];
      b2->size[0] = coef->size[1];
      emxEnsureCapacity_real_T(b2, iv0, &e_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(b2, &gpu_b2);
      iv0 = coef->size[1] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (coef_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_coef, coef);
        }

        coef_dirtyOnCpu = false;
        ec_filtfilt_kernel4<<<grid, block>>>(gpu_coef, iv0, gpu_b2);
      }

      iv0 = a2->size[0];
      a2->size[0] = 1;
      emxEnsureCapacity_real_T(a2, iv0, &g_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(a2, &gpu_a2);
      a2->data[0] = 1.0;
      maxCoefNum_dirtyOnGpu = false;
      issos = true;
      nfact = std::fmax(1.0, 3.0 * (static_cast<real_T>(coef->size[1]) - 1.0));
      if (coef->size[1] > 1) {
        iv0 = a2->size[0];
        a2->size[0] = coef->size[1];
        emxEnsureCapacity_real_T(a2, iv0, &j_emlrtRTEI);
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_a2, a2);
        ec_filtfilt_kernel5<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_a2);
        issos = false;
        maxCoefNum_dirtyOnGpu = true;
        idx = coef->size[1] - 2;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(idx + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel6<<<grid, block>>>(idx, gpu_a2);
        }

        if (coef->size[1] - 1 < 2) {
          y_size[1] = 0;
        } else {
          y_size[1] = coef->size[1] - 2;
          iv0 = coef->size[1] - 3;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel7<<<grid, block>>>(iv0, *gpu_y_data);
          }
        }

        if (coef->size[1] - 2 < 1) {
          ny = 0;
        } else {
          ny = coef->size[1] - 2;
          iv0 = coef->size[1] - 3;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel8<<<grid, block>>>(iv0, *gpu_counts_data);
            counts_data_dirtyOnGpu = true;
          }
        }

        iv0 = rows->size[0] * rows->size[1];
        rows->size[0] = 1;
        rows->size[1] = ((coef->size[1] + y_size[1]) + ny) - 1;
        emxEnsureCapacity_int32_T(rows, iv0, &n_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(rows, &gpu_rows);
        idx = coef->size[1] - 2;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(idx + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel9<<<grid, block>>>(idx, gpu_rows);
        }

        iv0 = coef->size[1];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((y_size
          [1] - 1) + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (coef_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_coef, coef);
          }

          coef_dirtyOnCpu = false;
          ec_filtfilt_kernel10<<<grid, block>>>(*gpu_y_data, y_size[1] - 1, iv0,
            gpu_rows);
        }

        iv0 = coef->size[1];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ny - 1)
          + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (coef_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_coef, coef);
          }

          ec_filtfilt_kernel11<<<grid, block>>>(*gpu_counts_data, y_size[1], ny
            - 1, iv0, gpu_rows);
        }

        if (coef->size[1] - 1 < 2) {
          b_y_size[1] = 0;
          ny = 0;
        } else {
          b_y_size[1] = coef->size[1] - 2;
          iv0 = coef->size[1] - 3;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel12<<<grid, block>>>(iv0, *gpu_y_data);
          }

          ny = coef->size[1] - 2;
          iv0 = coef->size[1] - 3;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel13<<<grid, block>>>(iv0, *b_gpu_y_data);
          }
        }

        y_size[1] = coef->size[1] - 1;
        iv0 = cols->size[0] * cols->size[1];
        cols->size[0] = 1;
        cols->size[1] = ((coef->size[1] + b_y_size[1]) + ny) - 1;
        emxEnsureCapacity_int32_T(cols, iv0, &w_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(cols, &gpu_cols);
        idx = coef->size[1] - 2;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(idx + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel14<<<grid, block>>>(idx, gpu_cols);
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          ((b_y_size[1] - 1) + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel15<<<grid, block>>>(*gpu_y_data, y_size[1],
            b_y_size[1] - 1, gpu_cols);
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ny - 1)
          + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel16<<<grid, block>>>(*b_gpu_y_data, b_y_size[1],
            y_size[1], ny - 1, gpu_cols);
        }

        if (coef->size[1] < 3) {
          offsetH = 0;
          ny = -1;
        } else {
          offsetH = 2;
          ny = coef->size[1] - 1;
        }

        y_size[1] = coef->size[1] - 2;
        ns = coef->size[1] - 2;
        iv0 = vals->size[0] * vals->size[1];
        vals->size[0] = 1;
        vals->size[1] = (((ny - offsetH) + coef->size[1]) + coef->size[1]) - 2;
        emxEnsureCapacity_int8_T(vals, iv0, &eb_emlrtRTEI);
        gpuEmxEnsureCapacity_int8_T(vals, &gpu_vals);
        ec_filtfilt_kernel17<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_a2,
          gpu_vals);
        idx = ny - offsetH;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(idx + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel18<<<grid, block>>>(gpu_a2, offsetH, idx, gpu_vals);
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((y_size
          [1] - 1) + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel19<<<grid, block>>>(offsetH, ny, y_size[1] - 1,
            gpu_vals);
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ns - 1)
          + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel20<<<grid, block>>>(y_size[1], offsetH, ny, ns - 1,
            gpu_vals);
        }

        ec_filtfilt_kernel21<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_b2,
          gpu_val);
        b_x_dirtyOnGpu = true;
        zfSize_idx_0 = coef->size[1] - 1;
        iv0 = coef->size[1] - 2;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel22<<<grid, block>>>(gpu_a2, gpu_val, gpu_b2, iv0,
            *gpu_rhs_data);
        }

        nc = cols->size[1] - 1;
        ns = rows->size[1] - 1;
        iv0 = ridxInt->size[0];
        ridxInt->size[0] = rows->size[1];
        emxEnsureCapacity_int32_T(ridxInt, iv0, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(ridxInt, &gpu_ridxInt);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel23<<<grid, block>>>(gpu_rows, ns, gpu_ridxInt);
          ridxInt_dirtyOnGpu = true;
        }

        ns = cols->size[1] - 1;
        iv0 = cidxInt->size[0];
        cidxInt->size[0] = cols->size[1];
        emxEnsureCapacity_int32_T(cidxInt, iv0, &ib_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(cidxInt, &gpu_cidxInt);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel24<<<grid, block>>>(gpu_cols, ns, gpu_cidxInt);
          cidxInt_dirtyOnGpu = true;
        }

        iv0 = sortedIndices->size[0];
        sortedIndices->size[0] = cols->size[1];
        emxEnsureCapacity_int32_T(sortedIndices, iv0, &jb_emlrtRTEI);
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
        c_x_dirtyOnGpu = true;
        ny = cidxInt->size[0] - 1;
        iv0 = t->size[0];
        t->size[0] = cidxInt->size[0];
        emxEnsureCapacity_int32_T(t, iv0, &kb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(t, &gpu_t);
        iv0 = cidxInt->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel26<<<grid, block>>>(gpu_cidxInt, iv0, gpu_t);
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ny + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&gpu_sortedIndices, sortedIndices);
          c_x_dirtyOnGpu = false;
          ec_filtfilt_kernel27<<<grid, block>>>(gpu_t, gpu_sortedIndices, ny,
            gpu_cidxInt);
          cidxInt_dirtyOnGpu = true;
        }

        ny = ridxInt->size[0] - 1;
        iv0 = b_t->size[0];
        b_t->size[0] = ridxInt->size[0];
        emxEnsureCapacity_int32_T(b_t, iv0, &kb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(b_t, &b_gpu_t);
        iv0 = ridxInt->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel28<<<grid, block>>>(gpu_ridxInt, iv0, b_gpu_t);
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ny + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (c_x_dirtyOnGpu) {
            gpuEmxMemcpyCpuToGpu_int32_T(&gpu_sortedIndices, sortedIndices);
          }

          c_x_dirtyOnGpu = false;
          ec_filtfilt_kernel29<<<grid, block>>>(b_gpu_t, gpu_sortedIndices, ny,
            gpu_ridxInt);
          ridxInt_dirtyOnGpu = true;
        }

        vlen = ridxInt->size[0];
        if (ridxInt_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_int32_T(ridxInt, &gpu_ridxInt);
        }

        thism = ridxInt->data[0];
        for (offsetH = 0; offsetH <= vlen - 2; offsetH++) {
          if (thism < ridxInt->data[offsetH + 1]) {
            thism = ridxInt->data[offsetH + 1];
          }
        }

        if (cidxInt_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_int32_T(cidxInt, &gpu_cidxInt);
        }

        offsetH = cidxInt->data[cidxInt->size[0] - 1] - 1;
        iv0 = y_d->size[0];
        y_d->size[0] = cols->size[1];
        emxEnsureCapacity_real_T(y_d, iv0, &mb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(y_d, &gpu_y_d);
        iv0 = y_colidx->size[0];
        y_colidx->size[0] = cidxInt->data[cidxInt->size[0] - 1] + 1;
        emxEnsureCapacity_int32_T(y_colidx, iv0, &nb_emlrtRTEI);
        y_colidx->data[0] = 1;
        iv0 = y_rowidx->size[0];
        y_rowidx->size[0] = cols->size[1];
        emxEnsureCapacity_int32_T(y_rowidx, iv0, &mb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(y_rowidx, &gpu_y_rowidx);
        iv0 = cols->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel30<<<grid, block>>>(iv0, gpu_y_rowidx, gpu_y_d);
          y_d_dirtyOnGpu = true;
          y_rowidx_dirtyOnGpu = true;
        }

        ns = 0;
        for (d_x = 0; d_x <= offsetH; d_x++) {
          while ((ns + 1 <= nc + 1) && (cidxInt->data[ns] == d_x + 1)) {
            if (y_rowidx_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(y_rowidx, &gpu_y_rowidx);
            }

            y_rowidx->data[ns] = ridxInt->data[ns];
            y_rowidx_dirtyOnGpu = false;
            ns++;
          }

          y_colidx->data[d_x + 1] = ns + 1;
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nc + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (c_x_dirtyOnGpu) {
            gpuEmxMemcpyCpuToGpu_int32_T(&gpu_sortedIndices, sortedIndices);
          }

          ec_filtfilt_kernel31<<<grid, block>>>(gpu_vals, gpu_sortedIndices, nc,
            gpu_y_d);
          y_d_dirtyOnGpu = true;
        }

        idx = 1;
        ns = y_colidx->size[0];
        for (d_x = 0; d_x <= ns - 2; d_x++) {
          ny = y_colidx->data[d_x];
          y_colidx->data[d_x] = idx;
          while (ny < y_colidx->data[d_x + 1]) {
            val = 0.0;
            b_x_dirtyOnGpu = false;
            val_dirtyOnCpu = true;
            if (y_rowidx_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(y_rowidx, &gpu_y_rowidx);
            }

            y_rowidx_dirtyOnGpu = false;
            vlen = y_rowidx->data[ny - 1];
            while ((ny < y_colidx->data[d_x + 1]) && (y_rowidx->data[ny - 1] ==
                    vlen)) {
              if (y_d_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(y_d, &gpu_y_d);
              }

              y_d_dirtyOnGpu = false;
              val += y_d->data[ny - 1];
              ny++;
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
        if (zfSize_idx_0 == cidxInt->data[cidxInt->size[0] - 1]) {
          cs_di *b_cxA;
          cs_din *b_N;
          cs_dis *b_S;
          if (thism < cidxInt->data[cidxInt->size[0] - 1]) {
            ns = y_colidx->data[y_colidx->size[0] - 1] - 1;
            if (ns < 1) {
              ns = 1;
            }

            iv0 = c_y_d->size[0];
            c_y_d->size[0] = ns;
            emxEnsureCapacity_real_T(c_y_d, iv0, &ob_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(c_y_d, &c_gpu_y_d);
            iv0 = c_y_colidx->size[0];
            c_y_colidx->size[0] = thism + 1;
            emxEnsureCapacity_int32_T(c_y_colidx, iv0, &nb_emlrtRTEI);
            gpuEmxEnsureCapacity_int32_T(c_y_colidx, &b_gpu_y_colidx);
            iv0 = c_y_rowidx->size[0];
            c_y_rowidx->size[0] = ns;
            emxEnsureCapacity_int32_T(c_y_rowidx, iv0, &ob_emlrtRTEI);
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

            ny = c_y_colidx->size[0] - 2;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ny +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel42<<<grid, block>>>(ny, b_gpu_y_colidx);
            }

            iv0 = c_y_colidx->size[0];
            ec_filtfilt_kernel43<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(iv0,
              b_gpu_y_colidx);
            c_x_dirtyOnGpu = true;
            ns = c_y_colidx->size[0];
            iv0 = c_y_colidx->size[0];
            c_y_colidx->size[0] = ns;
            emxEnsureCapacity_int32_T(c_y_colidx, iv0, &ob_emlrtRTEI);
            gpuEmxEnsureCapacity_int32_T(c_y_colidx, &b_gpu_y_colidx);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ns
              - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel44<<<grid, block>>>(ns, b_gpu_y_colidx);
            }

            ny = y_colidx->data[y_colidx->size[0] - 1];
            for (d_x = 0; d_x <= ny - 2; d_x++) {
              if (c_x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_int32_T(c_y_colidx, &b_gpu_y_colidx);
              }

              if (y_rowidx_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_int32_T(y_rowidx, &gpu_y_rowidx);
              }

              c_y_colidx->data[y_rowidx->data[d_x]]++;
              y_rowidx_dirtyOnGpu = false;
              c_x_dirtyOnGpu = false;
            }

            if (c_x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(c_y_colidx, &b_gpu_y_colidx);
            }

            c_y_colidx->data[0] = 1;
            for (d_x = 0; d_x < thism; d_x++) {
              c_y_colidx->data[d_x + 1] += c_y_colidx->data[d_x];
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((thism - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel45<<<grid, block>>>(thism, *gpu_counts_data);
              counts_data_dirtyOnGpu = true;
            }

            for (d_x = 0; d_x <= offsetH; d_x++) {
              ns = y_colidx->data[d_x];
              ny = y_colidx->data[d_x + 1];
              for (idx = 0; idx < ny - ns; idx++) {
                vlen = (ns + idx) - 1;
                if (counts_data_dirtyOnGpu) {
                  cudaMemcpy(SD->f0.counts_data, *gpu_counts_data, 536870908UL,
                             cudaMemcpyDeviceToHost);
                }

                if (y_rowidx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_int32_T(y_rowidx, &gpu_y_rowidx);
                }

                nc = (SD->f0.counts_data[y_rowidx->data[vlen] - 1] +
                      c_y_colidx->data[y_rowidx->data[vlen] - 1]) - 1;
                if (c_y_d_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(c_y_d, &c_gpu_y_d);
                }

                if (y_d_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(y_d, &gpu_y_d);
                }

                y_d_dirtyOnGpu = false;
                c_y_d->data[nc] = y_d->data[vlen];
                c_y_d_dirtyOnGpu = false;
                if (c_y_rowidx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_int32_T(c_y_rowidx, &c_gpu_y_rowidx);
                }

                c_y_rowidx->data[nc] = d_x + 1;
                c_y_rowidx_dirtyOnGpu = false;
                SD->f0.counts_data[y_rowidx->data[vlen] - 1]++;
                counts_data_dirtyOnGpu = false;
                counts_data_dirtyOnCpu = true;
                y_rowidx_dirtyOnGpu = false;
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

              iv0 = d_y_d->size[0];
              d_y_d->size[0] = ns;
              emxEnsureCapacity_real_T(d_y_d, iv0, &ob_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(d_y_d, &d_gpu_y_d);
              iv0 = d_y_colidx->size[0];
              d_y_colidx->size[0] = thism + 1;
              emxEnsureCapacity_int32_T(d_y_colidx, iv0, &nb_emlrtRTEI);
              gpuEmxEnsureCapacity_int32_T(d_y_colidx, &c_gpu_y_colidx);
              iv0 = d_y_rowidx->size[0];
              d_y_rowidx->size[0] = ns;
              emxEnsureCapacity_int32_T(d_y_rowidx, iv0, &ob_emlrtRTEI);
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

              ny = d_y_colidx->size[0] - 2;
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ny
                + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ec_filtfilt_kernel49<<<grid, block>>>(ny, c_gpu_y_colidx);
              }

              iv0 = d_y_colidx->size[0];
              ec_filtfilt_kernel50<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(iv0,
                c_gpu_y_colidx);
              c_x_dirtyOnGpu = true;
              ns = d_y_colidx->size[0];
              iv0 = d_y_colidx->size[0];
              d_y_colidx->size[0] = ns;
              emxEnsureCapacity_int32_T(d_y_colidx, iv0, &ob_emlrtRTEI);
              gpuEmxEnsureCapacity_int32_T(d_y_colidx, &c_gpu_y_colidx);
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                ((ns - 1) + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ec_filtfilt_kernel51<<<grid, block>>>(ns, c_gpu_y_colidx);
              }

              ny = y_colidx->data[y_colidx->size[0] - 1];
              for (d_x = 0; d_x <= ny - 2; d_x++) {
                if (c_x_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_int32_T(d_y_colidx, &c_gpu_y_colidx);
                }

                if (y_rowidx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_int32_T(y_rowidx, &gpu_y_rowidx);
                }

                d_y_colidx->data[y_rowidx->data[d_x]]++;
                y_rowidx_dirtyOnGpu = false;
                c_x_dirtyOnGpu = false;
              }

              if (c_x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_int32_T(d_y_colidx, &c_gpu_y_colidx);
              }

              d_y_colidx->data[0] = 1;
              for (d_x = 0; d_x < thism; d_x++) {
                d_y_colidx->data[d_x + 1] += d_y_colidx->data[d_x];
              }

              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                ((thism - 1) + 1L), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                if (counts_data_dirtyOnCpu) {
                  cudaMemcpy(*gpu_counts_data, SD->f0.counts_data, 536870908UL,
                             cudaMemcpyHostToDevice);
                }

                ec_filtfilt_kernel52<<<grid, block>>>(thism, *gpu_counts_data);
                counts_data_dirtyOnGpu = true;
              }

              for (d_x = 0; d_x <= offsetH; d_x++) {
                ns = y_colidx->data[d_x];
                ny = y_colidx->data[d_x + 1];
                for (idx = 0; idx < ny - ns; idx++) {
                  vlen = (ns + idx) - 1;
                  if (counts_data_dirtyOnGpu) {
                    cudaMemcpy(SD->f0.counts_data, *gpu_counts_data, 536870908UL,
                               cudaMemcpyDeviceToHost);
                  }

                  if (y_rowidx_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_int32_T(y_rowidx, &gpu_y_rowidx);
                  }

                  nc = (SD->f0.counts_data[y_rowidx->data[vlen] - 1] +
                        d_y_colidx->data[y_rowidx->data[vlen] - 1]) - 1;
                  if (d_y_d_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(d_y_d, &d_gpu_y_d);
                  }

                  if (y_d_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_real_T(y_d, &gpu_y_d);
                  }

                  y_d_dirtyOnGpu = false;
                  d_y_d->data[nc] = y_d->data[vlen];
                  d_y_d_dirtyOnGpu = false;
                  if (d_y_rowidx_dirtyOnGpu) {
                    gpuEmxMemcpyGpuToCpu_int32_T(d_y_rowidx, &d_gpu_y_rowidx);
                  }

                  d_y_rowidx->data[nc] = d_x + 1;
                  d_y_rowidx_dirtyOnGpu = false;
                  SD->f0.counts_data[y_rowidx->data[vlen] - 1]++;
                  counts_data_dirtyOnGpu = false;
                  y_rowidx_dirtyOnGpu = false;
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
            if (b_x_dirtyOnGpu) {
              cudaMemcpy(&val, gpu_val, 8UL, cudaMemcpyDeviceToHost);
            }

            qr_rank_di(c_N, &val);
            val_dirtyOnCpu = true;
            zi_size[0] = cidxInt->data[cidxInt->size[0] - 1];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((zfSize_idx_0 - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel53<<<grid, block>>>(*gpu_rhs_data, zfSize_idx_0,
                *gpu_outBuff_data);
              cudaMemcpy(SD->f0.outBuff_data, *gpu_outBuff_data, 1073741816UL,
                         cudaMemcpyDeviceToHost);
            }

            solve_from_qr_di(c_N, c_S, (double *)&SD->f0.outBuff_data[0],
                             zfSize_idx_0, cidxInt->data[cidxInt->size[0] - 1]);
            outBuff_data_dirtyOnCpu = true;
            iv0 = cidxInt->data[cidxInt->size[0] - 1] - 1;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0
              + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              cudaMemcpy(*gpu_outBuff_data, SD->f0.outBuff_data, 1073741816UL,
                         cudaMemcpyHostToDevice);
              outBuff_data_dirtyOnCpu = false;
              ec_filtfilt_kernel54<<<grid, block>>>(*gpu_outBuff_data, iv0,
                *gpu_zi_data);
            }

            cs_di_sfree(c_S);
            cs_di_nfree(c_N);
          } else {
            zi_size[0] = zfSize_idx_0;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((zfSize_idx_0 - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel46<<<grid, block>>>(*gpu_rhs_data, zfSize_idx_0,
                *gpu_zi_data);
              cudaMemcpy(SD->f0.zi_data, *gpu_zi_data, 1073741816UL,
                         cudaMemcpyDeviceToHost);
            }

            solve_from_lu_di(b_N, b_S, (double *)&SD->f0.zi_data[0],
                             zfSize_idx_0);
            zi_data_dirtyOnCpu = true;
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

            iv0 = b_y_d->size[0];
            b_y_d->size[0] = ns;
            emxEnsureCapacity_real_T(b_y_d, iv0, &ob_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(b_y_d, &b_gpu_y_d);
            iv0 = b_y_colidx->size[0];
            b_y_colidx->size[0] = thism + 1;
            emxEnsureCapacity_int32_T(b_y_colidx, iv0, &nb_emlrtRTEI);
            gpuEmxEnsureCapacity_int32_T(b_y_colidx, &gpu_y_colidx);
            iv0 = b_y_rowidx->size[0];
            b_y_rowidx->size[0] = ns;
            emxEnsureCapacity_int32_T(b_y_rowidx, iv0, &ob_emlrtRTEI);
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

            ny = b_y_colidx->size[0] - 2;
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ny +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel34<<<grid, block>>>(ny, gpu_y_colidx);
            }

            iv0 = b_y_colidx->size[0];
            ec_filtfilt_kernel35<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(iv0,
              gpu_y_colidx);
            c_x_dirtyOnGpu = true;
            ns = b_y_colidx->size[0];
            iv0 = b_y_colidx->size[0];
            b_y_colidx->size[0] = ns;
            emxEnsureCapacity_int32_T(b_y_colidx, iv0, &ob_emlrtRTEI);
            gpuEmxEnsureCapacity_int32_T(b_y_colidx, &gpu_y_colidx);
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ns
              - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel36<<<grid, block>>>(ns, gpu_y_colidx);
            }

            ny = y_colidx->data[y_colidx->size[0] - 1];
            for (d_x = 0; d_x <= ny - 2; d_x++) {
              if (c_x_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_int32_T(b_y_colidx, &gpu_y_colidx);
              }

              if (y_rowidx_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_int32_T(y_rowidx, &gpu_y_rowidx);
              }

              b_y_colidx->data[y_rowidx->data[d_x]]++;
              y_rowidx_dirtyOnGpu = false;
              c_x_dirtyOnGpu = false;
            }

            if (c_x_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_int32_T(b_y_colidx, &gpu_y_colidx);
            }

            b_y_colidx->data[0] = 1;
            for (d_x = 0; d_x < thism; d_x++) {
              b_y_colidx->data[d_x + 1] += b_y_colidx->data[d_x];
            }

            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((thism - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel37<<<grid, block>>>(thism, *gpu_counts_data);
              counts_data_dirtyOnGpu = true;
            }

            for (d_x = 0; d_x <= offsetH; d_x++) {
              ns = y_colidx->data[d_x];
              ny = y_colidx->data[d_x + 1];
              for (idx = 0; idx < ny - ns; idx++) {
                vlen = (ns + idx) - 1;
                if (counts_data_dirtyOnGpu) {
                  cudaMemcpy(SD->f0.counts_data, *gpu_counts_data, 536870908UL,
                             cudaMemcpyDeviceToHost);
                }

                if (y_rowidx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_int32_T(y_rowidx, &gpu_y_rowidx);
                }

                nc = (SD->f0.counts_data[y_rowidx->data[vlen] - 1] +
                      b_y_colidx->data[y_rowidx->data[vlen] - 1]) - 1;
                if (b_y_d_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(b_y_d, &b_gpu_y_d);
                }

                if (y_d_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_real_T(y_d, &gpu_y_d);
                }

                y_d_dirtyOnGpu = false;
                b_y_d->data[nc] = y_d->data[vlen];
                b_y_d_dirtyOnGpu = false;
                if (b_y_rowidx_dirtyOnGpu) {
                  gpuEmxMemcpyGpuToCpu_int32_T(b_y_rowidx, &b_gpu_y_rowidx);
                }

                b_y_rowidx->data[nc] = d_x + 1;
                b_y_rowidx_dirtyOnGpu = false;
                SD->f0.counts_data[y_rowidx->data[vlen] - 1]++;
                counts_data_dirtyOnGpu = false;
                y_rowidx_dirtyOnGpu = false;
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
          if (b_x_dirtyOnGpu) {
            cudaMemcpy(&val, gpu_val, 8UL, cudaMemcpyDeviceToHost);
          }

          ns = qr_rank_di(N, &val);
          val_dirtyOnCpu = true;
          if (thism > cidxInt->data[cidxInt->size[0] - 1]) {
            thism = cidxInt->data[cidxInt->size[0] - 1];
          }

          if (ns < thism) {
            char_T str[14];
            x_y = nullptr;
            m = emlrtCreateCharArray(2, &iv7[0]);
            emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 6, m, &rfmt[0]);
            emlrtAssign(&x_y, m);
            y_y = nullptr;
            m = emlrtCreateDoubleScalar(val);
            emlrtAssign(&y_y, m);
            emlrt_marshallIn(b_sprintf(x_y, y_y, &c_emlrtMCI),
                             "<output of sprintf>", str);
            coder::internal::warning(ns, str);
          }

          zi_size[0] = cidxInt->data[cidxInt->size[0] - 1];
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            ((zfSize_idx_0 - 1) + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel38<<<grid, block>>>(*gpu_rhs_data, zfSize_idx_0,
              *gpu_outBuff_data);
            cudaMemcpy(SD->f0.outBuff_data, *gpu_outBuff_data, 1073741816UL,
                       cudaMemcpyDeviceToHost);
          }

          solve_from_qr_di(N, S, (double *)&SD->f0.outBuff_data[0], zfSize_idx_0,
                           cidxInt->data[cidxInt->size[0] - 1]);
          outBuff_data_dirtyOnCpu = true;
          iv0 = cidxInt->data[cidxInt->size[0] - 1] - 1;
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            cudaMemcpy(*gpu_outBuff_data, SD->f0.outBuff_data, 1073741816UL,
                       cudaMemcpyHostToDevice);
            outBuff_data_dirtyOnCpu = false;
            ec_filtfilt_kernel39<<<grid, block>>>(*gpu_outBuff_data, iv0,
              *gpu_zi_data);
          }

          cs_di_sfree(S);
          cs_di_nfree(N);
        }
      } else {
        zi_size[0] = 0;
      }
    }

    if (xCol->size[1] == 1) {
      if (xCol->size[0] < 10000) {
        int32_T b_nb;
        int32_T i1;
        int32_T na;
        int32_T nb;
        uint32_T OH;
        uint32_T u;
        zfSize_idx_0 = static_cast<int32_T>(-((0.0 - nfact) - -1.0));
        offsetH = a2->size[0] - 2;
        nb = b2->size[0] - 1;
        na = a2->size[0] - 2;
        b_nb = b2->size[0] - 1;
        if (issos) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_a2, a2);
        }

        ec_filtfilt_kernel243<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_a2,
          gpu_a1, b_gpu_a1);
        ec_filtfilt_kernel244<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_xCol,
          gpu_d1);
        if (xCol_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(xCol, &gpu_xCol);
        }

        val = 2.0 * xCol->data[xCol->size[0] - 1];
        ny = xCol->size[0];
        ns = xCol->size[0];
        i1 = ytemp->size[0];
        ytemp->size[0] = (static_cast<int32_T>(nfact + 1.0) + xCol->size[0]) +
          static_cast<int32_T>(-((0.0 - nfact) - -1.0));
        emxEnsureCapacity_real_T(ytemp, i1, &q_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(ytemp, &gpu_ytemp);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
          static_cast<int32_T>(nfact + 1.0) - 2) + 1L), &grid, &block, 1024U,
          65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel245<<<grid, block>>>(gpu_xCol, static_cast<int32_T>
            (nfact + 1.0) - 1, gpu_d1, static_cast<int32_T>(nfact + 1.0) - 2,
            gpu_ytemp);
          ytemp_dirtyOnGpu = true;
        }

        for (i1 = 0; i1 < ns; i1++) {
          if (ytemp_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(ytemp, &gpu_ytemp);
          }

          ytemp->data[(i1 + static_cast<int32_T>(nfact + 1.0)) - 1] = xCol->
            data[i1];
          ytemp_dirtyOnGpu = false;
          ytemp_dirtyOnCpu = true;
        }

        for (i1 = 0; i1 <= zfSize_idx_0; i1++) {
          if (ytemp_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(ytemp, &gpu_ytemp);
          }

          ytemp->data[((i1 + static_cast<int32_T>(nfact + 1.0)) + ns) - 1] = val
            - xCol->data[(ny - i1) - 2];
          ytemp_dirtyOnGpu = false;
          ytemp_dirtyOnCpu = true;
        }

        if (ytemp_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(ytemp, &gpu_ytemp);
        }

        val = ytemp->data[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          ((zi_size[0] - 1) + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          cudaMemcpy(gpu_val, &val, 8UL, cudaMemcpyHostToDevice);
          if (zi_data_dirtyOnCpu) {
            cudaMemcpy(*gpu_zi_data, SD->f0.zi_data, 1073741816UL,
                       cudaMemcpyHostToDevice);
          }

          zi_data_dirtyOnCpu = false;
          if (outBuff_data_dirtyOnCpu) {
            cudaMemcpy(*gpu_outBuff_data, SD->f0.outBuff_data, 1073741816UL,
                       cudaMemcpyHostToDevice);
          }

          ec_filtfilt_kernel246<<<grid, block>>>(gpu_val, *gpu_zi_data, zi_size
            [0] - 1, *gpu_outBuff_data);
          outBuff_data_dirtyOnCpu = false;
        }

        i1 = c_b->size[0];
        c_b->size[0] = b2->size[0];
        emxEnsureCapacity_real_T(c_b, i1, &u_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(c_b, &d_gpu_b);
        iv0 = b2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel247<<<grid, block>>>(gpu_b2, iv0, d_gpu_b);
          b_b_dirtyOnGpu = true;
        }

        i1 = b_a->size[0];
        b_a->size[0] = a2->size[0];
        emxEnsureCapacity_real_T(b_a, i1, &u_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_a, &b_gpu_a);
        iv0 = a2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel248<<<grid, block>>>(gpu_a2, iv0, b_gpu_a);
          b_a_dirtyOnGpu = true;
        }

        if (maxCoefNum_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(a2, &gpu_a2);
        }

        if ((!std::isinf(a2->data[0])) && (!std::isnan(a2->data[0])) &&
            (!(a2->data[0] == 0.0)) && (a2->data[0] != 1.0)) {
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nb +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel249<<<grid, block>>>(b_gpu_a1, nb, d_gpu_b);
            b_b_dirtyOnGpu = true;
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (offsetH + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel250<<<grid, block>>>(b_gpu_a1, offsetH, b_gpu_a);
          }

          ec_filtfilt_kernel251<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(b_gpu_a);
          b_a_dirtyOnGpu = true;
        }

        if (b_a->size[0] > c_b->size[0]) {
          ns = b_a->size[0] - c_b->size[0];
          i1 = c_b->size[0];
          vlen = c_b->size[0];
          c_b->size[0] += ns;
          emxEnsureCapacity_real_T(c_b, vlen, &ab_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(c_b, &d_gpu_b);
          if (ns - 1 >= 0) {
            if (b_b_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(c_b, &d_gpu_b);
            }

            std::memset(&c_b->data[i1], 0, static_cast<uint32_T>(ns) * sizeof
                        (real_T));
            b_b_dirtyOnCpu = true;
          }
        }

        dv1[0] = static_cast<uint32_T>(c_b->size[0]);
        OH = (static_cast<uint32_T>(ytemp->size[0]) + static_cast<uint32_T>
              (c_b->size[0])) - 1U;
        nc = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }

        thism = c_b->size[0];
        offsetH = static_cast<int32_T>(std::floor(static_cast<real_T>(c_b->size
          [0]) / 2.0)) + static_cast<int32_T>(std::floor((static_cast<real_T>
          (c_b->size[0]) - 1.0) / 2.0));
        if ((static_cast<int32_T>(u) > 0) && (c_b->size[0] > MAX_int32_T -
             static_cast<int32_T>(u))) {
          ny = MAX_int32_T;
        } else {
          ny = static_cast<int32_T>(u) + c_b->size[0];
        }

        i1 = b_expanded->size[0];
        b_expanded->size[0] = ny - 1;
        emxEnsureCapacity_real_T(b_expanded, i1, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_expanded, &b_gpu_expanded);
        d_x = (static_cast<int32_T>(u) + static_cast<int32_T>(dv1[0])) - 2;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_x + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel252<<<grid, block>>>(d_x, b_gpu_expanded);
        }

        ns = ytemp->size[0];
        i1 = e_y->size[0] * e_y->size[1];
        e_y->size[0] = 1;
        e_y->size[1] = ytemp->size[0];
        emxEnsureCapacity_int32_T(e_y, i1, &hb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(e_y, &e_gpu_y);
        e_y->data[0] = 1;
        ny = 1;
        for (d_x = 0; d_x <= ns - 2; d_x++) {
          ny++;
          e_y->data[d_x + 1] = ny;
        }

        i1 = iv2->size[0];
        iv2->size[0] = e_y->size[1];
        emxEnsureCapacity_int32_T(iv2, i1, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(iv2, &gpu_iv2);
        d_x = e_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_x + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&e_gpu_y, e_y);
          ec_filtfilt_kernel253<<<grid, block>>>(offsetH, e_gpu_y, d_x, gpu_iv2);
        }

        iv0 = ytemp->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (ytemp_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_ytemp, ytemp);
          }

          ytemp_dirtyOnCpu = false;
          ec_filtfilt_kernel254<<<grid, block>>>(gpu_ytemp, gpu_iv2, iv0,
            b_gpu_expanded);
        }

        i1 = c_rows->size[0] * c_rows->size[1];
        c_rows->size[0] = 1;
        c_rows->size[1] = static_cast<int32_T>(dv1[0]);
        emxEnsureCapacity_int32_T(c_rows, i1, &hb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(c_rows, &c_gpu_rows);
        c_rows->data[0] = 0;
        ny = 0;
        for (d_x = 0; d_x <= thism - 2; d_x++) {
          ny++;
          c_rows->data[d_x + 1] = ny;
        }

        i1 = b_convOut->size[0];
        b_convOut->size[0] = static_cast<int32_T>(u);
        emxEnsureCapacity_real_T(b_convOut, i1, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_convOut, &b_gpu_convOut);
        r = dim3(static_cast<uint32_T>(std::floor((static_cast<real_T>(OH) + (
          static_cast<real_T>(nc) - 1.0)) / static_cast<real_T>(nc))), 1U, 1U);
        r1 = dim3(static_cast<uint32_T>(nc), 1U, 1U);
        iv0 = c_b->size[0];
        validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>((
          static_cast<int32_T>(u) - 1) + 1L), &r, &r1, &grid, &block, 1024U,
          65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&c_gpu_rows, c_rows);
          if (b_b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_b, c_b);
          }

          ec_filtfilt_kernel255<<<grid, block>>>(b_gpu_expanded, c_gpu_rows,
            d_gpu_b, static_cast<int32_T>(u), iv0, b_gpu_convOut);
          b_convOut_dirtyOnGpu = true;
        }

        if (zi_size[0] != 0) {
          if (zi_size[0] == 1) {
            if (outBuff_data_dirtyOnCpu) {
              cudaMemcpy(*gpu_outBuff_data, SD->f0.outBuff_data, 1073741816UL,
                         cudaMemcpyHostToDevice);
            }

            outBuff_data_dirtyOnCpu = false;
            ec_filtfilt_kernel257<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
              (*gpu_outBuff_data, b_gpu_convOut);
            b_convOut_dirtyOnGpu = true;
          } else {
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((zi_size[0] - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (outBuff_data_dirtyOnCpu) {
                cudaMemcpy(*gpu_outBuff_data, SD->f0.outBuff_data, 1073741816UL,
                           cudaMemcpyHostToDevice);
              }

              outBuff_data_dirtyOnCpu = false;
              ec_filtfilt_kernel256<<<grid, block>>>(*gpu_outBuff_data, zi_size
                [0] - 1, b_gpu_convOut);
              b_convOut_dirtyOnGpu = true;
            }
          }
        }

        ns = ytemp->size[0] + b_a->size[0];
        for (offsetH = 0; offsetH <= ns - 2; offsetH++) {
          ny = static_cast<int32_T>(std::fmin(static_cast<real_T>(offsetH) + 1.0,
            static_cast<real_T>(b_a->size[0])));
          for (vlen = 0; vlen <= ny - 2; vlen++) {
            if (b_convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_convOut, &b_gpu_convOut);
            }

            if (b_a_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_a, &b_gpu_a);
            }

            b_a_dirtyOnGpu = false;
            b_convOut->data[offsetH] -= b_convOut->data[(offsetH - vlen) - 1] *
              b_a->data[vlen + 1];
            b_convOut_dirtyOnGpu = false;
            b_convOut_dirtyOnCpu = true;
          }
        }

        i1 = dv3->size[0];
        dv3->size[0] = ytemp->size[0];
        emxEnsureCapacity_real_T(dv3, i1, &ab_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(dv3, &gpu_dv3);
        iv0 = ytemp->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (b_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_convOut, b_convOut);
          }

          b_convOut_dirtyOnCpu = false;
          ec_filtfilt_kernel258<<<grid, block>>>(b_gpu_convOut, iv0, gpu_dv3);
          dv3_dirtyOnGpu = true;
        }

        zfSize[0] = static_cast<uint32_T>(ytemp->size[0]);
        i1 = ytemp->size[0] - 1;
        vlen = ytemp->size[0];
        ytemp->size[0] = static_cast<int32_T>(zfSize[0]);
        emxEnsureCapacity_real_T(ytemp, vlen, &lb_emlrtRTEI);
        if (!ytemp_dirtyOnCpu) {
          gpuEmxEnsureCapacity_real_T(ytemp, &gpu_ytemp);
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i1 + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (b_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_convOut, b_convOut);
          }

          b_convOut_dirtyOnCpu = false;
          if (ytemp_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_ytemp, ytemp);
          }

          ec_filtfilt_kernel259<<<grid, block>>>(b_gpu_convOut, i1, gpu_ytemp);
        }

        if (dv3_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(dv3, &gpu_dv3);
        }

        val = dv3->data[static_cast<int32_T>(zfSize[0]) - 1];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          ((zi_size[0] - 1) + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          cudaMemcpy(gpu_val, &val, 8UL, cudaMemcpyHostToDevice);
          if (zi_data_dirtyOnCpu) {
            cudaMemcpy(*gpu_zi_data, SD->f0.zi_data, 1073741816UL,
                       cudaMemcpyHostToDevice);
          }

          if (outBuff_data_dirtyOnCpu) {
            cudaMemcpy(*gpu_outBuff_data, SD->f0.outBuff_data, 1073741816UL,
                       cudaMemcpyHostToDevice);
          }

          ec_filtfilt_kernel260<<<grid, block>>>(gpu_val, *gpu_zi_data, zi_size
            [0] - 1, *gpu_outBuff_data);
          outBuff_data_dirtyOnCpu = false;
        }

        i1 = f_b->size[0];
        f_b->size[0] = b2->size[0];
        emxEnsureCapacity_real_T(f_b, i1, &u_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(f_b, &h_gpu_b);
        iv0 = b2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel261<<<grid, block>>>(gpu_b2, iv0, h_gpu_b);
          f_b_dirtyOnGpu = true;
        }

        i1 = e_a->size[0];
        e_a->size[0] = a2->size[0];
        emxEnsureCapacity_real_T(e_a, i1, &u_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(e_a, &f_gpu_a);
        iv0 = a2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel262<<<grid, block>>>(gpu_a2, iv0, f_gpu_a);
          d_a_dirtyOnGpu = true;
        }

        if ((!std::isinf(a2->data[0])) && (!std::isnan(a2->data[0])) &&
            (!(a2->data[0] == 0.0)) && (a2->data[0] != 1.0)) {
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_nb +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel263<<<grid, block>>>(gpu_a1, b_nb, h_gpu_b);
            f_b_dirtyOnGpu = true;
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel264<<<grid, block>>>(gpu_a1, na, f_gpu_a);
          }

          ec_filtfilt_kernel265<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(f_gpu_a);
          d_a_dirtyOnGpu = true;
        }

        if (e_a->size[0] > f_b->size[0]) {
          ns = e_a->size[0] - f_b->size[0];
          i1 = f_b->size[0];
          vlen = f_b->size[0];
          f_b->size[0] += ns;
          emxEnsureCapacity_real_T(f_b, vlen, &ab_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(f_b, &h_gpu_b);
          if (ns - 1 >= 0) {
            if (f_b_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(f_b, &h_gpu_b);
            }

            std::memset(&f_b->data[i1], 0, static_cast<uint32_T>(ns) * sizeof
                        (real_T));
            f_b_dirtyOnCpu = true;
          }
        }

        dv1[0] = static_cast<uint32_T>(f_b->size[0]);
        OH = (zfSize[0] + static_cast<uint32_T>(f_b->size[0])) - 1U;
        nc = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }

        thism = f_b->size[0];
        offsetH = static_cast<int32_T>(std::floor(static_cast<real_T>(f_b->size
          [0]) / 2.0)) + static_cast<int32_T>(std::floor((static_cast<real_T>
          (f_b->size[0]) - 1.0) / 2.0));
        if ((static_cast<int32_T>(u) > 0) && (f_b->size[0] > MAX_int32_T -
             static_cast<int32_T>(u))) {
          ny = MAX_int32_T;
        } else {
          ny = static_cast<int32_T>(u) + f_b->size[0];
        }

        i1 = e_expanded->size[0];
        e_expanded->size[0] = ny - 1;
        emxEnsureCapacity_real_T(e_expanded, i1, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(e_expanded, &f_gpu_expanded);
        d_x = (static_cast<int32_T>(u) + static_cast<int32_T>(dv1[0])) - 2;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_x + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel266<<<grid, block>>>(d_x, f_gpu_expanded);
        }

        ns = ytemp->size[0];
        i1 = l_y->size[0] * l_y->size[1];
        l_y->size[0] = 1;
        l_y->size[1] = static_cast<int32_T>(zfSize[0]);
        emxEnsureCapacity_int32_T(l_y, i1, &hb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(l_y, &k_gpu_y);
        l_y->data[0] = 1;
        ny = 1;
        for (d_x = 0; d_x <= ns - 2; d_x++) {
          ny++;
          l_y->data[d_x + 1] = ny;
        }

        i1 = iv8->size[0];
        iv8->size[0] = l_y->size[1];
        emxEnsureCapacity_int32_T(iv8, i1, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(iv8, &gpu_iv8);
        d_x = l_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_x + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&k_gpu_y, l_y);
          ec_filtfilt_kernel267<<<grid, block>>>(offsetH, k_gpu_y, d_x, gpu_iv8);
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
          static_cast<int32_T>(zfSize[0]) - 1) + 1L), &grid, &block, 1024U,
          65535U);
        if (validLaunchParams) {
          if (b_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_convOut, b_convOut);
          }

          ec_filtfilt_kernel268<<<grid, block>>>(b_gpu_convOut, static_cast<
            int32_T>(zfSize[0]) - 1, gpu_iv8, static_cast<int32_T>(zfSize[0]) -
            1, f_gpu_expanded);
        }

        i1 = f_rows->size[0] * f_rows->size[1];
        f_rows->size[0] = 1;
        f_rows->size[1] = static_cast<int32_T>(dv1[0]);
        emxEnsureCapacity_int32_T(f_rows, i1, &hb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(f_rows, &f_gpu_rows);
        f_rows->data[0] = 0;
        ny = 0;
        for (d_x = 0; d_x <= thism - 2; d_x++) {
          ny++;
          f_rows->data[d_x + 1] = ny;
        }

        i1 = e_convOut->size[0];
        e_convOut->size[0] = static_cast<int32_T>(u);
        emxEnsureCapacity_real_T(e_convOut, i1, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(e_convOut, &f_gpu_convOut);
        r = dim3(static_cast<uint32_T>(std::floor((static_cast<real_T>(OH) + (
          static_cast<real_T>(nc) - 1.0)) / static_cast<real_T>(nc))), 1U, 1U);
        r1 = dim3(static_cast<uint32_T>(nc), 1U, 1U);
        iv0 = f_b->size[0];
        validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>((
          static_cast<int32_T>(u) - 1) + 1L), &r, &r1, &grid, &block, 1024U,
          65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&f_gpu_rows, f_rows);
          if (f_b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&h_gpu_b, f_b);
          }

          ec_filtfilt_kernel269<<<grid, block>>>(f_gpu_expanded, f_gpu_rows,
            h_gpu_b, static_cast<int32_T>(u), iv0, f_gpu_convOut);
          e_convOut_dirtyOnGpu = true;
        }

        if (zi_size[0] != 0) {
          if (zi_size[0] == 1) {
            if (outBuff_data_dirtyOnCpu) {
              cudaMemcpy(*gpu_outBuff_data, SD->f0.outBuff_data, 1073741816UL,
                         cudaMemcpyHostToDevice);
            }

            ec_filtfilt_kernel271<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
              (*gpu_outBuff_data, f_gpu_convOut);
            e_convOut_dirtyOnGpu = true;
          } else {
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((zi_size[0] - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (outBuff_data_dirtyOnCpu) {
                cudaMemcpy(*gpu_outBuff_data, SD->f0.outBuff_data, 1073741816UL,
                           cudaMemcpyHostToDevice);
              }

              ec_filtfilt_kernel270<<<grid, block>>>(*gpu_outBuff_data, zi_size
                [0] - 1, f_gpu_convOut);
              e_convOut_dirtyOnGpu = true;
            }
          }
        }

        ns = static_cast<int32_T>(zfSize[0]) + e_a->size[0];
        for (offsetH = 0; offsetH <= ns - 2; offsetH++) {
          ny = static_cast<int32_T>(std::fmin(static_cast<real_T>(offsetH) + 1.0,
            static_cast<real_T>(e_a->size[0])));
          for (vlen = 0; vlen <= ny - 2; vlen++) {
            if (e_convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(e_convOut, &f_gpu_convOut);
            }

            if (d_a_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(e_a, &f_gpu_a);
            }

            d_a_dirtyOnGpu = false;
            e_convOut->data[offsetH] -= e_convOut->data[(offsetH - vlen) - 1] *
              e_a->data[vlen + 1];
            e_convOut_dirtyOnGpu = false;
            e_convOut_dirtyOnCpu = true;
          }
        }

        val = static_cast<real_T>(zfSize[0]) - nfact;
        if (nfact + 1.0 > val) {
          ns = 1;
          ny = 1;
          vlen = 0;
        } else {
          ns = static_cast<int32_T>(val);
          ny = -1;
          vlen = static_cast<int32_T>(nfact + 1.0);
        }

        i1 = xCol->size[0] * xCol->size[1];
        xCol->size[0] = div_s32(vlen - ns, ny) + 1;
        xCol->size[1] = 1;
        emxEnsureCapacity_real_T(xCol, i1, &rb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(xCol, &gpu_xCol);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((vlen -
          ns) / ny + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (e_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&f_gpu_convOut, e_convOut);
          }

          ec_filtfilt_kernel272<<<grid, block>>>(f_gpu_convOut, ny, ns, vlen,
            gpu_xCol);
        }
      } else {
        int32_T b_na;
        int32_T b_nb;
        int32_T c_na;
        int32_T c_nb;
        int32_T csz_idx_0;
        int32_T d_na;
        int32_T d_nb;
        int32_T e_nb;
        int32_T i1;
        int32_T na;
        int32_T nb;
        uint32_T OH;
        uint32_T u;
        offsetH = a2->size[0] - 2;
        nb = b2->size[0] - 1;
        na = a2->size[0] - 2;
        b_nb = b2->size[0] - 1;
        b_na = a2->size[0] - 2;
        c_nb = b2->size[0] - 1;
        c_na = a2->size[0] - 2;
        d_nb = b2->size[0] - 1;
        d_na = a2->size[0] - 2;
        e_nb = b2->size[0] - 1;
        if (issos) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_a2, a2);
        }

        ec_filtfilt_kernel174<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_a2,
          c_gpu_a1, d_gpu_a1, e_gpu_a1, gpu_a1, b_gpu_a1);
        if (xCol_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(xCol, &gpu_xCol);
        }

        d1 = 2.0 * xCol->data[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
          static_cast<int32_T>(nfact + 1.0) - 2) + 1L), &grid, &block, 1024U,
          65535U);
        if (validLaunchParams) {
          cudaMemcpy(gpu_d1, &d1, 8UL, cudaMemcpyHostToDevice);
          ec_filtfilt_kernel175<<<grid, block>>>(gpu_d1, gpu_xCol, static_cast<
            int32_T>(nfact + 1.0) - 1, *gpu_rhs_data);
        }

        if (val_dirtyOnCpu) {
          cudaMemcpy(gpu_val, &val, 8UL, cudaMemcpyHostToDevice);
        }

        ec_filtfilt_kernel176<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
          (*gpu_rhs_data, gpu_val);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          ((zi_size[0] - 1) + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (zi_data_dirtyOnCpu) {
            cudaMemcpy(*gpu_zi_data, SD->f0.zi_data, 1073741816UL,
                       cudaMemcpyHostToDevice);
          }

          zi_data_dirtyOnCpu = false;
          if (outBuff_data_dirtyOnCpu) {
            cudaMemcpy(*gpu_outBuff_data, SD->f0.outBuff_data, 1073741816UL,
                       cudaMemcpyHostToDevice);
          }

          ec_filtfilt_kernel177<<<grid, block>>>(gpu_val, *gpu_zi_data, zi_size
            [0] - 1, *gpu_outBuff_data);
          outBuff_data_dirtyOnCpu = false;
        }

        i1 = b_b->size[0];
        b_b->size[0] = b2->size[0];
        emxEnsureCapacity_real_T(b_b, i1, &v_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_b, &c_gpu_b);
        iv0 = b2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel178<<<grid, block>>>(gpu_b2, iv0, c_gpu_b);
          b_dirtyOnGpu = true;
        }

        i1 = a->size[0];
        a->size[0] = a2->size[0];
        emxEnsureCapacity_real_T(a, i1, &v_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(a, &gpu_a);
        iv0 = a2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel179<<<grid, block>>>(gpu_a2, iv0, gpu_a);
          a_dirtyOnGpu = true;
        }

        if (maxCoefNum_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(a2, &gpu_a2);
        }

        if ((!std::isinf(a2->data[0])) && (!std::isnan(a2->data[0])) &&
            (!(a2->data[0] == 0.0)) && (a2->data[0] != 1.0)) {
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nb +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel180<<<grid, block>>>(b_gpu_a1, nb, c_gpu_b);
            b_dirtyOnGpu = true;
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
            (offsetH + 1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel181<<<grid, block>>>(b_gpu_a1, offsetH, gpu_a);
          }

          ec_filtfilt_kernel182<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_a);
          a_dirtyOnGpu = true;
        }

        if (a->size[0] > b_b->size[0]) {
          idx = a->size[0] - b_b->size[0];
          i1 = b_b->size[0];
          vlen = b_b->size[0];
          b_b->size[0] += idx;
          emxEnsureCapacity_real_T(b_b, vlen, &ab_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(b_b, &c_gpu_b);
          if (idx - 1 >= 0) {
            if (b_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_b, &c_gpu_b);
            }

            std::memset(&b_b->data[i1], 0, static_cast<uint32_T>(idx) * sizeof
                        (real_T));
            b_dirtyOnCpu = true;
          }
        }

        csz_idx_0 = b_b->size[0] - 1;
        dv1[0] = static_cast<uint32_T>(b_b->size[0]);
        OH = (static_cast<uint32_T>(static_cast<int32_T>(nfact + 1.0)) +
              static_cast<uint32_T>(b_b->size[0])) - 2U;
        nc = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }

        thism = b_b->size[0];
        offsetH = static_cast<int32_T>(std::floor(static_cast<real_T>(b_b->size
          [0]) / 2.0)) + static_cast<int32_T>(std::floor((static_cast<real_T>
          (b_b->size[0]) - 1.0) / 2.0));
        if ((static_cast<int32_T>(u) > 0) && (b_b->size[0] > MAX_int32_T -
             static_cast<int32_T>(u))) {
          ny = MAX_int32_T;
        } else {
          ny = static_cast<int32_T>(u) + b_b->size[0];
        }

        i1 = expanded->size[0];
        expanded->size[0] = ny - 1;
        emxEnsureCapacity_real_T(expanded, i1, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(expanded, &gpu_expanded);
        d_x = (static_cast<int32_T>(u) + static_cast<int32_T>(dv1[0])) - 2;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_x + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel183<<<grid, block>>>(d_x, gpu_expanded);
        }

        i1 = static_cast<int32_T>(nfact + 1.0) - 1;
        vlen = d_y->size[0] * d_y->size[1];
        d_y->size[0] = 1;
        d_y->size[1] = static_cast<int32_T>(nfact + 1.0) - 1;
        emxEnsureCapacity_int32_T(d_y, vlen, &hb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(d_y, &d_gpu_y);
        d_y->data[0] = 1;
        ny = 1;
        for (d_x = 0; d_x <= i1 - 2; d_x++) {
          ny++;
          d_y->data[d_x + 1] = ny;
        }

        i1 = iv1->size[0];
        iv1->size[0] = d_y->size[1];
        emxEnsureCapacity_int32_T(iv1, i1, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(iv1, &gpu_iv1);
        d_x = d_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_x + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&d_gpu_y, d_y);
          ec_filtfilt_kernel184<<<grid, block>>>(offsetH, d_gpu_y, d_x, gpu_iv1);
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((
          static_cast<int32_T>(nfact + 1.0) - 2) + 1L), &grid, &block, 1024U,
          65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel185<<<grid, block>>>(*gpu_rhs_data, gpu_iv1,
            static_cast<int32_T>(nfact + 1.0) - 2, gpu_expanded);
        }

        i1 = b_rows->size[0] * b_rows->size[1];
        b_rows->size[0] = 1;
        b_rows->size[1] = static_cast<int32_T>(dv1[0]);
        emxEnsureCapacity_int32_T(b_rows, i1, &hb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(b_rows, &b_gpu_rows);
        b_rows->data[0] = 0;
        ny = 0;
        for (d_x = 0; d_x <= thism - 2; d_x++) {
          ny++;
          b_rows->data[d_x + 1] = ny;
        }

        i1 = convOut->size[0];
        convOut->size[0] = static_cast<int32_T>(u);
        emxEnsureCapacity_real_T(convOut, i1, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(convOut, &gpu_convOut);
        r = dim3(static_cast<uint32_T>(std::floor((static_cast<real_T>(OH) + (
          static_cast<real_T>(nc) - 1.0)) / static_cast<real_T>(nc))), 1U, 1U);
        r1 = dim3(static_cast<uint32_T>(nc), 1U, 1U);
        iv0 = b_b->size[0];
        validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>((
          static_cast<int32_T>(u) - 1) + 1L), &r, &r1, &grid, &block, 1024U,
          65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_rows, b_rows);
          if (b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_b, b_b);
          }

          ec_filtfilt_kernel186<<<grid, block>>>(gpu_expanded, b_gpu_rows,
            c_gpu_b, static_cast<int32_T>(u), iv0, gpu_convOut);
          convOut_dirtyOnGpu = true;
        }

        if (zi_size[0] != 0) {
          if (zi_size[0] == 1) {
            if (outBuff_data_dirtyOnCpu) {
              cudaMemcpy(*gpu_outBuff_data, SD->f0.outBuff_data, 1073741816UL,
                         cudaMemcpyHostToDevice);
            }

            outBuff_data_dirtyOnCpu = false;
            ec_filtfilt_kernel188<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
              (*gpu_outBuff_data, gpu_convOut);
            convOut_dirtyOnGpu = true;
          } else {
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((zi_size[0] - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (outBuff_data_dirtyOnCpu) {
                cudaMemcpy(*gpu_outBuff_data, SD->f0.outBuff_data, 1073741816UL,
                           cudaMemcpyHostToDevice);
              }

              outBuff_data_dirtyOnCpu = false;
              ec_filtfilt_kernel187<<<grid, block>>>(*gpu_outBuff_data, zi_size
                [0] - 1, gpu_convOut);
              convOut_dirtyOnGpu = true;
            }
          }
        }

        ns = (static_cast<int32_T>(nfact + 1.0) + a->size[0]) - 1;
        for (offsetH = 0; offsetH <= ns - 2; offsetH++) {
          ny = static_cast<int32_T>(std::fmin(static_cast<real_T>(offsetH) + 1.0,
            static_cast<real_T>(a->size[0])));
          for (vlen = 0; vlen <= ny - 2; vlen++) {
            if (convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(convOut, &gpu_convOut);
            }

            if (a_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(a, &gpu_a);
            }

            a_dirtyOnGpu = false;
            convOut->data[offsetH] -= convOut->data[(offsetH - vlen) - 1] *
              a->data[vlen + 1];
            convOut_dirtyOnGpu = false;
            convOut_dirtyOnCpu = true;
          }
        }

        if (static_cast<int32_T>(nfact + 1.0) > convOut->size[0]) {
          ns = 0;
          ny = -1;
        } else {
          ns = static_cast<int32_T>(nfact + 1.0) - 1;
          ny = convOut->size[0] - 1;
        }

        i1 = zfIIR->size[0];
        zfIIR->size[0] = (ny - ns) + 1;
        emxEnsureCapacity_real_T(zfIIR, i1, &ab_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(zfIIR, &gpu_zfIIR);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ny - ns)
          + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_convOut, convOut);
          }

          convOut_dirtyOnCpu = false;
          ec_filtfilt_kernel189<<<grid, block>>>(gpu_convOut, ns, ny, gpu_zfIIR);
        }

        ns = a->size[0] - 3;
        d_x = a->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_convOut, convOut);
          }

          ec_filtfilt_kernel190<<<grid, block>>>(gpu_convOut,
            static_cast<int32_T>(nfact + 1.0) - 1, gpu_a, ns, d_x, gpu_zfIIR);
        }

        i1 = g_b->size[0];
        g_b->size[0] = b2->size[0];
        emxEnsureCapacity_real_T(g_b, i1, &v_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(g_b, &g_gpu_b);
        iv0 = b2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel191<<<grid, block>>>(gpu_b2, iv0, g_gpu_b);
          e_b_dirtyOnGpu = true;
        }

        i1 = f_a->size[0];
        f_a->size[0] = a2->size[0];
        emxEnsureCapacity_real_T(f_a, i1, &v_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(f_a, &e_gpu_a);
        iv0 = a2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel192<<<grid, block>>>(gpu_a2, iv0, e_gpu_a);
          c_a_dirtyOnGpu = true;
        }

        if ((!std::isinf(a2->data[0])) && (!std::isnan(a2->data[0])) &&
            (!(a2->data[0] == 0.0)) && (a2->data[0] != 1.0)) {
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_nb +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel193<<<grid, block>>>(gpu_a1, b_nb, g_gpu_b);
            e_b_dirtyOnGpu = true;
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel194<<<grid, block>>>(gpu_a1, na, e_gpu_a);
          }

          ec_filtfilt_kernel195<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(e_gpu_a);
          c_a_dirtyOnGpu = true;
        }

        if (f_a->size[0] > g_b->size[0]) {
          idx = f_a->size[0] - g_b->size[0];
          i1 = g_b->size[0];
          vlen = g_b->size[0];
          g_b->size[0] += idx;
          emxEnsureCapacity_real_T(g_b, vlen, &ab_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(g_b, &g_gpu_b);
          if (idx - 1 >= 0) {
            if (e_b_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(g_b, &g_gpu_b);
            }

            std::memset(&g_b->data[i1], 0, static_cast<uint32_T>(idx) * sizeof
                        (real_T));
            e_b_dirtyOnCpu = true;
          }
        }

        zfSize_idx_0 = g_b->size[0] - 1;
        dv1[0] = static_cast<uint32_T>(g_b->size[0]);
        OH = (static_cast<uint32_T>(xCol->size[0]) + static_cast<uint32_T>
              (g_b->size[0])) - 1U;
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }

        thism = g_b->size[0];
        offsetH = static_cast<int32_T>(std::floor(static_cast<real_T>(g_b->size
          [0]) / 2.0)) + static_cast<int32_T>(std::floor((static_cast<real_T>
          (g_b->size[0]) - 1.0) / 2.0));
        if (g_b->size[0] > MAX_int32_T - static_cast<int32_T>(u)) {
          ny = MAX_int32_T;
        } else {
          ny = static_cast<int32_T>(u) + g_b->size[0];
        }

        i1 = f_expanded->size[0];
        f_expanded->size[0] = ny - 1;
        emxEnsureCapacity_real_T(f_expanded, i1, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(f_expanded, &e_gpu_expanded);
        d_x = (static_cast<int32_T>(u) + static_cast<int32_T>(dv1[0])) - 2;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_x + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel196<<<grid, block>>>(d_x, e_gpu_expanded);
        }

        ns = xCol->size[0];
        i1 = m_y->size[0] * m_y->size[1];
        m_y->size[0] = 1;
        m_y->size[1] = xCol->size[0];
        emxEnsureCapacity_int32_T(m_y, i1, &hb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(m_y, &j_gpu_y);
        m_y->data[0] = 1;
        ny = 1;
        for (d_x = 0; d_x <= ns - 2; d_x++) {
          ny++;
          m_y->data[d_x + 1] = ny;
        }

        i1 = iv9->size[0];
        iv9->size[0] = m_y->size[1];
        emxEnsureCapacity_int32_T(iv9, i1, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(iv9, &gpu_iv9);
        d_x = m_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_x + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&j_gpu_y, m_y);
          ec_filtfilt_kernel197<<<grid, block>>>(offsetH, j_gpu_y, d_x, gpu_iv9);
        }

        i1 = xCol->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i1 + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel198<<<grid, block>>>(gpu_xCol, gpu_iv9, i1,
            e_gpu_expanded);
        }

        i1 = g_rows->size[0] * g_rows->size[1];
        g_rows->size[0] = 1;
        g_rows->size[1] = static_cast<int32_T>(dv1[0]);
        emxEnsureCapacity_int32_T(g_rows, i1, &hb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(g_rows, &e_gpu_rows);
        g_rows->data[0] = 0;
        ny = 0;
        for (d_x = 0; d_x <= thism - 2; d_x++) {
          ny++;
          g_rows->data[d_x + 1] = ny;
        }

        i1 = f_convOut->size[0];
        f_convOut->size[0] = static_cast<int32_T>(u);
        emxEnsureCapacity_real_T(f_convOut, i1, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(f_convOut, &d_gpu_convOut);
        r = dim3(static_cast<uint32_T>(std::floor((static_cast<real_T>(OH) +
                    31.0) / 32.0)), 1U, 1U);
        r1 = dim3(32U, 1U, 1U);
        iv0 = g_b->size[0];
        validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>((
          static_cast<int32_T>(u) - 1) + 1L), &r, &r1, &grid, &block, 1024U,
          65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&e_gpu_rows, g_rows);
          if (e_b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&g_gpu_b, g_b);
          }

          ec_filtfilt_kernel199<<<grid, block>>>(e_gpu_expanded, e_gpu_rows,
            g_gpu_b, static_cast<int32_T>(u), iv0, d_gpu_convOut);
          d_convOut_dirtyOnGpu = true;
        }

        if (csz_idx_0 != 0) {
          if (csz_idx_0 == 1) {
            ec_filtfilt_kernel201<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
              (gpu_zfIIR, d_gpu_convOut);
            d_convOut_dirtyOnGpu = true;
          } else {
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((csz_idx_0 - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel200<<<grid, block>>>(gpu_zfIIR, csz_idx_0 - 1,
                d_gpu_convOut);
              d_convOut_dirtyOnGpu = true;
            }
          }
        }

        ns = xCol->size[0] + f_a->size[0];
        for (offsetH = 0; offsetH <= ns - 2; offsetH++) {
          ny = static_cast<int32_T>(std::fmin(static_cast<real_T>(offsetH) + 1.0,
            static_cast<real_T>(f_a->size[0])));
          for (vlen = 0; vlen <= ny - 2; vlen++) {
            if (d_convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(f_convOut, &d_gpu_convOut);
            }

            if (c_a_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(f_a, &e_gpu_a);
            }

            c_a_dirtyOnGpu = false;
            f_convOut->data[offsetH] -= f_convOut->data[(offsetH - vlen) - 1] *
              f_a->data[vlen + 1];
            d_convOut_dirtyOnGpu = false;
            d_convOut_dirtyOnCpu = true;
          }
        }

        if (static_cast<uint32_T>(xCol->size[0]) + 1U > static_cast<uint32_T>
            (f_convOut->size[0])) {
          ns = 0;
          ny = -1;
        } else {
          ns = xCol->size[0];
          ny = f_convOut->size[0] - 1;
        }

        i1 = d_zfIIR->size[0];
        d_zfIIR->size[0] = (ny - ns) + 1;
        emxEnsureCapacity_real_T(d_zfIIR, i1, &ab_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(d_zfIIR, &c_gpu_zfIIR);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ny - ns)
          + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (d_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_convOut, f_convOut);
          }

          d_convOut_dirtyOnCpu = false;
          ec_filtfilt_kernel202<<<grid, block>>>(d_gpu_convOut, ns, ny,
            c_gpu_zfIIR);
        }

        ns = f_a->size[0] - 3;
        d_x = f_a->size[0];
        xCol_dim0 = xCol->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (d_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_convOut, f_convOut);
          }

          d_convOut_dirtyOnCpu = false;
          ec_filtfilt_kernel203<<<grid, block>>>(d_gpu_convOut, e_gpu_a, ns, d_x,
            xCol_dim0, c_gpu_zfIIR);
        }

        ny = xCol->size[0] - 1;
        d1 = 2.0 * xCol->data[xCol->size[0] - 1];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
          static_cast<int32_T>(-((0.0 - nfact) - -1.0)) + 1L), &grid, &block,
          1024U, 65535U);
        if (validLaunchParams) {
          cudaMemcpy(gpu_d1, &d1, 8UL, cudaMemcpyHostToDevice);
          ec_filtfilt_kernel204<<<grid, block>>>(gpu_d1, gpu_xCol, ny, 0.0 -
            nfact, *gpu_rhs_data);
        }

        i1 = i_b->size[0];
        i_b->size[0] = b2->size[0];
        emxEnsureCapacity_real_T(i_b, i1, &v_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(i_b, &k_gpu_b);
        iv0 = b2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel205<<<grid, block>>>(gpu_b2, iv0, k_gpu_b);
          i_b_dirtyOnGpu = true;
        }

        i1 = h_a->size[0];
        h_a->size[0] = a2->size[0];
        emxEnsureCapacity_real_T(h_a, i1, &v_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(h_a, &i_gpu_a);
        iv0 = a2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel206<<<grid, block>>>(gpu_a2, iv0, i_gpu_a);
          e_a_dirtyOnGpu = true;
        }

        if ((!std::isinf(a2->data[0])) && (!std::isnan(a2->data[0])) &&
            (!(a2->data[0] == 0.0)) && (a2->data[0] != 1.0)) {
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(c_nb +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel207<<<grid, block>>>(e_gpu_a1, c_nb, k_gpu_b);
            i_b_dirtyOnGpu = true;
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel208<<<grid, block>>>(e_gpu_a1, b_na, i_gpu_a);
          }

          ec_filtfilt_kernel209<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(i_gpu_a);
          e_a_dirtyOnGpu = true;
        }

        if (h_a->size[0] > i_b->size[0]) {
          idx = h_a->size[0] - i_b->size[0];
          i1 = i_b->size[0];
          vlen = i_b->size[0];
          i_b->size[0] += idx;
          emxEnsureCapacity_real_T(i_b, vlen, &ab_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(i_b, &k_gpu_b);
          if (idx - 1 >= 0) {
            if (i_b_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(i_b, &k_gpu_b);
            }

            std::memset(&i_b->data[i1], 0, static_cast<uint32_T>(idx) * sizeof
                        (real_T));
            i_b_dirtyOnCpu = true;
          }
        }

        dv1[0] = static_cast<uint32_T>(i_b->size[0]);
        OH = static_cast<uint32_T>(static_cast<int32_T>(-((0.0 - nfact) - -1.0)))
          + static_cast<uint32_T>(i_b->size[0]);
        nc = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }

        thism = i_b->size[0];
        offsetH = static_cast<int32_T>(std::floor(static_cast<real_T>(i_b->size
          [0]) / 2.0)) + static_cast<int32_T>(std::floor((static_cast<real_T>
          (i_b->size[0]) - 1.0) / 2.0));
        if ((static_cast<int32_T>(u) > 0) && (i_b->size[0] > MAX_int32_T -
             static_cast<int32_T>(u))) {
          ny = MAX_int32_T;
        } else {
          ny = static_cast<int32_T>(u) + i_b->size[0];
        }

        i1 = h_expanded->size[0];
        h_expanded->size[0] = ny - 1;
        emxEnsureCapacity_real_T(h_expanded, i1, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(h_expanded, &i_gpu_expanded);
        d_x = (static_cast<int32_T>(u) + static_cast<int32_T>(dv1[0])) - 2;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_x + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel210<<<grid, block>>>(d_x, i_gpu_expanded);
        }

        i1 = static_cast<int32_T>(-((0.0 - nfact) - -1.0)) + 1;
        vlen = q_y->size[0] * q_y->size[1];
        q_y->size[0] = 1;
        q_y->size[1] = static_cast<int32_T>(-((0.0 - nfact) - -1.0)) + 1;
        emxEnsureCapacity_int32_T(q_y, vlen, &hb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(q_y, &r_gpu_y);
        q_y->data[0] = 1;
        ny = 1;
        for (d_x = 0; d_x <= i1 - 2; d_x++) {
          ny++;
          q_y->data[d_x + 1] = ny;
        }

        i1 = iv12->size[0];
        iv12->size[0] = q_y->size[1];
        emxEnsureCapacity_int32_T(iv12, i1, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(iv12, &gpu_iv12);
        d_x = q_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_x + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&r_gpu_y, q_y);
          ec_filtfilt_kernel211<<<grid, block>>>(offsetH, r_gpu_y, d_x, gpu_iv12);
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
          static_cast<int32_T>(-((0.0 - nfact) - -1.0)) + 1L), &grid, &block,
          1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel212<<<grid, block>>>(*gpu_rhs_data, gpu_iv12,
            static_cast<int32_T>(-((0.0 - nfact) - -1.0)), i_gpu_expanded);
        }

        i1 = i_rows->size[0] * i_rows->size[1];
        i_rows->size[0] = 1;
        i_rows->size[1] = static_cast<int32_T>(dv1[0]);
        emxEnsureCapacity_int32_T(i_rows, i1, &hb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(i_rows, &i_gpu_rows);
        i_rows->data[0] = 0;
        ny = 0;
        for (d_x = 0; d_x <= thism - 2; d_x++) {
          ny++;
          i_rows->data[d_x + 1] = ny;
        }

        i1 = h_convOut->size[0];
        h_convOut->size[0] = static_cast<int32_T>(u);
        emxEnsureCapacity_real_T(h_convOut, i1, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(h_convOut, &m_gpu_convOut);
        r = dim3(static_cast<uint32_T>(std::floor((static_cast<real_T>(OH +
          static_cast<uint32_T>(nc)) - 1.0) / static_cast<real_T>(nc))), 1U, 1U);
        r1 = dim3(static_cast<uint32_T>(nc), 1U, 1U);
        iv0 = i_b->size[0];
        validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>((
          static_cast<int32_T>(u) - 1) + 1L), &r, &r1, &grid, &block, 1024U,
          65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&i_gpu_rows, i_rows);
          if (i_b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&k_gpu_b, i_b);
          }

          ec_filtfilt_kernel213<<<grid, block>>>(i_gpu_expanded, i_gpu_rows,
            k_gpu_b, static_cast<int32_T>(u), iv0, m_gpu_convOut);
          h_convOut_dirtyOnGpu = true;
        }

        if (zfSize_idx_0 != 0) {
          if (zfSize_idx_0 == 1) {
            ec_filtfilt_kernel215<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
              (c_gpu_zfIIR, m_gpu_convOut);
            h_convOut_dirtyOnGpu = true;
          } else {
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((zfSize_idx_0 - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel214<<<grid, block>>>(c_gpu_zfIIR, zfSize_idx_0 -
                1, m_gpu_convOut);
              h_convOut_dirtyOnGpu = true;
            }
          }
        }

        ns = (static_cast<int32_T>(-((0.0 - nfact) - -1.0)) + h_a->size[0]) + 1;
        for (offsetH = 0; offsetH <= ns - 2; offsetH++) {
          ny = static_cast<int32_T>(std::fmin(static_cast<real_T>(offsetH) + 1.0,
            static_cast<real_T>(h_a->size[0])));
          for (vlen = 0; vlen <= ny - 2; vlen++) {
            if (h_convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(h_convOut, &m_gpu_convOut);
            }

            if (e_a_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(h_a, &i_gpu_a);
            }

            e_a_dirtyOnGpu = false;
            h_convOut->data[offsetH] -= h_convOut->data[(offsetH - vlen) - 1] *
              h_a->data[vlen + 1];
            h_convOut_dirtyOnGpu = false;
            h_convOut_dirtyOnCpu = true;
          }
        }

        csz_idx_0 = static_cast<int32_T>(-((0.0 - nfact) - -1.0)) + 1;
        if (h_convOut_dirtyOnGpu) {
          gpuEmxMemcpyGpuToCpu_real_T(h_convOut, &m_gpu_convOut);
        }

        val = h_convOut->data[static_cast<int32_T>(-((0.0 - nfact) - -1.0))];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
          ((zi_size[0] - 1) + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          cudaMemcpy(gpu_val, &val, 8UL, cudaMemcpyHostToDevice);
          if (zi_data_dirtyOnCpu) {
            cudaMemcpy(*gpu_zi_data, SD->f0.zi_data, 1073741816UL,
                       cudaMemcpyHostToDevice);
          }

          if (outBuff_data_dirtyOnCpu) {
            cudaMemcpy(*gpu_outBuff_data, SD->f0.outBuff_data, 1073741816UL,
                       cudaMemcpyHostToDevice);
          }

          ec_filtfilt_kernel216<<<grid, block>>>(gpu_val, *gpu_zi_data, zi_size
            [0] - 1, *gpu_outBuff_data);
          outBuff_data_dirtyOnCpu = false;
        }

        i1 = l_b->size[0];
        l_b->size[0] = b2->size[0];
        emxEnsureCapacity_real_T(l_b, i1, &v_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(l_b, &m_gpu_b);
        iv0 = b2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel217<<<grid, block>>>(gpu_b2, iv0, m_gpu_b);
          k_b_dirtyOnGpu = true;
        }

        i1 = k_a->size[0];
        k_a->size[0] = a2->size[0];
        emxEnsureCapacity_real_T(k_a, i1, &v_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(k_a, &k_gpu_a);
        iv0 = a2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel218<<<grid, block>>>(gpu_a2, iv0, k_gpu_a);
          f_a_dirtyOnGpu = true;
        }

        if ((!std::isinf(a2->data[0])) && (!std::isnan(a2->data[0])) &&
            (!(a2->data[0] == 0.0)) && (a2->data[0] != 1.0)) {
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_nb +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel219<<<grid, block>>>(d_gpu_a1, d_nb, m_gpu_b);
            k_b_dirtyOnGpu = true;
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(c_na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel220<<<grid, block>>>(d_gpu_a1, c_na, k_gpu_a);
          }

          ec_filtfilt_kernel221<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(k_gpu_a);
          f_a_dirtyOnGpu = true;
        }

        if (k_a->size[0] > l_b->size[0]) {
          idx = k_a->size[0] - l_b->size[0];
          i1 = l_b->size[0];
          vlen = l_b->size[0];
          l_b->size[0] += idx;
          emxEnsureCapacity_real_T(l_b, vlen, &ab_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(l_b, &m_gpu_b);
          if (idx - 1 >= 0) {
            if (k_b_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(l_b, &m_gpu_b);
            }

            std::memset(&l_b->data[i1], 0, static_cast<uint32_T>(idx) * sizeof
                        (real_T));
            k_b_dirtyOnCpu = true;
          }
        }

        zfSize_idx_0 = l_b->size[0] - 1;
        dv1[0] = static_cast<uint32_T>(l_b->size[0]);
        OH = static_cast<uint32_T>(static_cast<int32_T>(-((0.0 - nfact) - -1.0)))
          + static_cast<uint32_T>(l_b->size[0]);
        nc = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }

        thism = l_b->size[0];
        offsetH = static_cast<int32_T>(std::floor(static_cast<real_T>(l_b->size
          [0]) / 2.0)) + static_cast<int32_T>(std::floor((static_cast<real_T>
          (l_b->size[0]) - 1.0) / 2.0));
        if ((static_cast<int32_T>(u) > 0) && (l_b->size[0] > MAX_int32_T -
             static_cast<int32_T>(u))) {
          ny = MAX_int32_T;
        } else {
          ny = static_cast<int32_T>(u) + l_b->size[0];
        }

        i1 = k_expanded->size[0];
        k_expanded->size[0] = ny - 1;
        emxEnsureCapacity_real_T(k_expanded, i1, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(k_expanded, &k_gpu_expanded);
        d_x = (static_cast<int32_T>(u) + static_cast<int32_T>(dv1[0])) - 2;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_x + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel222<<<grid, block>>>(d_x, k_gpu_expanded);
        }

        ns = static_cast<int32_T>(-((0.0 - nfact) - -1.0)) + 1;
        i1 = v_y->size[0] * v_y->size[1];
        v_y->size[0] = 1;
        v_y->size[1] = static_cast<int32_T>(-((0.0 - nfact) - -1.0)) + 1;
        emxEnsureCapacity_int32_T(v_y, i1, &hb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(v_y, &v_gpu_y);
        v_y->data[0] = 1;
        ny = 1;
        for (d_x = 0; d_x <= ns - 2; d_x++) {
          ny++;
          v_y->data[d_x + 1] = ny;
        }

        i1 = iv17->size[0];
        iv17->size[0] = v_y->size[1];
        emxEnsureCapacity_int32_T(iv17, i1, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(iv17, &gpu_iv17);
        d_x = v_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_x + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&v_gpu_y, v_y);
          ec_filtfilt_kernel223<<<grid, block>>>(offsetH, v_gpu_y, d_x, gpu_iv17);
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(
          static_cast<int32_T>(-((0.0 - nfact) - -1.0)) + 1L), &grid, &block,
          1024U, 65535U);
        if (validLaunchParams) {
          if (h_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&m_gpu_convOut, h_convOut);
          }

          ec_filtfilt_kernel224<<<grid, block>>>(m_gpu_convOut,
            static_cast<int32_T>(-((0.0 - nfact) - -1.0)), gpu_iv17,
            static_cast<int32_T>(-((0.0 - nfact) - -1.0)), k_gpu_expanded);
        }

        i1 = l_rows->size[0] * l_rows->size[1];
        l_rows->size[0] = 1;
        l_rows->size[1] = static_cast<int32_T>(dv1[0]);
        emxEnsureCapacity_int32_T(l_rows, i1, &hb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(l_rows, &l_gpu_rows);
        l_rows->data[0] = 0;
        ny = 0;
        for (d_x = 0; d_x <= thism - 2; d_x++) {
          ny++;
          l_rows->data[d_x + 1] = ny;
        }

        i1 = k_convOut->size[0];
        k_convOut->size[0] = static_cast<int32_T>(u);
        emxEnsureCapacity_real_T(k_convOut, i1, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(k_convOut, &s_gpu_convOut);
        r = dim3(static_cast<uint32_T>(std::floor((static_cast<real_T>(OH +
          static_cast<uint32_T>(nc)) - 1.0) / static_cast<real_T>(nc))), 1U, 1U);
        r1 = dim3(static_cast<uint32_T>(nc), 1U, 1U);
        iv0 = l_b->size[0];
        validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>((
          static_cast<int32_T>(u) - 1) + 1L), &r, &r1, &grid, &block, 1024U,
          65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&l_gpu_rows, l_rows);
          if (k_b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&m_gpu_b, l_b);
          }

          ec_filtfilt_kernel225<<<grid, block>>>(k_gpu_expanded, l_gpu_rows,
            m_gpu_b, static_cast<int32_T>(u), iv0, s_gpu_convOut);
          k_convOut_dirtyOnGpu = true;
        }

        if (zi_size[0] != 0) {
          if (zi_size[0] == 1) {
            if (outBuff_data_dirtyOnCpu) {
              cudaMemcpy(*gpu_outBuff_data, SD->f0.outBuff_data, 1073741816UL,
                         cudaMemcpyHostToDevice);
            }

            ec_filtfilt_kernel227<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
              (*gpu_outBuff_data, s_gpu_convOut);
            k_convOut_dirtyOnGpu = true;
          } else {
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((zi_size[0] - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              if (outBuff_data_dirtyOnCpu) {
                cudaMemcpy(*gpu_outBuff_data, SD->f0.outBuff_data, 1073741816UL,
                           cudaMemcpyHostToDevice);
              }

              ec_filtfilt_kernel226<<<grid, block>>>(*gpu_outBuff_data, zi_size
                [0] - 1, s_gpu_convOut);
              k_convOut_dirtyOnGpu = true;
            }
          }
        }

        ns = (static_cast<int32_T>(-((0.0 - nfact) - -1.0)) + k_a->size[0]) + 1;
        for (offsetH = 0; offsetH <= ns - 2; offsetH++) {
          ny = static_cast<int32_T>(std::fmin(static_cast<real_T>(offsetH) + 1.0,
            static_cast<real_T>(k_a->size[0])));
          for (vlen = 0; vlen <= ny - 2; vlen++) {
            if (k_convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(k_convOut, &s_gpu_convOut);
            }

            if (f_a_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(k_a, &k_gpu_a);
            }

            f_a_dirtyOnGpu = false;
            k_convOut->data[offsetH] -= k_convOut->data[(offsetH - vlen) - 1] *
              k_a->data[vlen + 1];
            k_convOut_dirtyOnGpu = false;
            k_convOut_dirtyOnCpu = true;
          }
        }

        if (static_cast<int32_T>(-((0.0 - nfact) - -1.0)) + 2 > k_convOut->size
            [0]) {
          csz_idx_0 = 0;
          ns = -1;
        } else {
          ns = k_convOut->size[0] - 1;
        }

        i1 = f_zfIIR->size[0];
        f_zfIIR->size[0] = (ns - csz_idx_0) + 1;
        emxEnsureCapacity_real_T(f_zfIIR, i1, &ab_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(f_zfIIR, &f_gpu_zfIIR);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ns -
          csz_idx_0) + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (k_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&s_gpu_convOut, k_convOut);
          }

          k_convOut_dirtyOnCpu = false;
          ec_filtfilt_kernel228<<<grid, block>>>(s_gpu_convOut, csz_idx_0, ns,
            f_gpu_zfIIR);
        }

        ns = k_a->size[0] - 3;
        d_x = k_a->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (k_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&s_gpu_convOut, k_convOut);
          }

          ec_filtfilt_kernel229<<<grid, block>>>(s_gpu_convOut,
            static_cast<int32_T>(-((0.0 - nfact) - -1.0)) + 1, k_gpu_a, ns, d_x,
            f_gpu_zfIIR);
        }

        ns = xCol->size[0];
        i1 = m_b->size[0];
        m_b->size[0] = b2->size[0];
        emxEnsureCapacity_real_T(m_b, i1, &v_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(m_b, &n_gpu_b);
        iv0 = b2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel230<<<grid, block>>>(gpu_b2, iv0, n_gpu_b);
          l_b_dirtyOnGpu = true;
        }

        i1 = l_a->size[0];
        l_a->size[0] = a2->size[0];
        emxEnsureCapacity_real_T(l_a, i1, &v_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(l_a, &l_gpu_a);
        iv0 = a2->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel231<<<grid, block>>>(gpu_a2, iv0, l_gpu_a);
          g_a_dirtyOnGpu = true;
        }

        if ((!std::isinf(a2->data[0])) && (!std::isnan(a2->data[0])) &&
            (!(a2->data[0] == 0.0)) && (a2->data[0] != 1.0)) {
          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(e_nb +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel232<<<grid, block>>>(c_gpu_a1, e_nb, n_gpu_b);
            l_b_dirtyOnGpu = true;
          }

          validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_na +
            1L), &grid, &block, 1024U, 65535U);
          if (validLaunchParams) {
            ec_filtfilt_kernel233<<<grid, block>>>(c_gpu_a1, d_na, l_gpu_a);
          }

          ec_filtfilt_kernel234<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(l_gpu_a);
          g_a_dirtyOnGpu = true;
        }

        if (l_a->size[0] > m_b->size[0]) {
          idx = l_a->size[0] - m_b->size[0];
          i1 = m_b->size[0];
          vlen = m_b->size[0];
          m_b->size[0] += idx;
          emxEnsureCapacity_real_T(m_b, vlen, &ab_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(m_b, &n_gpu_b);
          if (idx - 1 >= 0) {
            if (l_b_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(m_b, &n_gpu_b);
            }

            std::memset(&m_b->data[i1], 0, static_cast<uint32_T>(idx) * sizeof
                        (real_T));
            l_b_dirtyOnCpu = true;
          }
        }

        dv1[0] = static_cast<uint32_T>(m_b->size[0]);
        OH = (static_cast<uint32_T>(xCol->size[0]) + static_cast<uint32_T>
              (m_b->size[0])) - 1U;
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }

        thism = m_b->size[0];
        offsetH = static_cast<int32_T>(std::floor(static_cast<real_T>(m_b->size
          [0]) / 2.0)) + static_cast<int32_T>(std::floor((static_cast<real_T>
          (m_b->size[0]) - 1.0) / 2.0));
        if (m_b->size[0] > MAX_int32_T - static_cast<int32_T>(u)) {
          ny = MAX_int32_T;
        } else {
          ny = static_cast<int32_T>(u) + m_b->size[0];
        }

        i1 = l_expanded->size[0];
        l_expanded->size[0] = ny - 1;
        emxEnsureCapacity_real_T(l_expanded, i1, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(l_expanded, &l_gpu_expanded);
        d_x = (static_cast<int32_T>(u) + static_cast<int32_T>(dv1[0])) - 2;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_x + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel235<<<grid, block>>>(d_x, l_gpu_expanded);
        }

        i1 = w_y->size[0] * w_y->size[1];
        w_y->size[0] = 1;
        w_y->size[1] = xCol->size[0];
        emxEnsureCapacity_int32_T(w_y, i1, &hb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(w_y, &w_gpu_y);
        w_y->data[0] = 1;
        ny = 1;
        for (d_x = 0; d_x <= ns - 2; d_x++) {
          ny++;
          w_y->data[d_x + 1] = ny;
        }

        i1 = iv18->size[0];
        iv18->size[0] = w_y->size[1];
        emxEnsureCapacity_int32_T(iv18, i1, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(iv18, &gpu_iv18);
        d_x = w_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_x + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&w_gpu_y, w_y);
          ec_filtfilt_kernel236<<<grid, block>>>(offsetH, w_gpu_y, d_x, gpu_iv18);
        }

        i1 = xCol->size[0] - 1;
        vlen = xCol->size[0] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(vlen +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (d_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&d_gpu_convOut, f_convOut);
          }

          ec_filtfilt_kernel237<<<grid, block>>>(d_gpu_convOut, i1, gpu_iv18,
            vlen, l_gpu_expanded);
        }

        i1 = m_rows->size[0] * m_rows->size[1];
        m_rows->size[0] = 1;
        m_rows->size[1] = static_cast<int32_T>(dv1[0]);
        emxEnsureCapacity_int32_T(m_rows, i1, &hb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(m_rows, &m_gpu_rows);
        m_rows->data[0] = 0;
        ny = 0;
        for (d_x = 0; d_x <= thism - 2; d_x++) {
          ny++;
          m_rows->data[d_x + 1] = ny;
        }

        i1 = l_convOut->size[0];
        l_convOut->size[0] = static_cast<int32_T>(u);
        emxEnsureCapacity_real_T(l_convOut, i1, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(l_convOut, &t_gpu_convOut);
        r = dim3(static_cast<uint32_T>(std::floor((static_cast<real_T>(OH) +
                    31.0) / 32.0)), 1U, 1U);
        r1 = dim3(32U, 1U, 1U);
        iv0 = m_b->size[0];
        validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>((
          static_cast<int32_T>(u) - 1) + 1L), &r, &r1, &grid, &block, 1024U,
          65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&m_gpu_rows, m_rows);
          if (l_b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&n_gpu_b, m_b);
          }

          ec_filtfilt_kernel238<<<grid, block>>>(l_gpu_expanded, m_gpu_rows,
            n_gpu_b, static_cast<int32_T>(u), iv0, t_gpu_convOut);
          l_convOut_dirtyOnGpu = true;
        }

        if (zfSize_idx_0 != 0) {
          if (zfSize_idx_0 == 1) {
            ec_filtfilt_kernel240<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
              (f_gpu_zfIIR, t_gpu_convOut);
            l_convOut_dirtyOnGpu = true;
          } else {
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
              ((zfSize_idx_0 - 1) + 1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel239<<<grid, block>>>(f_gpu_zfIIR, zfSize_idx_0 -
                1, t_gpu_convOut);
              l_convOut_dirtyOnGpu = true;
            }
          }
        }

        ns = xCol->size[0] + l_a->size[0];
        for (offsetH = 0; offsetH <= ns - 2; offsetH++) {
          ny = static_cast<int32_T>(std::fmin(static_cast<real_T>(offsetH) + 1.0,
            static_cast<real_T>(l_a->size[0])));
          for (vlen = 0; vlen <= ny - 2; vlen++) {
            if (l_convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(l_convOut, &t_gpu_convOut);
            }

            if (g_a_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(l_a, &l_gpu_a);
            }

            g_a_dirtyOnGpu = false;
            l_convOut->data[offsetH] -= l_convOut->data[(offsetH - vlen) - 1] *
              l_a->data[vlen + 1];
            l_convOut_dirtyOnGpu = false;
            l_convOut_dirtyOnCpu = true;
          }
        }

        ny = xCol->size[0];
        i1 = xCol->size[0] - 1;
        vlen = u_convOut->size[0];
        u_convOut->size[0] = xCol->size[0];
        emxEnsureCapacity_real_T(u_convOut, vlen, &v_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(u_convOut, &u_gpu_convOut);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(i1 + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (l_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&t_gpu_convOut, l_convOut);
          }

          ec_filtfilt_kernel241<<<grid, block>>>(t_gpu_convOut, i1,
            u_gpu_convOut);
        }

        i1 = xCol->size[0] * xCol->size[1];
        xCol->size[0] = ny;
        xCol->size[1] = 1;
        emxEnsureCapacity_real_T(xCol, i1, &ub_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(xCol, &gpu_xCol);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ny - 1)
          + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel242<<<grid, block>>>(u_gpu_convOut, ny, gpu_xCol);
        }
      }
    } else {
      int32_T b_na;
      int32_T b_nb;
      int32_T c_na;
      int32_T c_nb;
      int32_T csz_idx_0;
      int32_T d_na;
      int32_T d_nb;
      int32_T e_nb;
      int32_T i1;
      int32_T na;
      int32_T nb;
      uint32_T sz[2];
      uint32_T OH;
      uint32_T u;
      for (iv0 = 0; iv0 < 2; iv0++) {
        sz[iv0] = static_cast<uint32_T>(xCol->size[iv0]);
      }

      ny = xCol->size[0];
      iv0 = xCol->size[0] * xCol->size[1];
      xCol->size[0] = static_cast<int32_T>(sz[0]);
      emxEnsureCapacity_real_T(xCol, iv0, &l_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(xCol, &gpu_xCol);
      if (sz[0] == 0U) {
        emlrtDivisionByZeroErrorR2012b(&ic_emlrtRTEI, emlrtRootTLSGlobal);
      } else {
        iv0 = static_cast<int32_T>(static_cast<uint32_T>(ny * xCol->size[1]) /
          sz[0]);
      }

      i1 = xCol->size[0] * xCol->size[1];
      xCol->size[1] = iv0;
      emxEnsureCapacity_real_T(xCol, i1, &l_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(xCol, &gpu_xCol);
      offsetH = a2->size[0] - 2;
      nb = b2->size[0] - 1;
      na = a2->size[0] - 2;
      b_nb = b2->size[0] - 1;
      b_na = a2->size[0] - 2;
      c_nb = b2->size[0] - 1;
      c_na = a2->size[0] - 2;
      d_nb = b2->size[0] - 1;
      d_na = a2->size[0] - 2;
      e_nb = b2->size[0] - 1;
      if (issos) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_a2, a2);
      }

      ec_filtfilt_kernel74<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_a2,
        c_gpu_a1, d_gpu_a1, e_gpu_a1, gpu_a1, b_gpu_a1);
      iv0 = b_y->size[0] * b_y->size[1];
      b_y->size[0] = 1;
      b_y->size[1] = xCol->size[1];
      emxEnsureCapacity_real_T(b_y, iv0, &s_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(b_y, &b_gpu_y);
      d_x = xCol->size[1] - 1;
      xCol_dim0 = xCol->size[0];
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_x + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_filtfilt_kernel75<<<grid, block>>>(gpu_xCol, d_x, xCol_dim0, b_gpu_y);
      }

      ns = xCol->size[1];
      ny = b_y->size[1];
      if (ns <= ny) {
        ny = ns;
      }

      if (xCol->size[1] == 1) {
        vlen = b_y->size[1];
      } else if (b_y->size[1] == 1) {
        vlen = xCol->size[1];
      } else if (b_y->size[1] == xCol->size[1]) {
        vlen = b_y->size[1];
      } else {
        vlen = ny;
      }

      iv0 = xt->size[0] * xt->size[1];
      xt->size[0] = static_cast<int32_T>(nfact + 1.0) - 1;
      ns = xCol->size[1];
      ny = b_y->size[1];
      if (ns <= ny) {
        ny = ns;
      }

      if (xCol->size[1] == 1) {
        xt->size[1] = b_y->size[1];
      } else if (b_y->size[1] == 1) {
        xt->size[1] = xCol->size[1];
      } else if (b_y->size[1] == xCol->size[1]) {
        xt->size[1] = b_y->size[1];
      } else {
        xt->size[1] = ny;
      }

      emxEnsureCapacity_real_T(xt, iv0, &x_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(xt, &gpu_xt);
      if (vlen != 0) {
        ns = (b_y->size[1] != 1);
        ny = (xCol->size[1] != 1);
        d_x = xt->size[0] - 1;
        i1 = xt->size[0];
        xCol_dim0 = xCol->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((d_x +
          1L) * ((vlen - 1) + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel76<<<grid, block>>>(gpu_xCol, b_gpu_y, nfact, ny, ns,
            d_x, vlen, i1, xCol_dim0, gpu_xt);
        }
      }

      iv0 = c_y->size[0] * c_y->size[1];
      c_y->size[0] = zi_size[0];
      c_y->size[1] = xt->size[1];
      emxEnsureCapacity_real_T(c_y, iv0, &y_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(c_y, &c_gpu_y);
      idx = xt->size[1] - 1;
      xCol_dim0 = c_y->size[0];
      i1 = xt->size[0];
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((zi_size
        [0] - 1) + 1L) * (idx + 1L)), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (zi_data_dirtyOnCpu) {
          cudaMemcpy(*gpu_zi_data, SD->f0.zi_data, 1073741816UL,
                     cudaMemcpyHostToDevice);
        }

        zi_data_dirtyOnCpu = false;
        ec_filtfilt_kernel77<<<grid, block>>>(gpu_xt, *gpu_zi_data, zi_size[0] -
          1, idx, xCol_dim0, i1, c_gpu_y);
      }

      iv0 = d_b->size[0];
      d_b->size[0] = b2->size[0];
      emxEnsureCapacity_real_T(d_b, iv0, &db_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(d_b, &e_gpu_b);
      iv0 = b2->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_filtfilt_kernel78<<<grid, block>>>(gpu_b2, iv0, e_gpu_b);
        c_b_dirtyOnGpu = true;
      }

      iv0 = c_a->size[0];
      c_a->size[0] = a2->size[0];
      emxEnsureCapacity_real_T(c_a, iv0, &db_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(c_a, &c_gpu_a);
      iv0 = a2->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_filtfilt_kernel79<<<grid, block>>>(gpu_a2, iv0, c_gpu_a);
      }

      iv0 = zi->size[0] * zi->size[1];
      zi->size[0] = zi_size[0];
      zi->size[1] = xt->size[1];
      emxEnsureCapacity_real_T(zi, iv0, &gb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(zi, &gpu_zi);
      idx = xt->size[1] - 1;
      i1 = xt->size[0];
      iv0 = zi->size[0];
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((zi_size
        [0] - 1) + 1L) * (idx + 1L)), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (zi_data_dirtyOnCpu) {
          cudaMemcpy(*gpu_zi_data, SD->f0.zi_data, 1073741816UL,
                     cudaMemcpyHostToDevice);
        }

        zi_data_dirtyOnCpu = false;
        ec_filtfilt_kernel80<<<grid, block>>>(gpu_xt, *gpu_zi_data, zi_size[0] -
          1, idx, i1, iv0, gpu_zi);
        zi_dirtyOnGpu = true;
      }

      if (maxCoefNum_dirtyOnGpu) {
        gpuEmxMemcpyGpuToCpu_real_T(a2, &gpu_a2);
      }

      if ((!std::isinf(a2->data[0])) && (!std::isnan(a2->data[0])) &&
          (!(a2->data[0] == 0.0)) && (a2->data[0] != 1.0)) {
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(nb + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel81<<<grid, block>>>(b_gpu_a1, nb, e_gpu_b);
          c_b_dirtyOnGpu = true;
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(offsetH
          + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel82<<<grid, block>>>(b_gpu_a1, offsetH, c_gpu_a);
        }

        ec_filtfilt_kernel83<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(c_gpu_a);
      }

      if (c_a->size[0] > d_b->size[0]) {
        idx = c_a->size[0] - d_b->size[0];
        iv0 = d_b->size[0];
        i1 = d_b->size[0];
        d_b->size[0] += idx;
        emxEnsureCapacity_real_T(d_b, i1, &ab_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(d_b, &e_gpu_b);
        if (idx - 1 >= 0) {
          if (c_b_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(d_b, &e_gpu_b);
          }

          std::memset(&d_b->data[iv0], 0, static_cast<uint32_T>(idx) * sizeof
                      (real_T));
          c_b_dirtyOnCpu = true;
        }
      }

      for (iv0 = 0; iv0 < 2; iv0++) {
        zfSize[iv0] = static_cast<uint32_T>(xt->size[iv0]);
        zfSize_dirtyOnCpu = true;
      }

      iv0 = d_b->size[0];
      if (c_b_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&e_gpu_b, d_b);
      }

      if (zfSize_dirtyOnCpu) {
        cudaMemcpy(*gpu_zfSize, zfSize, 8UL, cudaMemcpyHostToDevice);
      }

      ec_filtfilt_kernel84<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(iv0,
        *gpu_zfSize);
      zfSize_dirtyOnCpu = false;
      if (xt->size[1] == 0) {
        iv0 = b_zfIIR->size[0] * b_zfIIR->size[1];
        b_zfIIR->size[0] = d_b->size[0] - 1;
        cudaMemcpy(zfSize, *gpu_zfSize, 8UL, cudaMemcpyDeviceToHost);
        b_zfIIR->size[1] = static_cast<int32_T>(zfSize[1]);
        emxEnsureCapacity_real_T(b_zfIIR, iv0, &ab_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_zfIIR, &b_gpu_zfIIR);
      } else {
        iv0 = d_b->size[0];
        if (dv1_dirtyOnCpu) {
          cudaMemcpy(*gpu_dv1, dv1, 8UL, cudaMemcpyHostToDevice);
        }

        ec_filtfilt_kernel85<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(iv0,
          *gpu_dv1);
        OH = (static_cast<uint32_T>(xt->size[0]) + static_cast<uint32_T>
              (d_b->size[0])) - 1U;
        nc = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
        vlen = static_cast<int32_T>(std::fmin(32.0, (static_cast<real_T>
          (xt->size[1]) + 1.0) - 1.0));
        zfSize_idx_0 = xt->size[1] - 1;
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }

        thism = d_b->size[0];
        offsetH = static_cast<int32_T>(std::floor(static_cast<real_T>(d_b->size
          [0]) / 2.0)) + static_cast<int32_T>(std::floor((static_cast<real_T>
          (d_b->size[0]) - 1.0) / 2.0));
        if ((static_cast<int32_T>(u) > 0) && (d_b->size[0] > MAX_int32_T -
             static_cast<int32_T>(u))) {
          ny = MAX_int32_T;
        } else {
          ny = static_cast<int32_T>(u) + d_b->size[0];
        }

        iv0 = c_expanded->size[0] * c_expanded->size[1];
        c_expanded->size[0] = ny - 1;
        emxEnsureCapacity_real_T(c_expanded, iv0, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(c_expanded, &c_gpu_expanded);
        if (xt->size[1] > 2147483646) {
          ny = MAX_int32_T;
        } else {
          ny = xt->size[1] + 1;
        }

        iv0 = c_expanded->size[0] * c_expanded->size[1];
        c_expanded->size[1] = ny - 1;
        emxEnsureCapacity_real_T(c_expanded, iv0, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(c_expanded, &c_gpu_expanded);
        cudaMemcpy(dv1, *gpu_dv1, 8UL, cudaMemcpyDeviceToHost);
        d_x = ((static_cast<int32_T>(u) + static_cast<int32_T>(dv1[0])) - 1) *
          xt->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_x + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel86<<<grid, block>>>(d_x, c_gpu_expanded);
        }

        ns = xt->size[0];
        iv0 = f_y->size[0] * f_y->size[1];
        f_y->size[0] = 1;
        f_y->size[1] = xt->size[0];
        emxEnsureCapacity_int32_T(f_y, iv0, &hb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(f_y, &f_gpu_y);
        f_y->data[0] = 1;
        ny = 1;
        for (d_x = 0; d_x <= ns - 2; d_x++) {
          ny++;
          f_y->data[d_x + 1] = ny;
        }

        iv0 = iv3->size[0];
        iv3->size[0] = f_y->size[1];
        emxEnsureCapacity_int32_T(iv3, iv0, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(iv3, &gpu_iv3);
        d_x = f_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_x + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&f_gpu_y, f_y);
          ec_filtfilt_kernel87<<<grid, block>>>(offsetH, f_gpu_y, d_x, gpu_iv3);
        }

        ns = xt->size[1];
        iv0 = g_y->size[0] * g_y->size[1];
        g_y->size[0] = 1;
        g_y->size[1] = xt->size[1];
        emxEnsureCapacity_int32_T(g_y, iv0, &hb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(g_y, &h_gpu_y);
        g_y->data[0] = 1;
        ny = 1;
        for (d_x = 0; d_x <= ns - 2; d_x++) {
          ny++;
          g_y->data[d_x + 1] = ny;
        }

        iv0 = iv4->size[0];
        iv4->size[0] = g_y->size[1];
        emxEnsureCapacity_int32_T(iv4, iv0, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(iv4, &gpu_iv4);
        d_x = g_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_x + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&h_gpu_y, g_y);
          ec_filtfilt_kernel88<<<grid, block>>>(h_gpu_y, d_x, gpu_iv4);
        }

        d_x = xt->size[1] - 1;
        iv0 = xt->size[0] - 1;
        nb = c_expanded->size[0];
        i1 = xt->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0 +
          1L) * (d_x + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel89<<<grid, block>>>(gpu_xt, gpu_iv4, gpu_iv3, iv0,
            d_x, nb, i1, c_gpu_expanded);
        }

        iv0 = d_rows->size[0] * d_rows->size[1];
        d_rows->size[0] = 1;
        d_rows->size[1] = static_cast<int32_T>(dv1[0]);
        emxEnsureCapacity_int32_T(d_rows, iv0, &hb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(d_rows, &d_gpu_rows);
        d_rows->data[0] = 0;
        ny = 0;
        for (d_x = 0; d_x <= thism - 2; d_x++) {
          ny++;
          d_rows->data[d_x + 1] = ny;
        }

        iv0 = c_convOut->size[0] * c_convOut->size[1];
        c_convOut->size[0] = static_cast<int32_T>(u);
        c_convOut->size[1] = xt->size[1];
        emxEnsureCapacity_real_T(c_convOut, iv0, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(c_convOut, &c_gpu_convOut);
        r = dim3(static_cast<uint32_T>(std::floor((static_cast<real_T>(OH) + (
          static_cast<real_T>(nc) - 1.0)) / static_cast<real_T>(nc))),
                 static_cast<uint32_T>(std::floor((static_cast<real_T>(
          static_cast<uint32_T>(xt->size[1]) + static_cast<uint32_T>(vlen)) -
                    1.0) / static_cast<real_T>(vlen))), 1U);
        r1 = dim3(static_cast<uint32_T>(nc), static_cast<uint32_T>(vlen), 1U);
        thism = c_convOut->size[0];
        nb = c_expanded->size[0];
        iv0 = d_b->size[0];
        validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>(((
          static_cast<int32_T>(u) - 1) + 1L) * (zfSize_idx_0 + 1L)), &r, &r1,
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&d_gpu_rows, d_rows);
          ec_filtfilt_kernel90<<<grid, block>>>(c_gpu_expanded, d_gpu_rows,
            e_gpu_b, static_cast<int32_T>(u), zfSize_idx_0, iv0, thism, nb,
            c_gpu_convOut);
          c_convOut_dirtyOnGpu = true;
        }

        if ((zi->size[0] != 0) && (zi->size[1] != 0)) {
          if (c_y->size[0] == 1) {
            ns = c_convOut->size[1] - 1;
            iv0 = zi->size[1] - 1;
            thism = c_convOut->size[0];
            xCol_dim0 = c_y->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0
              + 1L) * (ns + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel94<<<grid, block>>>(c_gpu_y, iv0, ns, thism,
                xCol_dim0, c_gpu_convOut);
            }
          } else if (c_y->size[1] == 1) {
            ns = c_convOut->size[1] - 1;
            iv0 = zi->size[0] - 1;
            thism = c_convOut->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0
              + 1L) * (ns + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel93<<<grid, block>>>(c_gpu_y, iv0, ns, thism,
                c_gpu_convOut);
            }
          } else {
            if (c_y->size[0] < 1) {
              ns = -1;
            } else {
              ns = zi->size[0] - 1;
            }

            if ((ns + 1 == zi->size[0]) && (c_convOut->size[1] == zi->size[1]))
            {
              iv0 = m_convOut->size[0] * m_convOut->size[1];
              m_convOut->size[0] = ns + 1;
              m_convOut->size[1] = c_convOut->size[1];
              emxEnsureCapacity_real_T(m_convOut, iv0, &ab_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(m_convOut, &e_gpu_convOut);
              nb = c_convOut->size[1] - 1;
              thism = m_convOut->size[0];
              offsetH = c_convOut->size[0];
              iv0 = zi->size[0];
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                ((ns + 1L) * (nb + 1L)), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ec_filtfilt_kernel91<<<grid, block>>>(gpu_zi, c_gpu_convOut, ns,
                  nb, thism, offsetH, iv0, e_gpu_convOut);
              }

              nb = m_convOut->size[1] - 1;
              iv0 = m_convOut->size[0] - 1;
              thism = c_convOut->size[0];
              offsetH = m_convOut->size[0];
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                ((iv0 + 1L) * (nb + 1L)), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ec_filtfilt_kernel92<<<grid, block>>>(e_gpu_convOut, iv0, nb,
                  thism, offsetH, c_gpu_convOut);
              }
            } else {
              if (c_convOut_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(c_convOut, &c_gpu_convOut);
              }

              if (zi_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(zi, &gpu_zi);
              }

              binary_expand_op(c_convOut, ns, zi);
              c_convOut_dirtyOnCpu = true;
            }
          }
        }

        ns = c_convOut->size[1] - 1;
        i1 = xt->size[0];
        d_x = c_a->size[0];
        thism = c_convOut->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (c_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_convOut, c_convOut);
          }

          ec_filtfilt_kernel95<<<grid, block>>>(c_gpu_a, ns, i1, d_x, thism,
            c_gpu_convOut);
          c_convOut_dirtyOnCpu = false;
        }

        if (xt->size[0] + 1 > c_convOut->size[0]) {
          ns = 0;
          ny = -1;
        } else {
          ns = xt->size[0];
          ny = c_convOut->size[0] - 1;
        }

        iv0 = b_zfIIR->size[0] * b_zfIIR->size[1];
        b_zfIIR->size[0] = (ny - ns) + 1;
        b_zfIIR->size[1] = c_convOut->size[1];
        emxEnsureCapacity_real_T(b_zfIIR, iv0, &ab_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_zfIIR, &b_gpu_zfIIR);
        nb = c_convOut->size[1] - 1;
        csz_idx_0 = b_zfIIR->size[0];
        thism = c_convOut->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((ny -
          ns) + 1L) * (nb + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (c_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_convOut, c_convOut);
          }

          c_convOut_dirtyOnCpu = false;
          ec_filtfilt_kernel96<<<grid, block>>>(c_gpu_convOut, ns, ny, nb,
            csz_idx_0, thism, b_gpu_zfIIR);
          zfIIR_dirtyOnGpu = true;
        }

        ns = c_convOut->size[1] - 1;
        iv0 = c_a->size[0] - 3;
        d_x = c_a->size[0];
        csz_idx_0 = b_zfIIR->size[0];
        i1 = xt->size[0];
        thism = c_convOut->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0 +
          1L) * (ns + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (c_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_convOut, c_convOut);
          }

          ec_filtfilt_kernel97<<<grid, block>>>(c_gpu_convOut, c_gpu_a, iv0, ns,
            d_x, csz_idx_0, i1, thism, b_gpu_zfIIR);
          zfIIR_dirtyOnGpu = true;
        }

        iv0 = b_zfIIR->size[0] * b_zfIIR->size[1];
        cudaMemcpy(zfSize, *gpu_zfSize, 8UL, cudaMemcpyDeviceToHost);
        b_zfIIR->size[0] = static_cast<int32_T>(zfSize[0]);
        b_zfIIR->size[1] = static_cast<int32_T>(zfSize[1]);
        emxEnsureCapacity_real_T(b_zfIIR, iv0, &ab_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_zfIIR, &b_gpu_zfIIR);
      }

      iv0 = e_b->size[0];
      e_b->size[0] = b2->size[0];
      emxEnsureCapacity_real_T(e_b, iv0, &db_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(e_b, &f_gpu_b);
      iv0 = b2->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_filtfilt_kernel98<<<grid, block>>>(gpu_b2, iv0, f_gpu_b);
        d_b_dirtyOnGpu = true;
      }

      iv0 = d_a->size[0];
      d_a->size[0] = a2->size[0];
      emxEnsureCapacity_real_T(d_a, iv0, &db_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(d_a, &d_gpu_a);
      iv0 = a2->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_filtfilt_kernel99<<<grid, block>>>(gpu_a2, iv0, d_gpu_a);
      }

      if ((!std::isinf(a2->data[0])) && (!std::isnan(a2->data[0])) &&
          (!(a2->data[0] == 0.0)) && (a2->data[0] != 1.0)) {
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_nb +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel100<<<grid, block>>>(gpu_a1, b_nb, f_gpu_b);
          d_b_dirtyOnGpu = true;
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(na + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel101<<<grid, block>>>(gpu_a1, na, d_gpu_a);
        }

        ec_filtfilt_kernel102<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(d_gpu_a);
      }

      if (d_a->size[0] > e_b->size[0]) {
        idx = d_a->size[0] - e_b->size[0];
        iv0 = e_b->size[0];
        i1 = e_b->size[0];
        e_b->size[0] += idx;
        emxEnsureCapacity_real_T(e_b, i1, &ab_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(e_b, &f_gpu_b);
        if (idx - 1 >= 0) {
          if (d_b_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(e_b, &f_gpu_b);
          }

          std::memset(&e_b->data[iv0], 0, static_cast<uint32_T>(idx) * sizeof
                      (real_T));
          d_b_dirtyOnCpu = true;
        }
      }

      for (iv0 = 0; iv0 < 2; iv0++) {
        zfSize[iv0] = static_cast<uint32_T>(xCol->size[iv0]);
        zfSize_dirtyOnCpu = true;
      }

      iv0 = e_b->size[0];
      if (d_b_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&f_gpu_b, e_b);
      }

      if (zfSize_dirtyOnCpu) {
        cudaMemcpy(*gpu_zfSize, zfSize, 8UL, cudaMemcpyHostToDevice);
      }

      ec_filtfilt_kernel103<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(iv0,
        *gpu_zfSize);
      if (xCol->size[1] == 0) {
        for (iv0 = 0; iv0 < 2; iv0++) {
          dv1[iv0] = static_cast<uint32_T>(xCol->size[iv0]);
        }

        yc2->size[0] = static_cast<int32_T>(dv1[0]);
        yc2->size[1] = 0;
        iv0 = c_zfIIR->size[0] * c_zfIIR->size[1];
        cudaMemcpy(zfSize, *gpu_zfSize, 8UL, cudaMemcpyDeviceToHost);
        c_zfIIR->size[0] = static_cast<int32_T>(zfSize[0]);
        c_zfIIR->size[1] = static_cast<int32_T>(zfSize[1]);
        emxEnsureCapacity_real_T(c_zfIIR, iv0, &ab_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(c_zfIIR, &d_gpu_zfIIR);
      } else {
        dv1[0] = static_cast<uint32_T>(e_b->size[0]);
        OH = (static_cast<uint32_T>(xCol->size[0]) + static_cast<uint32_T>
              (e_b->size[0])) - 1U;
        nc = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
        vlen = static_cast<int32_T>(std::fmin(32.0, (static_cast<real_T>
          (xCol->size[1]) + 1.0) - 1.0));
        zfSize_idx_0 = xCol->size[1] - 1;
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }

        thism = e_b->size[0];
        offsetH = static_cast<int32_T>(std::floor(static_cast<real_T>(e_b->size
          [0]) / 2.0)) + static_cast<int32_T>(std::floor((static_cast<real_T>
          (e_b->size[0]) - 1.0) / 2.0));
        if ((static_cast<int32_T>(u) > 0) && (e_b->size[0] > MAX_int32_T -
             static_cast<int32_T>(u))) {
          ny = MAX_int32_T;
        } else {
          ny = static_cast<int32_T>(u) + e_b->size[0];
        }

        iv0 = d_expanded->size[0] * d_expanded->size[1];
        d_expanded->size[0] = ny - 1;
        emxEnsureCapacity_real_T(d_expanded, iv0, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(d_expanded, &d_gpu_expanded);
        if (xCol->size[1] > 2147483646) {
          ny = MAX_int32_T;
        } else {
          ny = xCol->size[1] + 1;
        }

        iv0 = d_expanded->size[0] * d_expanded->size[1];
        d_expanded->size[1] = ny - 1;
        emxEnsureCapacity_real_T(d_expanded, iv0, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(d_expanded, &d_gpu_expanded);
        d_x = ((static_cast<int32_T>(u) + static_cast<int32_T>(dv1[0])) - 1) *
          xCol->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_x + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel104<<<grid, block>>>(d_x, d_gpu_expanded);
        }

        iv0 = xCol->size[0];
        i1 = i_y->size[0] * i_y->size[1];
        i_y->size[0] = 1;
        i_y->size[1] = xCol->size[0];
        emxEnsureCapacity_int32_T(i_y, i1, &hb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(i_y, &i_gpu_y);
        i_y->data[0] = 1;
        ny = 1;
        for (d_x = 0; d_x <= iv0 - 2; d_x++) {
          ny++;
          i_y->data[d_x + 1] = ny;
        }

        iv0 = iv5->size[0];
        iv5->size[0] = i_y->size[1];
        emxEnsureCapacity_int32_T(iv5, iv0, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(iv5, &gpu_iv5);
        d_x = i_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_x + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&i_gpu_y, i_y);
          ec_filtfilt_kernel105<<<grid, block>>>(offsetH, i_gpu_y, d_x, gpu_iv5);
        }

        iv0 = xCol->size[1];
        i1 = k_y->size[0] * k_y->size[1];
        k_y->size[0] = 1;
        k_y->size[1] = xCol->size[1];
        emxEnsureCapacity_int32_T(k_y, i1, &hb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(k_y, &l_gpu_y);
        k_y->data[0] = 1;
        ny = 1;
        for (d_x = 0; d_x <= iv0 - 2; d_x++) {
          ny++;
          k_y->data[d_x + 1] = ny;
        }

        iv0 = iv6->size[0];
        iv6->size[0] = k_y->size[1];
        emxEnsureCapacity_int32_T(iv6, iv0, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(iv6, &gpu_iv6);
        d_x = k_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_x + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&l_gpu_y, k_y);
          ec_filtfilt_kernel106<<<grid, block>>>(l_gpu_y, d_x, gpu_iv6);
        }

        d_x = xCol->size[1] - 1;
        iv0 = xCol->size[0] - 1;
        nb = d_expanded->size[0];
        xCol_dim0 = xCol->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0 +
          1L) * (d_x + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel107<<<grid, block>>>(gpu_xCol, gpu_iv6, gpu_iv5, iv0,
            d_x, nb, xCol_dim0, d_gpu_expanded);
        }

        iv0 = e_rows->size[0] * e_rows->size[1];
        e_rows->size[0] = 1;
        e_rows->size[1] = static_cast<int32_T>(dv1[0]);
        emxEnsureCapacity_int32_T(e_rows, iv0, &hb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(e_rows, &g_gpu_rows);
        e_rows->data[0] = 0;
        ny = 0;
        for (d_x = 0; d_x <= thism - 2; d_x++) {
          ny++;
          e_rows->data[d_x + 1] = ny;
        }

        iv0 = d_convOut->size[0] * d_convOut->size[1];
        d_convOut->size[0] = static_cast<int32_T>(u);
        d_convOut->size[1] = xCol->size[1];
        emxEnsureCapacity_real_T(d_convOut, iv0, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(d_convOut, &g_gpu_convOut);
        r = dim3(static_cast<uint32_T>(std::floor((static_cast<real_T>(OH) + (
          static_cast<real_T>(nc) - 1.0)) / static_cast<real_T>(nc))),
                 static_cast<uint32_T>(std::floor((static_cast<real_T>(
          static_cast<uint32_T>(xCol->size[1]) + static_cast<uint32_T>(vlen)) -
                    1.0) / static_cast<real_T>(vlen))), 1U);
        r1 = dim3(static_cast<uint32_T>(nc), static_cast<uint32_T>(vlen), 1U);
        thism = d_convOut->size[0];
        nb = d_expanded->size[0];
        iv0 = e_b->size[0];
        validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>(((
          static_cast<int32_T>(u) - 1) + 1L) * (zfSize_idx_0 + 1L)), &r, &r1,
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&g_gpu_rows, e_rows);
          ec_filtfilt_kernel108<<<grid, block>>>(d_gpu_expanded, g_gpu_rows,
            f_gpu_b, static_cast<int32_T>(u), zfSize_idx_0, iv0, thism, nb,
            g_gpu_convOut);
          f_convOut_dirtyOnGpu = true;
        }

        if ((b_zfIIR->size[0] != 0) && (b_zfIIR->size[1] != 0)) {
          if (b_zfIIR->size[0] == 1) {
            ns = d_convOut->size[1] - 1;
            iv0 = b_zfIIR->size[1];
            thism = d_convOut->size[0];
            csz_idx_0 = b_zfIIR->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel112<<<grid, block>>>(b_gpu_zfIIR, ns, iv0, thism,
                csz_idx_0, g_gpu_convOut);
            }
          } else if (b_zfIIR->size[1] == 1) {
            ns = d_convOut->size[1] - 1;
            csz_idx_0 = b_zfIIR->size[0];
            thism = d_convOut->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel111<<<grid, block>>>(b_gpu_zfIIR, ns, csz_idx_0,
                thism, g_gpu_convOut);
            }
          } else if (d_convOut->size[1] == b_zfIIR->size[1]) {
            iv0 = b_zfIIR->size[0] - 1;
            i1 = n_convOut->size[0] * n_convOut->size[1];
            n_convOut->size[0] = b_zfIIR->size[0];
            n_convOut->size[1] = d_convOut->size[1];
            emxEnsureCapacity_real_T(n_convOut, i1, &ab_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(n_convOut, &h_gpu_convOut);
            nb = d_convOut->size[1] - 1;
            thism = n_convOut->size[0];
            offsetH = d_convOut->size[0];
            csz_idx_0 = b_zfIIR->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0
              + 1L) * (nb + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel109<<<grid, block>>>(b_gpu_zfIIR, g_gpu_convOut,
                iv0, nb, thism, offsetH, csz_idx_0, h_gpu_convOut);
            }

            nb = n_convOut->size[1] - 1;
            iv0 = n_convOut->size[0] - 1;
            thism = d_convOut->size[0];
            offsetH = n_convOut->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0
              + 1L) * (nb + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel110<<<grid, block>>>(h_gpu_convOut, iv0, nb,
                thism, offsetH, g_gpu_convOut);
            }
          } else {
            if (f_convOut_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(d_convOut, &g_gpu_convOut);
            }

            if (zfIIR_dirtyOnGpu) {
              gpuEmxMemcpyGpuToCpu_real_T(b_zfIIR, &b_gpu_zfIIR);
            }

            binary_expand_op(d_convOut, b_zfIIR);
            f_convOut_dirtyOnCpu = true;
          }
        }

        ns = d_convOut->size[1] - 1;
        xCol_dim0 = xCol->size[0];
        d_x = d_a->size[0];
        thism = d_convOut->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (f_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&g_gpu_convOut, d_convOut);
          }

          ec_filtfilt_kernel113<<<grid, block>>>(d_gpu_a, ns, xCol_dim0, d_x,
            thism, g_gpu_convOut);
          f_convOut_dirtyOnCpu = false;
        }

        if (static_cast<uint32_T>(xCol->size[0]) + 1U > static_cast<uint32_T>
            (d_convOut->size[0])) {
          ns = 0;
          ny = -1;
        } else {
          ns = xCol->size[0];
          ny = d_convOut->size[0] - 1;
        }

        iv0 = c_zfIIR->size[0] * c_zfIIR->size[1];
        c_zfIIR->size[0] = (ny - ns) + 1;
        c_zfIIR->size[1] = d_convOut->size[1];
        emxEnsureCapacity_real_T(c_zfIIR, iv0, &ab_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(c_zfIIR, &d_gpu_zfIIR);
        nb = d_convOut->size[1] - 1;
        csz_idx_0 = c_zfIIR->size[0];
        thism = d_convOut->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((ny -
          ns) + 1L) * (nb + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (f_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&g_gpu_convOut, d_convOut);
          }

          f_convOut_dirtyOnCpu = false;
          ec_filtfilt_kernel114<<<grid, block>>>(g_gpu_convOut, ns, ny, nb,
            csz_idx_0, thism, d_gpu_zfIIR);
          b_zfIIR_dirtyOnGpu = true;
        }

        ns = d_convOut->size[1] - 1;
        iv0 = d_a->size[0] - 3;
        d_x = d_a->size[0];
        csz_idx_0 = c_zfIIR->size[0];
        xCol_dim0 = xCol->size[0];
        thism = d_convOut->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0 +
          1L) * (ns + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (f_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&g_gpu_convOut, d_convOut);
          }

          f_convOut_dirtyOnCpu = false;
          ec_filtfilt_kernel115<<<grid, block>>>(g_gpu_convOut, d_gpu_a, iv0, ns,
            d_x, csz_idx_0, xCol_dim0, thism, d_gpu_zfIIR);
          b_zfIIR_dirtyOnGpu = true;
        }

        iv0 = c_zfIIR->size[0] * c_zfIIR->size[1];
        cudaMemcpy(zfSize, *gpu_zfSize, 8UL, cudaMemcpyDeviceToHost);
        c_zfIIR->size[0] = static_cast<int32_T>(zfSize[0]);
        c_zfIIR->size[1] = static_cast<int32_T>(zfSize[1]);
        emxEnsureCapacity_real_T(c_zfIIR, iv0, &ab_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(c_zfIIR, &d_gpu_zfIIR);
        iv0 = o_convOut->size[0] * o_convOut->size[1];
        o_convOut->size[0] = xCol->size[0];
        o_convOut->size[1] = d_convOut->size[1];
        emxEnsureCapacity_real_T(o_convOut, iv0, &ab_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(o_convOut, &i_gpu_convOut);
        nb = d_convOut->size[1] - 1;
        d_x = xCol->size[0] - 1;
        thism = o_convOut->size[0];
        offsetH = d_convOut->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((d_x +
          1L) * (nb + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (f_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&g_gpu_convOut, d_convOut);
          }

          ec_filtfilt_kernel116<<<grid, block>>>(g_gpu_convOut, d_x, nb, thism,
            offsetH, i_gpu_convOut);
        }

        ny = xCol->size[0];
        ns = xCol->size[1];
        iv0 = yc2->size[0] * yc2->size[1];
        yc2->size[0] = xCol->size[0];
        yc2->size[1] = xCol->size[1];
        emxEnsureCapacity_real_T(yc2, iv0, &ab_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(yc2, &gpu_yc2);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ny * ns
          - 1) + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel117<<<grid, block>>>(i_gpu_convOut, ny, ns, gpu_yc2);
        }
      }

      ny = xCol->size[0] - 1;
      iv0 = h_y->size[0] * h_y->size[1];
      h_y->size[0] = 1;
      h_y->size[1] = xCol->size[1];
      emxEnsureCapacity_real_T(h_y, iv0, &s_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(h_y, &g_gpu_y);
      d_x = xCol->size[1] - 1;
      xCol_dim0 = xCol->size[0];
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_x + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_filtfilt_kernel118<<<grid, block>>>(gpu_xCol, ny, d_x, xCol_dim0,
          g_gpu_y);
      }

      ns = xCol->size[1];
      ny = h_y->size[1];
      if (ns <= ny) {
        ny = ns;
      }

      if (xCol->size[1] == 1) {
        vlen = h_y->size[1];
      } else if (h_y->size[1] == 1) {
        vlen = xCol->size[1];
      } else if (h_y->size[1] == xCol->size[1]) {
        vlen = h_y->size[1];
      } else {
        vlen = ny;
      }

      iv0 = xt->size[0] * xt->size[1];
      xt->size[0] = static_cast<int32_T>(-((0.0 - nfact) - -1.0)) + 1;
      ns = xCol->size[1];
      ny = h_y->size[1];
      if (ns <= ny) {
        ny = ns;
      }

      if (xCol->size[1] == 1) {
        xt->size[1] = h_y->size[1];
      } else if (h_y->size[1] == 1) {
        xt->size[1] = xCol->size[1];
      } else if (h_y->size[1] == xCol->size[1]) {
        xt->size[1] = h_y->size[1];
      } else {
        xt->size[1] = ny;
      }

      emxEnsureCapacity_real_T(xt, iv0, &x_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(xt, &gpu_xt);
      if (vlen != 0) {
        ns = (h_y->size[1] != 1);
        ny = (xCol->size[1] != 1);
        d_x = xt->size[0] - 1;
        i1 = xt->size[0];
        xCol_dim0 = xCol->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((d_x +
          1L) * ((vlen - 1) + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel119<<<grid, block>>>(gpu_xCol, g_gpu_y, nfact, ny,
            ns, d_x, vlen, i1, xCol_dim0, gpu_xt);
        }
      }

      iv0 = h_b->size[0];
      h_b->size[0] = b2->size[0];
      emxEnsureCapacity_real_T(h_b, iv0, &db_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(h_b, &i_gpu_b);
      iv0 = b2->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_filtfilt_kernel120<<<grid, block>>>(gpu_b2, iv0, i_gpu_b);
        g_b_dirtyOnGpu = true;
      }

      iv0 = g_a->size[0];
      g_a->size[0] = a2->size[0];
      emxEnsureCapacity_real_T(g_a, iv0, &db_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(g_a, &g_gpu_a);
      iv0 = a2->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_filtfilt_kernel121<<<grid, block>>>(gpu_a2, iv0, g_gpu_a);
      }

      if ((!std::isinf(a2->data[0])) && (!std::isnan(a2->data[0])) &&
          (!(a2->data[0] == 0.0)) && (a2->data[0] != 1.0)) {
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(c_nb +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel122<<<grid, block>>>(e_gpu_a1, c_nb, i_gpu_b);
          g_b_dirtyOnGpu = true;
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(b_na +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel123<<<grid, block>>>(e_gpu_a1, b_na, g_gpu_a);
        }

        ec_filtfilt_kernel124<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(g_gpu_a);
      }

      if (g_a->size[0] > h_b->size[0]) {
        idx = g_a->size[0] - h_b->size[0];
        iv0 = h_b->size[0];
        i1 = h_b->size[0];
        h_b->size[0] += idx;
        emxEnsureCapacity_real_T(h_b, i1, &ab_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(h_b, &i_gpu_b);
        if (idx - 1 >= 0) {
          if (g_b_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(h_b, &i_gpu_b);
          }

          std::memset(&h_b->data[iv0], 0, static_cast<uint32_T>(idx) * sizeof
                      (real_T));
          g_b_dirtyOnCpu = true;
        }
      }

      if (xt->size[1] == 0) {
        j_y->size[0] = xt->size[0];
        j_y->size[1] = 0;
      } else {
        dv1[0] = static_cast<uint32_T>(h_b->size[0]);
        OH = (static_cast<uint32_T>(xt->size[0]) + static_cast<uint32_T>
              (h_b->size[0])) - 1U;
        nc = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
        vlen = static_cast<int32_T>(std::fmin(32.0, (static_cast<real_T>
          (xt->size[1]) + 1.0) - 1.0));
        zfSize_idx_0 = xt->size[1] - 1;
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }

        thism = h_b->size[0];
        offsetH = static_cast<int32_T>(std::floor(static_cast<real_T>(h_b->size
          [0]) / 2.0)) + static_cast<int32_T>(std::floor((static_cast<real_T>
          (h_b->size[0]) - 1.0) / 2.0));
        if ((static_cast<int32_T>(u) > 0) && (h_b->size[0] > MAX_int32_T -
             static_cast<int32_T>(u))) {
          ny = MAX_int32_T;
        } else {
          ny = static_cast<int32_T>(u) + h_b->size[0];
        }

        iv0 = g_expanded->size[0] * g_expanded->size[1];
        g_expanded->size[0] = ny - 1;
        emxEnsureCapacity_real_T(g_expanded, iv0, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(g_expanded, &g_gpu_expanded);
        if (xt->size[1] > 2147483646) {
          ny = MAX_int32_T;
        } else {
          ny = xt->size[1] + 1;
        }

        iv0 = g_expanded->size[0] * g_expanded->size[1];
        g_expanded->size[1] = ny - 1;
        emxEnsureCapacity_real_T(g_expanded, iv0, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(g_expanded, &g_gpu_expanded);
        d_x = ((static_cast<int32_T>(u) + static_cast<int32_T>(dv1[0])) - 1) *
          xt->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_x + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel125<<<grid, block>>>(d_x, g_gpu_expanded);
        }

        ns = xt->size[0];
        iv0 = o_y->size[0] * o_y->size[1];
        o_y->size[0] = 1;
        o_y->size[1] = xt->size[0];
        emxEnsureCapacity_int32_T(o_y, iv0, &hb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(o_y, &o_gpu_y);
        o_y->data[0] = 1;
        ny = 1;
        for (d_x = 0; d_x <= ns - 2; d_x++) {
          ny++;
          o_y->data[d_x + 1] = ny;
        }

        iv0 = iv10->size[0];
        iv10->size[0] = o_y->size[1];
        emxEnsureCapacity_int32_T(iv10, iv0, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(iv10, &gpu_iv10);
        d_x = o_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_x + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&o_gpu_y, o_y);
          ec_filtfilt_kernel126<<<grid, block>>>(offsetH, o_gpu_y, d_x, gpu_iv10);
        }

        ns = xt->size[1];
        iv0 = p_y->size[0] * p_y->size[1];
        p_y->size[0] = 1;
        p_y->size[1] = xt->size[1];
        emxEnsureCapacity_int32_T(p_y, iv0, &hb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(p_y, &p_gpu_y);
        p_y->data[0] = 1;
        ny = 1;
        for (d_x = 0; d_x <= ns - 2; d_x++) {
          ny++;
          p_y->data[d_x + 1] = ny;
        }

        iv0 = iv11->size[0];
        iv11->size[0] = p_y->size[1];
        emxEnsureCapacity_int32_T(iv11, iv0, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(iv11, &gpu_iv11);
        d_x = p_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_x + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&p_gpu_y, p_y);
          ec_filtfilt_kernel127<<<grid, block>>>(p_gpu_y, d_x, gpu_iv11);
        }

        d_x = xt->size[1] - 1;
        iv0 = xt->size[0] - 1;
        nb = g_expanded->size[0];
        i1 = xt->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0 +
          1L) * (d_x + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel128<<<grid, block>>>(gpu_xt, gpu_iv11, gpu_iv10, iv0,
            d_x, nb, i1, g_gpu_expanded);
        }

        iv0 = h_rows->size[0] * h_rows->size[1];
        h_rows->size[0] = 1;
        h_rows->size[1] = static_cast<int32_T>(dv1[0]);
        emxEnsureCapacity_int32_T(h_rows, iv0, &hb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(h_rows, &h_gpu_rows);
        h_rows->data[0] = 0;
        ny = 0;
        for (d_x = 0; d_x <= thism - 2; d_x++) {
          ny++;
          h_rows->data[d_x + 1] = ny;
        }

        iv0 = g_convOut->size[0] * g_convOut->size[1];
        g_convOut->size[0] = static_cast<int32_T>(u);
        g_convOut->size[1] = xt->size[1];
        emxEnsureCapacity_real_T(g_convOut, iv0, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(g_convOut, &j_gpu_convOut);
        r = dim3(static_cast<uint32_T>(std::floor((static_cast<real_T>(OH) + (
          static_cast<real_T>(nc) - 1.0)) / static_cast<real_T>(nc))),
                 static_cast<uint32_T>(std::floor((static_cast<real_T>(
          static_cast<uint32_T>(xt->size[1]) + static_cast<uint32_T>(vlen)) -
                    1.0) / static_cast<real_T>(vlen))), 1U);
        r1 = dim3(static_cast<uint32_T>(nc), static_cast<uint32_T>(vlen), 1U);
        thism = g_convOut->size[0];
        nb = g_expanded->size[0];
        iv0 = h_b->size[0];
        validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>(((
          static_cast<int32_T>(u) - 1) + 1L) * (zfSize_idx_0 + 1L)), &r, &r1,
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&h_gpu_rows, h_rows);
          if (g_b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&i_gpu_b, h_b);
          }

          ec_filtfilt_kernel129<<<grid, block>>>(g_gpu_expanded, h_gpu_rows,
            i_gpu_b, static_cast<int32_T>(u), zfSize_idx_0, iv0, thism, nb,
            j_gpu_convOut);
          g_convOut_dirtyOnGpu = true;
        }

        if ((c_zfIIR->size[0] != 0) && (c_zfIIR->size[1] != 0)) {
          if (c_zfIIR->size[0] == 1) {
            ns = g_convOut->size[1] - 1;
            iv0 = c_zfIIR->size[1];
            thism = g_convOut->size[0];
            csz_idx_0 = c_zfIIR->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel133<<<grid, block>>>(d_gpu_zfIIR, ns, iv0, thism,
                csz_idx_0, j_gpu_convOut);
            }
          } else if (c_zfIIR->size[1] == 1) {
            ns = g_convOut->size[1] - 1;
            csz_idx_0 = c_zfIIR->size[0];
            thism = g_convOut->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel132<<<grid, block>>>(d_gpu_zfIIR, ns, csz_idx_0,
                thism, j_gpu_convOut);
            }
          } else if (g_convOut->size[1] == c_zfIIR->size[1]) {
            iv0 = c_zfIIR->size[0] - 1;
            i1 = q_convOut->size[0] * q_convOut->size[1];
            q_convOut->size[0] = c_zfIIR->size[0];
            q_convOut->size[1] = g_convOut->size[1];
            emxEnsureCapacity_real_T(q_convOut, i1, &ab_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(q_convOut, &k_gpu_convOut);
            nb = g_convOut->size[1] - 1;
            thism = q_convOut->size[0];
            offsetH = g_convOut->size[0];
            csz_idx_0 = c_zfIIR->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0
              + 1L) * (nb + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel130<<<grid, block>>>(d_gpu_zfIIR, j_gpu_convOut,
                iv0, nb, thism, offsetH, csz_idx_0, k_gpu_convOut);
            }

            nb = q_convOut->size[1] - 1;
            iv0 = q_convOut->size[0] - 1;
            thism = g_convOut->size[0];
            offsetH = q_convOut->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0
              + 1L) * (nb + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel131<<<grid, block>>>(k_gpu_convOut, iv0, nb,
                thism, offsetH, j_gpu_convOut);
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
        i1 = xt->size[0];
        d_x = g_a->size[0];
        thism = g_convOut->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (g_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&j_gpu_convOut, g_convOut);
          }

          ec_filtfilt_kernel134<<<grid, block>>>(g_gpu_a, ns, i1, d_x, thism,
            j_gpu_convOut);
          g_convOut_dirtyOnCpu = false;
        }

        iv0 = p_convOut->size[0] * p_convOut->size[1];
        p_convOut->size[0] = xt->size[0];
        p_convOut->size[1] = g_convOut->size[1];
        emxEnsureCapacity_real_T(p_convOut, iv0, &ab_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(p_convOut, &l_gpu_convOut);
        nb = g_convOut->size[1] - 1;
        d_x = xt->size[0] - 1;
        thism = p_convOut->size[0];
        offsetH = g_convOut->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((d_x +
          1L) * (nb + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (g_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&j_gpu_convOut, g_convOut);
          }

          ec_filtfilt_kernel135<<<grid, block>>>(j_gpu_convOut, d_x, nb, thism,
            offsetH, l_gpu_convOut);
        }

        ns = xt->size[0];
        ny = xt->size[1];
        iv0 = j_y->size[0] * j_y->size[1];
        j_y->size[0] = xt->size[0];
        j_y->size[1] = xt->size[1];
        emxEnsureCapacity_real_T(j_y, iv0, &sb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(j_y, &m_gpu_y);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ns * ny
          - 1) + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel136<<<grid, block>>>(l_gpu_convOut, ns, ny, m_gpu_y);
        }
      }

      vlen = j_y->size[0] - 1;
      iv0 = n_y->size[0] * n_y->size[1];
      n_y->size[0] = zi_size[0];
      n_y->size[1] = j_y->size[1];
      emxEnsureCapacity_real_T(n_y, iv0, &y_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(n_y, &n_gpu_y);
      idx = j_y->size[1] - 1;
      xCol_dim0 = n_y->size[0];
      iv0 = j_y->size[0];
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((zi_size
        [0] - 1) + 1L) * (idx + 1L)), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (zi_data_dirtyOnCpu) {
          cudaMemcpy(*gpu_zi_data, SD->f0.zi_data, 1073741816UL,
                     cudaMemcpyHostToDevice);
        }

        zi_data_dirtyOnCpu = false;
        ec_filtfilt_kernel137<<<grid, block>>>(m_gpu_y, vlen, *gpu_zi_data,
          zi_size[0] - 1, idx, xCol_dim0, iv0, n_gpu_y);
      }

      iv0 = j_b->size[0];
      j_b->size[0] = b2->size[0];
      emxEnsureCapacity_real_T(j_b, iv0, &db_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(j_b, &j_gpu_b);
      iv0 = b2->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_filtfilt_kernel138<<<grid, block>>>(gpu_b2, iv0, j_gpu_b);
        h_b_dirtyOnGpu = true;
      }

      iv0 = i_a->size[0];
      i_a->size[0] = a2->size[0];
      emxEnsureCapacity_real_T(i_a, iv0, &db_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(i_a, &h_gpu_a);
      iv0 = a2->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_filtfilt_kernel139<<<grid, block>>>(gpu_a2, iv0, h_gpu_a);
      }

      vlen = j_y->size[0] - 1;
      iv0 = b_zi->size[0] * b_zi->size[1];
      b_zi->size[0] = zi_size[0];
      b_zi->size[1] = j_y->size[1];
      emxEnsureCapacity_real_T(b_zi, iv0, &pb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(b_zi, &b_gpu_zi);
      idx = j_y->size[1] - 1;
      xCol_dim0 = j_y->size[0];
      iv0 = b_zi->size[0];
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((zi_size
        [0] - 1) + 1L) * (idx + 1L)), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (zi_data_dirtyOnCpu) {
          cudaMemcpy(*gpu_zi_data, SD->f0.zi_data, 1073741816UL,
                     cudaMemcpyHostToDevice);
        }

        ec_filtfilt_kernel140<<<grid, block>>>(m_gpu_y, vlen, *gpu_zi_data,
          zi_size[0] - 1, idx, xCol_dim0, iv0, b_gpu_zi);
        b_zi_dirtyOnGpu = true;
      }

      if ((!std::isinf(a2->data[0])) && (!std::isnan(a2->data[0])) &&
          (!(a2->data[0] == 0.0)) && (a2->data[0] != 1.0)) {
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_nb +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel141<<<grid, block>>>(d_gpu_a1, d_nb, j_gpu_b);
          h_b_dirtyOnGpu = true;
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(c_na +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel142<<<grid, block>>>(d_gpu_a1, c_na, h_gpu_a);
        }

        ec_filtfilt_kernel143<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(h_gpu_a);
      }

      if (i_a->size[0] > j_b->size[0]) {
        idx = i_a->size[0] - j_b->size[0];
        iv0 = j_b->size[0];
        i1 = j_b->size[0];
        j_b->size[0] += idx;
        emxEnsureCapacity_real_T(j_b, i1, &ab_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(j_b, &j_gpu_b);
        if (idx - 1 >= 0) {
          if (h_b_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(j_b, &j_gpu_b);
          }

          std::memset(&j_b->data[iv0], 0, static_cast<uint32_T>(idx) * sizeof
                      (real_T));
          h_b_dirtyOnCpu = true;
        }
      }

      zfSize[1] = static_cast<uint32_T>(j_y->size[1]);
      zfSize[0] = static_cast<uint32_T>(j_b->size[0] - 1);
      if (j_y->size[1] == 0) {
        e_zfIIR->size[0] = j_b->size[0] - 1;
        e_zfIIR->size[1] = 0;
      } else {
        dv1[0] = static_cast<uint32_T>(j_b->size[0]);
        OH = (static_cast<uint32_T>(j_y->size[0]) + static_cast<uint32_T>
              (j_b->size[0])) - 1U;
        nc = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
        vlen = static_cast<int32_T>(std::fmin(32.0, (static_cast<real_T>
          (j_y->size[1]) + 1.0) - 1.0));
        zfSize_idx_0 = j_y->size[1] - 1;
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }

        thism = j_b->size[0];
        offsetH = static_cast<int32_T>(std::floor(static_cast<real_T>(j_b->size
          [0]) / 2.0)) + static_cast<int32_T>(std::floor((static_cast<real_T>
          (j_b->size[0]) - 1.0) / 2.0));
        if ((static_cast<int32_T>(u) > 0) && (j_b->size[0] > MAX_int32_T -
             static_cast<int32_T>(u))) {
          ny = MAX_int32_T;
        } else {
          ny = static_cast<int32_T>(u) + j_b->size[0];
        }

        iv0 = i_expanded->size[0] * i_expanded->size[1];
        i_expanded->size[0] = ny - 1;
        emxEnsureCapacity_real_T(i_expanded, iv0, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(i_expanded, &h_gpu_expanded);
        if (j_y->size[1] > 2147483646) {
          ny = MAX_int32_T;
        } else {
          ny = j_y->size[1] + 1;
        }

        iv0 = i_expanded->size[0] * i_expanded->size[1];
        i_expanded->size[1] = ny - 1;
        emxEnsureCapacity_real_T(i_expanded, iv0, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(i_expanded, &h_gpu_expanded);
        d_x = ((static_cast<int32_T>(u) + static_cast<int32_T>(dv1[0])) - 1) *
          j_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_x + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel144<<<grid, block>>>(d_x, h_gpu_expanded);
        }

        ns = j_y->size[0];
        iv0 = r_y->size[0] * r_y->size[1];
        r_y->size[0] = 1;
        r_y->size[1] = j_y->size[0];
        emxEnsureCapacity_int32_T(r_y, iv0, &hb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(r_y, &q_gpu_y);
        r_y->data[0] = 1;
        ny = 1;
        for (d_x = 0; d_x <= ns - 2; d_x++) {
          ny++;
          r_y->data[d_x + 1] = ny;
        }

        iv0 = iv13->size[0];
        iv13->size[0] = r_y->size[1];
        emxEnsureCapacity_int32_T(iv13, iv0, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(iv13, &gpu_iv13);
        d_x = r_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_x + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&q_gpu_y, r_y);
          ec_filtfilt_kernel145<<<grid, block>>>(offsetH, q_gpu_y, d_x, gpu_iv13);
        }

        ns = j_y->size[1];
        iv0 = s_y->size[0] * s_y->size[1];
        s_y->size[0] = 1;
        s_y->size[1] = j_y->size[1];
        emxEnsureCapacity_int32_T(s_y, iv0, &hb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(s_y, &s_gpu_y);
        s_y->data[0] = 1;
        ny = 1;
        for (d_x = 0; d_x <= ns - 2; d_x++) {
          ny++;
          s_y->data[d_x + 1] = ny;
        }

        iv0 = iv14->size[0];
        iv14->size[0] = s_y->size[1];
        emxEnsureCapacity_int32_T(iv14, iv0, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(iv14, &gpu_iv14);
        d_x = s_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_x + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&s_gpu_y, s_y);
          ec_filtfilt_kernel146<<<grid, block>>>(s_gpu_y, d_x, gpu_iv14);
        }

        d_x = j_y->size[1] - 1;
        iv0 = j_y->size[0] - 1;
        nb = i_expanded->size[0];
        xCol_dim0 = j_y->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0 +
          1L) * (d_x + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel147<<<grid, block>>>(m_gpu_y, gpu_iv14, gpu_iv13,
            iv0, d_x, nb, xCol_dim0, h_gpu_expanded);
        }

        iv0 = j_rows->size[0] * j_rows->size[1];
        j_rows->size[0] = 1;
        j_rows->size[1] = static_cast<int32_T>(dv1[0]);
        emxEnsureCapacity_int32_T(j_rows, iv0, &hb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(j_rows, &j_gpu_rows);
        j_rows->data[0] = 0;
        ny = 0;
        for (d_x = 0; d_x <= thism - 2; d_x++) {
          ny++;
          j_rows->data[d_x + 1] = ny;
        }

        iv0 = i_convOut->size[0] * i_convOut->size[1];
        i_convOut->size[0] = static_cast<int32_T>(u);
        i_convOut->size[1] = j_y->size[1];
        emxEnsureCapacity_real_T(i_convOut, iv0, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(i_convOut, &n_gpu_convOut);
        r = dim3(static_cast<uint32_T>(std::floor((static_cast<real_T>(OH) + (
          static_cast<real_T>(nc) - 1.0)) / static_cast<real_T>(nc))),
                 static_cast<uint32_T>(std::floor((static_cast<real_T>(
          static_cast<uint32_T>(j_y->size[1]) + static_cast<uint32_T>(vlen)) -
                    1.0) / static_cast<real_T>(vlen))), 1U);
        r1 = dim3(static_cast<uint32_T>(nc), static_cast<uint32_T>(vlen), 1U);
        thism = i_convOut->size[0];
        nb = i_expanded->size[0];
        iv0 = j_b->size[0];
        validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>(((
          static_cast<int32_T>(u) - 1) + 1L) * (zfSize_idx_0 + 1L)), &r, &r1,
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&j_gpu_rows, j_rows);
          if (h_b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&j_gpu_b, j_b);
          }

          ec_filtfilt_kernel148<<<grid, block>>>(h_gpu_expanded, j_gpu_rows,
            j_gpu_b, static_cast<int32_T>(u), zfSize_idx_0, iv0, thism, nb,
            n_gpu_convOut);
          i_convOut_dirtyOnGpu = true;
        }

        if ((b_zi->size[0] != 0) && (b_zi->size[1] != 0)) {
          if (n_y->size[0] == 1) {
            ns = i_convOut->size[1] - 1;
            iv0 = b_zi->size[1] - 1;
            thism = i_convOut->size[0];
            xCol_dim0 = n_y->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0
              + 1L) * (ns + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel152<<<grid, block>>>(n_gpu_y, iv0, ns, thism,
                xCol_dim0, n_gpu_convOut);
            }
          } else if (n_y->size[1] == 1) {
            ns = i_convOut->size[1] - 1;
            iv0 = b_zi->size[0] - 1;
            thism = i_convOut->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0
              + 1L) * (ns + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel151<<<grid, block>>>(n_gpu_y, iv0, ns, thism,
                n_gpu_convOut);
            }
          } else {
            if (n_y->size[0] < 1) {
              ns = -1;
            } else {
              ns = b_zi->size[0] - 1;
            }

            if ((ns + 1 == b_zi->size[0]) && (i_convOut->size[1] == b_zi->size[1]))
            {
              iv0 = r_convOut->size[0] * r_convOut->size[1];
              r_convOut->size[0] = ns + 1;
              r_convOut->size[1] = i_convOut->size[1];
              emxEnsureCapacity_real_T(r_convOut, iv0, &ab_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(r_convOut, &o_gpu_convOut);
              nb = i_convOut->size[1] - 1;
              thism = r_convOut->size[0];
              offsetH = i_convOut->size[0];
              iv0 = b_zi->size[0];
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                ((ns + 1L) * (nb + 1L)), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ec_filtfilt_kernel149<<<grid, block>>>(b_gpu_zi, n_gpu_convOut,
                  ns, nb, thism, offsetH, iv0, o_gpu_convOut);
              }

              nb = r_convOut->size[1] - 1;
              iv0 = r_convOut->size[0] - 1;
              thism = i_convOut->size[0];
              offsetH = r_convOut->size[0];
              validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>
                ((iv0 + 1L) * (nb + 1L)), &grid, &block, 1024U, 65535U);
              if (validLaunchParams) {
                ec_filtfilt_kernel150<<<grid, block>>>(o_gpu_convOut, iv0, nb,
                  thism, offsetH, n_gpu_convOut);
              }
            } else {
              if (i_convOut_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(i_convOut, &n_gpu_convOut);
              }

              if (b_zi_dirtyOnGpu) {
                gpuEmxMemcpyGpuToCpu_real_T(b_zi, &b_gpu_zi);
              }

              binary_expand_op(i_convOut, ns, b_zi);
              i_convOut_dirtyOnCpu = true;
            }
          }
        }

        ns = i_convOut->size[1] - 1;
        xCol_dim0 = j_y->size[0];
        d_x = i_a->size[0];
        thism = i_convOut->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (i_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&n_gpu_convOut, i_convOut);
          }

          ec_filtfilt_kernel153<<<grid, block>>>(h_gpu_a, ns, xCol_dim0, d_x,
            thism, n_gpu_convOut);
          i_convOut_dirtyOnCpu = false;
        }

        if (j_y->size[0] + 1 > i_convOut->size[0]) {
          ns = 0;
          ny = -1;
        } else {
          ns = j_y->size[0];
          ny = i_convOut->size[0] - 1;
        }

        iv0 = e_zfIIR->size[0] * e_zfIIR->size[1];
        e_zfIIR->size[0] = (ny - ns) + 1;
        e_zfIIR->size[1] = i_convOut->size[1];
        emxEnsureCapacity_real_T(e_zfIIR, iv0, &ab_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(e_zfIIR, &e_gpu_zfIIR);
        nb = i_convOut->size[1] - 1;
        csz_idx_0 = e_zfIIR->size[0];
        thism = i_convOut->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(((ny -
          ns) + 1L) * (nb + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (i_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&n_gpu_convOut, i_convOut);
          }

          i_convOut_dirtyOnCpu = false;
          ec_filtfilt_kernel154<<<grid, block>>>(n_gpu_convOut, ns, ny, nb,
            csz_idx_0, thism, e_gpu_zfIIR);
          c_zfIIR_dirtyOnGpu = true;
        }

        ns = i_convOut->size[1] - 1;
        iv0 = i_a->size[0] - 3;
        d_x = i_a->size[0];
        csz_idx_0 = e_zfIIR->size[0];
        xCol_dim0 = j_y->size[0];
        thism = i_convOut->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0 +
          1L) * (ns + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (i_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&n_gpu_convOut, i_convOut);
          }

          ec_filtfilt_kernel155<<<grid, block>>>(n_gpu_convOut, h_gpu_a, iv0, ns,
            d_x, csz_idx_0, xCol_dim0, thism, e_gpu_zfIIR);
          c_zfIIR_dirtyOnGpu = true;
        }

        iv0 = e_zfIIR->size[0] * e_zfIIR->size[1];
        e_zfIIR->size[0] = static_cast<int32_T>(zfSize[0]);
        e_zfIIR->size[1] = static_cast<int32_T>(zfSize[1]);
        emxEnsureCapacity_real_T(e_zfIIR, iv0, &ab_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(e_zfIIR, &e_gpu_zfIIR);
      }

      iv0 = k_b->size[0];
      k_b->size[0] = b2->size[0];
      emxEnsureCapacity_real_T(k_b, iv0, &db_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(k_b, &l_gpu_b);
      iv0 = b2->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_filtfilt_kernel156<<<grid, block>>>(gpu_b2, iv0, l_gpu_b);
        j_b_dirtyOnGpu = true;
      }

      iv0 = j_a->size[0];
      j_a->size[0] = a2->size[0];
      emxEnsureCapacity_real_T(j_a, iv0, &db_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(j_a, &j_gpu_a);
      iv0 = a2->size[0] - 1;
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(iv0 + 1L),
        &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_filtfilt_kernel157<<<grid, block>>>(gpu_a2, iv0, j_gpu_a);
      }

      if ((!std::isinf(a2->data[0])) && (!std::isnan(a2->data[0])) &&
          (!(a2->data[0] == 0.0)) && (a2->data[0] != 1.0)) {
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(e_nb +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel158<<<grid, block>>>(c_gpu_a1, e_nb, l_gpu_b);
          j_b_dirtyOnGpu = true;
        }

        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_na +
          1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel159<<<grid, block>>>(c_gpu_a1, d_na, j_gpu_a);
        }

        ec_filtfilt_kernel160<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(j_gpu_a);
      }

      if (j_a->size[0] > k_b->size[0]) {
        idx = j_a->size[0] - k_b->size[0];
        iv0 = k_b->size[0];
        i1 = k_b->size[0];
        k_b->size[0] += idx;
        emxEnsureCapacity_real_T(k_b, i1, &ab_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(k_b, &l_gpu_b);
        if (idx - 1 >= 0) {
          if (j_b_dirtyOnGpu) {
            gpuEmxMemcpyGpuToCpu_real_T(k_b, &l_gpu_b);
          }

          std::memset(&k_b->data[iv0], 0, static_cast<uint32_T>(idx) * sizeof
                      (real_T));
          j_b_dirtyOnCpu = true;
        }
      }

      if (yc2->size[1] == 0) {
        yc5->size[0] = yc2->size[0];
        yc5->size[1] = 0;
      } else {
        dv1[0] = static_cast<uint32_T>(k_b->size[0]);
        OH = (static_cast<uint32_T>(yc2->size[0]) + static_cast<uint32_T>
              (k_b->size[0])) - 1U;
        nc = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
        vlen = static_cast<int32_T>(std::fmin(32.0, (static_cast<real_T>
          (yc2->size[1]) + 1.0) - 1.0));
        zfSize_idx_0 = yc2->size[1] - 1;
        u = OH;
        if (OH > 2147483647U) {
          u = 2147483647U;
        }

        thism = k_b->size[0];
        offsetH = static_cast<int32_T>(std::floor(static_cast<real_T>(k_b->size
          [0]) / 2.0)) + static_cast<int32_T>(std::floor((static_cast<real_T>
          (k_b->size[0]) - 1.0) / 2.0));
        if ((static_cast<int32_T>(u) > 0) && (k_b->size[0] > MAX_int32_T -
             static_cast<int32_T>(u))) {
          ny = MAX_int32_T;
        } else {
          ny = static_cast<int32_T>(u) + k_b->size[0];
        }

        iv0 = j_expanded->size[0] * j_expanded->size[1];
        j_expanded->size[0] = ny - 1;
        emxEnsureCapacity_real_T(j_expanded, iv0, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(j_expanded, &j_gpu_expanded);
        if (yc2->size[1] > 2147483646) {
          ny = MAX_int32_T;
        } else {
          ny = yc2->size[1] + 1;
        }

        iv0 = j_expanded->size[0] * j_expanded->size[1];
        j_expanded->size[1] = ny - 1;
        emxEnsureCapacity_real_T(j_expanded, iv0, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(j_expanded, &j_gpu_expanded);
        d_x = ((static_cast<int32_T>(u) + static_cast<int32_T>(dv1[0])) - 1) *
          yc2->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_x + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel161<<<grid, block>>>(d_x, j_gpu_expanded);
        }

        ns = yc2->size[0];
        iv0 = t_y->size[0] * t_y->size[1];
        t_y->size[0] = 1;
        t_y->size[1] = yc2->size[0];
        emxEnsureCapacity_int32_T(t_y, iv0, &hb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(t_y, &t_gpu_y);
        t_y->data[0] = 1;
        ny = 1;
        for (d_x = 0; d_x <= ns - 2; d_x++) {
          ny++;
          t_y->data[d_x + 1] = ny;
        }

        iv0 = iv15->size[0];
        iv15->size[0] = t_y->size[1];
        emxEnsureCapacity_int32_T(iv15, iv0, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(iv15, &gpu_iv15);
        d_x = t_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_x + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&t_gpu_y, t_y);
          ec_filtfilt_kernel162<<<grid, block>>>(offsetH, t_gpu_y, d_x, gpu_iv15);
        }

        ns = yc2->size[1];
        iv0 = u_y->size[0] * u_y->size[1];
        u_y->size[0] = 1;
        u_y->size[1] = yc2->size[1];
        emxEnsureCapacity_int32_T(u_y, iv0, &hb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(u_y, &u_gpu_y);
        u_y->data[0] = 1;
        ny = 1;
        for (d_x = 0; d_x <= ns - 2; d_x++) {
          ny++;
          u_y->data[d_x + 1] = ny;
        }

        iv0 = iv16->size[0];
        iv16->size[0] = u_y->size[1];
        emxEnsureCapacity_int32_T(iv16, iv0, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(iv16, &gpu_iv16);
        d_x = u_y->size[1] - 1;
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(d_x + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&u_gpu_y, u_y);
          ec_filtfilt_kernel163<<<grid, block>>>(u_gpu_y, d_x, gpu_iv16);
        }

        d_x = yc2->size[1] - 1;
        iv0 = yc2->size[0] - 1;
        nb = j_expanded->size[0];
        offsetH = yc2->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0 +
          1L) * (d_x + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel164<<<grid, block>>>(gpu_yc2, gpu_iv16, gpu_iv15,
            iv0, d_x, nb, offsetH, j_gpu_expanded);
        }

        iv0 = k_rows->size[0] * k_rows->size[1];
        k_rows->size[0] = 1;
        k_rows->size[1] = static_cast<int32_T>(dv1[0]);
        emxEnsureCapacity_int32_T(k_rows, iv0, &hb_emlrtRTEI);
        gpuEmxEnsureCapacity_int32_T(k_rows, &k_gpu_rows);
        k_rows->data[0] = 0;
        ny = 0;
        for (d_x = 0; d_x <= thism - 2; d_x++) {
          ny++;
          k_rows->data[d_x + 1] = ny;
        }

        iv0 = j_convOut->size[0] * j_convOut->size[1];
        j_convOut->size[0] = static_cast<int32_T>(u);
        j_convOut->size[1] = yc2->size[1];
        emxEnsureCapacity_real_T(j_convOut, iv0, &fb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(j_convOut, &p_gpu_convOut);
        r = dim3(static_cast<uint32_T>(std::floor((static_cast<real_T>(OH) + (
          static_cast<real_T>(nc) - 1.0)) / static_cast<real_T>(nc))),
                 static_cast<uint32_T>(std::floor((static_cast<real_T>(
          static_cast<uint32_T>(yc2->size[1]) + static_cast<uint32_T>(vlen)) -
                    1.0) / static_cast<real_T>(vlen))), 1U);
        r1 = dim3(static_cast<uint32_T>(nc), static_cast<uint32_T>(vlen), 1U);
        thism = j_convOut->size[0];
        nb = j_expanded->size[0];
        iv0 = k_b->size[0];
        validLaunchParams = mwApplyLaunchParameters(static_cast<real_T>(((
          static_cast<int32_T>(u) - 1) + 1L) * (zfSize_idx_0 + 1L)), &r, &r1,
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          gpuEmxMemcpyCpuToGpu_int32_T(&k_gpu_rows, k_rows);
          if (j_b_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&l_gpu_b, k_b);
          }

          ec_filtfilt_kernel165<<<grid, block>>>(j_gpu_expanded, k_gpu_rows,
            l_gpu_b, static_cast<int32_T>(u), zfSize_idx_0, iv0, thism, nb,
            p_gpu_convOut);
          j_convOut_dirtyOnGpu = true;
        }

        if ((e_zfIIR->size[0] != 0) && (e_zfIIR->size[1] != 0)) {
          if (e_zfIIR->size[0] == 1) {
            ns = j_convOut->size[1] - 1;
            iv0 = e_zfIIR->size[1];
            thism = j_convOut->size[0];
            csz_idx_0 = e_zfIIR->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel169<<<grid, block>>>(e_gpu_zfIIR, ns, iv0, thism,
                csz_idx_0, p_gpu_convOut);
            }
          } else if (e_zfIIR->size[1] == 1) {
            ns = j_convOut->size[1] - 1;
            csz_idx_0 = e_zfIIR->size[0];
            thism = j_convOut->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns +
              1L), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel168<<<grid, block>>>(e_gpu_zfIIR, ns, csz_idx_0,
                thism, p_gpu_convOut);
            }
          } else if (j_convOut->size[1] == e_zfIIR->size[1]) {
            iv0 = e_zfIIR->size[0] - 1;
            i1 = t_convOut->size[0] * t_convOut->size[1];
            t_convOut->size[0] = e_zfIIR->size[0];
            t_convOut->size[1] = j_convOut->size[1];
            emxEnsureCapacity_real_T(t_convOut, i1, &ab_emlrtRTEI);
            gpuEmxEnsureCapacity_real_T(t_convOut, &q_gpu_convOut);
            nb = j_convOut->size[1] - 1;
            thism = t_convOut->size[0];
            offsetH = j_convOut->size[0];
            csz_idx_0 = e_zfIIR->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0
              + 1L) * (nb + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel166<<<grid, block>>>(e_gpu_zfIIR, p_gpu_convOut,
                iv0, nb, thism, offsetH, csz_idx_0, q_gpu_convOut);
            }

            nb = t_convOut->size[1] - 1;
            iv0 = t_convOut->size[0] - 1;
            thism = j_convOut->size[0];
            offsetH = t_convOut->size[0];
            validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0
              + 1L) * (nb + 1L)), &grid, &block, 1024U, 65535U);
            if (validLaunchParams) {
              ec_filtfilt_kernel167<<<grid, block>>>(q_gpu_convOut, iv0, nb,
                thism, offsetH, p_gpu_convOut);
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
        offsetH = yc2->size[0];
        d_x = j_a->size[0];
        thism = j_convOut->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>(ns + 1L),
          &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (j_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&p_gpu_convOut, j_convOut);
          }

          ec_filtfilt_kernel170<<<grid, block>>>(j_gpu_a, ns, offsetH, d_x,
            thism, p_gpu_convOut);
          j_convOut_dirtyOnCpu = false;
        }

        iv0 = s_convOut->size[0] * s_convOut->size[1];
        s_convOut->size[0] = yc2->size[0];
        s_convOut->size[1] = j_convOut->size[1];
        emxEnsureCapacity_real_T(s_convOut, iv0, &ab_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(s_convOut, &r_gpu_convOut);
        nb = j_convOut->size[1] - 1;
        d_x = yc2->size[0] - 1;
        thism = s_convOut->size[0];
        offsetH = j_convOut->size[0];
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((d_x +
          1L) * (nb + 1L)), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          if (j_convOut_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&p_gpu_convOut, j_convOut);
          }

          ec_filtfilt_kernel171<<<grid, block>>>(p_gpu_convOut, d_x, nb, thism,
            offsetH, r_gpu_convOut);
        }

        ns = yc2->size[0];
        ny = yc2->size[1];
        iv0 = yc5->size[0] * yc5->size[1];
        yc5->size[0] = yc2->size[0];
        yc5->size[1] = yc2->size[1];
        emxEnsureCapacity_real_T(yc5, iv0, &tb_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(yc5, &gpu_yc5);
        validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((ns * ny
          - 1) + 1L), &grid, &block, 1024U, 65535U);
        if (validLaunchParams) {
          ec_filtfilt_kernel172<<<grid, block>>>(r_gpu_convOut, ns, ny, gpu_yc5);
        }
      }

      iv0 = xCol->size[0] * xCol->size[1];
      xCol->size[0] = yc5->size[0];
      xCol->size[1] = yc5->size[1];
      emxEnsureCapacity_real_T(xCol, iv0, &qb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(xCol, &gpu_xCol);
      iv0 = yc5->size[1] - 1;
      d_x = yc5->size[0] - 1;
      xCol_dim0 = xCol->size[0];
      offsetH = yc5->size[0];
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((d_x + 1L)
        * (iv0 + 1L)), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        ec_filtfilt_kernel173<<<grid, block>>>(gpu_yc5, d_x, iv0, xCol_dim0,
          offsetH, gpu_xCol);
      }

      iv0 = xCol->size[0] * xCol->size[1];
      xCol->size[0] = static_cast<int32_T>(sz[0]);
      xCol->size[1] = static_cast<int32_T>(sz[1]);
      emxEnsureCapacity_real_T(xCol, iv0, &t_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(xCol, &gpu_xCol);
    }

    if (x->size[0] == 1) {
      iv0 = x->size[0] * x->size[1];
      x->size[0] = xCol->size[1];
      x->size[1] = xCol->size[0];
      emxEnsureCapacity_real_T(x, iv0, &p_emlrtRTEI);
      if (!x_dirtyOnCpu) {
        gpuEmxEnsureCapacity_real_T(x, &gpu_x);
      }

      d_x = xCol->size[0] - 1;
      iv0 = xCol->size[1] - 1;
      offsetH = x->size[0];
      xCol_dim0 = xCol->size[0];
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0 + 1L)
        * (d_x + 1L)), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (x_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, x);
        }

        ec_filtfilt_kernel274<<<grid, block>>>(gpu_xCol, iv0, d_x, offsetH,
          xCol_dim0, gpu_x);
        x_dirtyOnGpu = true;
      }
    } else {
      iv0 = x->size[0] * x->size[1];
      x->size[0] = xCol->size[0];
      x->size[1] = xCol->size[1];
      emxEnsureCapacity_real_T(x, iv0, &p_emlrtRTEI);
      if (!x_dirtyOnCpu) {
        gpuEmxEnsureCapacity_real_T(x, &gpu_x);
      }

      d_x = xCol->size[1] - 1;
      iv0 = xCol->size[0] - 1;
      offsetH = x->size[0];
      xCol_dim0 = xCol->size[0];
      validLaunchParams = mwGetLaunchParameters1D(static_cast<real_T>((iv0 + 1L)
        * (d_x + 1L)), &grid, &block, 1024U, 65535U);
      if (validLaunchParams) {
        if (x_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, x);
        }

        ec_filtfilt_kernel273<<<grid, block>>>(gpu_xCol, iv0, d_x, offsetH,
          xCol_dim0, gpu_x);
        x_dirtyOnGpu = true;
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
  emxFree_real_T(&n_b);
  emxFree_real_T(&l_convOut);
  emxFree_int32_T(&m_rows);
  emxFree_int32_T(&iv18);
  emxFree_int32_T(&w_y);
  emxFree_real_T(&l_expanded);
  emxFree_real_T(&l_a);
  emxFree_real_T(&m_b);
  emxFree_real_T(&f_zfIIR);
  emxFree_real_T(&k_convOut);
  emxFree_int32_T(&l_rows);
  emxFree_int32_T(&iv17);
  emxFree_real_T(&j_convOut);
  emxFree_int32_T(&v_y);
  emxFree_int32_T(&k_rows);
  emxFree_real_T(&k_expanded);
  emxFree_int32_T(&iv16);
  emxFree_real_T(&e_zfIIR);
  emxFree_int32_T(&u_y);
  emxFree_int32_T(&iv15);
  emxFree_real_T(&i_convOut);
  emxFree_real_T(&k_a);
  emxFree_int32_T(&t_y);
  emxFree_real_T(&l_b);
  emxFree_real_T(&j_expanded);
  emxFree_int32_T(&j_rows);
  emxFree_int32_T(&iv14);
  emxFree_real_T(&yc5);
  emxFree_int32_T(&s_y);
  emxFree_real_T(&h_convOut);
  emxFree_int32_T(&iv13);
  emxFree_real_T(&g_convOut);
  emxFree_int32_T(&i_rows);
  emxFree_real_T(&d_zfIIR);
  emxFree_int32_T(&r_y);
  emxFree_real_T(&j_a);
  emxFree_real_T(&i_expanded);
  emxFree_int32_T(&iv12);
  emxFree_real_T(&k_b);
  emxFree_int32_T(&h_rows);
  emxFree_int32_T(&iv11);
  emxFree_int32_T(&q_y);
  emxFree_real_T(&h_expanded);
  emxFree_real_T(&f_convOut);
  emxFree_real_T(&c_zfIIR);
  emxFree_int32_T(&p_y);
  emxFree_real_T(&e_convOut);
  emxFree_int32_T(&iv10);
  emxFree_int32_T(&g_rows);
  emxFree_int32_T(&f_rows);
  emxFree_int32_T(&iv9);
  emxFree_int32_T(&o_y);
  emxFree_real_T(&b_zi);
  emxFree_real_T(&g_expanded);
  emxFree_int32_T(&iv8);
  emxFree_real_T(&i_a);
  emxFree_real_T(&j_b);
  emxFree_int32_T(&d_y_rowidx);
  emxFree_real_T(&n_y);
  emxFree_real_T(&d_convOut);
  emxFree_int32_T(&d_y_colidx);
  emxFree_real_T(&h_a);
  emxFree_int32_T(&m_y);
  emxFree_real_T(&d_y_d);
  emxFree_real_T(&i_b);
  emxFree_real_T(&f_expanded);
  emxFree_int32_T(&l_y);
  emxFree_real_T(&e_expanded);
  emxFree_int32_T(&e_rows);
  emxFree_real_T(&b_zfIIR);
  emxFree_int32_T(&iv6);
  emxFree_int32_T(&c_y_rowidx);
  emxFree_int32_T(&b_y_rowidx);
  emxFree_int32_T(&c_y_colidx);
  emxFree_int32_T(&b_y_colidx);
  emxFree_real_T(&c_y_d);
  emxFree_real_T(&b_y_d);
  emxFree_real_T(&g_a);
  emxFree_int32_T(&k_y);
  emxFree_real_T(&h_b);
  emxFree_int32_T(&iv5);
  emxFree_real_T(&c_convOut);
  emxFree_real_T(&j_y);
  emxFree_real_T(&f_a);
  emxFree_real_T(&e_a);
  emxFree_real_T(&g_b);
  emxFree_real_T(&f_b);
  emxFree_int32_T(&d_rows);
  emxFree_int32_T(&i_y);
  emxFree_real_T(&d_expanded);
  emxFree_int32_T(&iv4);
  emxFree_real_T(&zfIIR);
  emxFree_real_T(&dv3);
  emxFree_real_T(&h_y);
  emxFree_real_T(&yc2);
  emxFree_int32_T(&g_y);
  emxFree_int32_T(&iv3);
  emxFree_real_T(&b_convOut);
  emxFree_int32_T(&b_t);
  emxFree_real_T(&convOut);
  emxFree_int32_T(&f_y);
  emxFree_int32_T(&t);
  emxFree_real_T(&c_expanded);
  emxFree_int32_T(&c_rows);
  emxFree_int32_T(&b_rows);
  emxFree_int32_T(&iv2);
  emxFree_real_T(&d_a);
  emxFree_int32_T(&sortedIndices);
  emxFree_int32_T(&iv1);
  emxFree_real_T(&e_b);
  emxFree_int32_T(&cidxInt);
  emxFree_int32_T(&e_y);
  emxFree_real_T(&b_expanded);
  emxFree_int32_T(&d_y);
  emxFree_real_T(&expanded);
  emxFree_int32_T(&ridxInt);
  emxFree_int32_T(&y_rowidx);
  emxFree_int32_T(&y_colidx);
  emxFree_real_T(&y_d);
  emxFree_real_T(&zi);
  emxFree_real_T(&c_a);
  emxFree_real_T(&d_b);
  emxFree_real_T(&c_y);
  emxFree_int8_T(&vals);
  emxFree_real_T(&b_a);
  emxFree_real_T(&xt);
  emxFree_real_T(&c_b);
  emxFree_real_T(&ytemp);
  emxFree_real_T(&a);
  emxFree_real_T(&b_b);
  emxFree_int32_T(&cols);
  emxFree_real_T(&b_y);
  emxFree_boolean_T(&c_x);
  emxFree_real_T(&maxCoefNum);
  emxFree_int32_T(&rows);
  emxFree_boolean_T(&b_x);
  emxFree_real_T(&y);
  emxFree_real_T(&b1);
  emxFree_real_T(&a2);
  emxFree_real_T(&b2);
  emxFree_real_T(&b);
  emxFree_real_T(&xCol);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  if (x_dirtyOnGpu) {
    gpuEmxMemcpyGpuToCpu_real_T(x, &gpu_x);
  }

  gpuEmxFree_real_T(&gpu_x);
  gpuEmxFree_real_T(&gpu_xCol);
  gpuEmxFree_real_T(&gpu_coef);
  gpuEmxFree_real_T(&gpu_b);
  gpuEmxFree_real_T(&gpu_b2);
  gpuEmxFree_real_T(&gpu_b1);
  gpuEmxFree_real_T(&b_gpu_b);
  gpuEmxFree_real_T(&gpu_a2);
  gpuEmxFree_real_T(&gpu_y);
  mwCudaFree(gpu_a1);
  mwCudaFree(b_gpu_a1);
  mwCudaFree(&(*gpu_y_data)[0]);
  mwCudaFree(c_gpu_a1);
  mwCudaFree(d_gpu_a1);
  mwCudaFree(e_gpu_a1);
  mwCudaFree(&(*gpu_counts_data)[0]);
  gpuEmxFree_real_T(&gpu_maxCoefNum);
  mwCudaFree(gpu_d1);
  gpuEmxFree_int32_T(&gpu_rows);
  gpuEmxFree_boolean_T(&b_gpu_x);
  gpuEmxFree_real_T(&gpu_ytemp);
  mwCudaFree(&(*gpu_rhs_data)[0]);
  mwCudaFree(gpu_val);
  mwCudaFree(&(*gpu_zi_data)[0]);
  mwCudaFree(&(*gpu_outBuff_data)[0]);
  gpuEmxFree_boolean_T(&c_gpu_x);
  gpuEmxFree_real_T(&b_gpu_y);
  gpuEmxFree_real_T(&c_gpu_b);
  mwCudaFree(&(*b_gpu_y_data)[0]);
  gpuEmxFree_real_T(&d_gpu_b);
  gpuEmxFree_int32_T(&gpu_cols);
  gpuEmxFree_real_T(&gpu_a);
  mwCudaFree(&(*gpu_nZeroLastDen_data)[0]);
  gpuEmxFree_real_T(&b_gpu_a);
  mwCudaFree(&(*gpu_a0)[0]);
  gpuEmxFree_real_T(&gpu_xt);
  mwCudaFree(&(*gpu_rhs)[0]);
  gpuEmxFree_int8_T(&gpu_vals);
  mwCudaFree(&(*gpu_I)[0]);
  gpuEmxFree_real_T(&c_gpu_y);
  mwCudaFree(&(*gpu_A)[0]);
  gpuEmxFree_real_T(&gpu_expanded);
  gpuEmxFree_real_T(&b_gpu_expanded);
  gpuEmxFree_real_T(&e_gpu_b);
  mwCudaFree(&(*gpu_Y)[0]);
  gpuEmxFree_real_T(&c_gpu_a);
  gpuEmxFree_int32_T(&d_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv1);
  gpuEmxFree_int32_T(&e_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv2);
  gpuEmxFree_real_T(&gpu_zi);
  gpuEmxFree_int32_T(&gpu_ridxInt);
  mwCudaFree(&(*gpu_zfSize)[0]);
  gpuEmxFree_int32_T(&gpu_cidxInt);
  mwCudaFree(&(*gpu_dv1)[0]);
  gpuEmxFree_int32_T(&gpu_sortedIndices);
  gpuEmxFree_int32_T(&b_gpu_rows);
  gpuEmxFree_real_T(&gpu_convOut);
  gpuEmxFree_int32_T(&c_gpu_rows);
  gpuEmxFree_real_T(&b_gpu_convOut);
  gpuEmxFree_real_T(&f_gpu_b);
  gpuEmxFree_int32_T(&gpu_t);
  gpuEmxFree_real_T(&d_gpu_a);
  gpuEmxFree_real_T(&gpu_dv3);
  gpuEmxFree_real_T(&gpu_zfIIR);
  gpuEmxFree_int32_T(&b_gpu_t);
  gpuEmxFree_real_T(&c_gpu_expanded);
  gpuEmxFree_real_T(&g_gpu_b);
  gpuEmxFree_real_T(&h_gpu_b);
  gpuEmxFree_real_T(&e_gpu_a);
  gpuEmxFree_int32_T(&f_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv3);
  gpuEmxFree_real_T(&f_gpu_a);
  gpuEmxFree_real_T(&g_gpu_y);
  gpuEmxFree_int32_T(&gpu_y_rowidx);
  gpuEmxFree_real_T(&gpu_y_d);
  gpuEmxFree_real_T(&d_gpu_expanded);
  gpuEmxFree_int32_T(&h_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv4);
  gpuEmxFree_real_T(&e_gpu_expanded);
  gpuEmxFree_real_T(&i_gpu_b);
  gpuEmxFree_real_T(&f_gpu_expanded);
  gpuEmxFree_int32_T(&i_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv5);
  gpuEmxFree_real_T(&g_gpu_a);
  gpuEmxFree_int32_T(&b_gpu_y_rowidx);
  gpuEmxFree_real_T(&b_gpu_y_d);
  gpuEmxFree_int32_T(&c_gpu_y_rowidx);
  gpuEmxFree_real_T(&c_gpu_y_d);
  gpuEmxFree_int32_T(&gpu_y_colidx);
  gpuEmxFree_int32_T(&b_gpu_y_colidx);
  gpuEmxFree_int32_T(&j_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv9);
  gpuEmxFree_int32_T(&k_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv8);
  gpuEmxFree_int32_T(&d_gpu_y_rowidx);
  gpuEmxFree_real_T(&d_gpu_y_d);
  gpuEmxFree_int32_T(&d_gpu_rows);
  gpuEmxFree_real_T(&c_gpu_convOut);
  gpuEmxFree_int32_T(&l_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv6);
  gpuEmxFree_int32_T(&c_gpu_y_colidx);
  gpuEmxFree_real_T(&m_gpu_y);
  gpuEmxFree_real_T(&n_gpu_y);
  gpuEmxFree_int32_T(&e_gpu_rows);
  gpuEmxFree_real_T(&d_gpu_convOut);
  gpuEmxFree_real_T(&e_gpu_convOut);
  gpuEmxFree_real_T(&j_gpu_b);
  gpuEmxFree_int32_T(&f_gpu_rows);
  gpuEmxFree_real_T(&f_gpu_convOut);
  gpuEmxFree_real_T(&g_gpu_expanded);
  gpuEmxFree_real_T(&b_gpu_zfIIR);
  gpuEmxFree_real_T(&h_gpu_a);
  gpuEmxFree_int32_T(&g_gpu_rows);
  gpuEmxFree_real_T(&g_gpu_convOut);
  gpuEmxFree_real_T(&c_gpu_zfIIR);
  gpuEmxFree_real_T(&b_gpu_zi);
  gpuEmxFree_int32_T(&o_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv10);
  gpuEmxFree_real_T(&h_gpu_convOut);
  gpuEmxFree_real_T(&k_gpu_b);
  gpuEmxFree_real_T(&d_gpu_zfIIR);
  gpuEmxFree_real_T(&l_gpu_b);
  gpuEmxFree_int32_T(&p_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv11);
  gpuEmxFree_real_T(&i_gpu_a);
  gpuEmxFree_real_T(&j_gpu_a);
  gpuEmxFree_real_T(&h_gpu_expanded);
  gpuEmxFree_real_T(&i_gpu_convOut);
  gpuEmxFree_real_T(&gpu_yc5);
  gpuEmxFree_real_T(&i_gpu_expanded);
  gpuEmxFree_int32_T(&h_gpu_rows);
  gpuEmxFree_real_T(&j_gpu_convOut);
  gpuEmxFree_real_T(&gpu_yc2);
  gpuEmxFree_int32_T(&q_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv13);
  gpuEmxFree_real_T(&j_gpu_expanded);
  gpuEmxFree_int32_T(&r_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv12);
  gpuEmxFree_real_T(&k_gpu_convOut);
  gpuEmxFree_real_T(&l_gpu_convOut);
  gpuEmxFree_int32_T(&s_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv14);
  gpuEmxFree_int32_T(&t_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv15);
  gpuEmxFree_int32_T(&i_gpu_rows);
  gpuEmxFree_real_T(&m_gpu_convOut);
  gpuEmxFree_int32_T(&u_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv16);
  gpuEmxFree_int32_T(&j_gpu_rows);
  gpuEmxFree_real_T(&n_gpu_convOut);
  gpuEmxFree_real_T(&m_gpu_b);
  gpuEmxFree_real_T(&k_gpu_a);
  gpuEmxFree_real_T(&o_gpu_convOut);
  gpuEmxFree_int32_T(&k_gpu_rows);
  gpuEmxFree_real_T(&p_gpu_convOut);
  gpuEmxFree_real_T(&e_gpu_zfIIR);
  gpuEmxFree_real_T(&k_gpu_expanded);
  gpuEmxFree_real_T(&q_gpu_convOut);
  gpuEmxFree_real_T(&r_gpu_convOut);
  gpuEmxFree_int32_T(&v_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv17);
  gpuEmxFree_int32_T(&l_gpu_rows);
  gpuEmxFree_real_T(&s_gpu_convOut);
  gpuEmxFree_real_T(&f_gpu_zfIIR);
  gpuEmxFree_real_T(&n_gpu_b);
  gpuEmxFree_real_T(&l_gpu_a);
  gpuEmxFree_real_T(&l_gpu_expanded);
  gpuEmxFree_int32_T(&w_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv18);
  gpuEmxFree_int32_T(&m_gpu_rows);
  gpuEmxFree_real_T(&t_gpu_convOut);
  gpuEmxFree_real_T(&u_gpu_convOut);
}

void ec_filtfilt_api(ec_filtfiltStackData *SD, const mxArray * const prhs[2],
                     const mxArray *plhs[1])
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
  ec_filtfilt(SD, x, coef);
  emxFree_real_T(&coef);

  // Marshall function outputs
  x->canFreeData = false;
  emlrt_marshallOut(x, prhs_copy_idx_0);
  emxFree_real_T(&x);
  plhs[0] = prhs_copy_idx_0;
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
