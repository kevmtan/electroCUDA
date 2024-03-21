//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_cwtAvg.cu
//
// Code generation for function 'ec_cwtAvg'
//

// Include files
#include "ec_cwtAvg.h"
#include "_coder_ec_cwtAvg_mex.h"
#include "ec_cwtAvg_types.h"
#include "rt_nonfinite.h"
#include "MWCUBLASUtils.hpp"
#include "MWCUFFTPlanManager.hpp"
#include "MWCUSOLVERUtils.hpp"
#include "MWCudaDimUtility.hpp"
#include "MWCudaMemoryFunctions.hpp"
#include "MWErrorCodeUtils.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include "cufft.h"
#include "lapacke.h"
#include "math_constants.h"
#include "stdio.h"
#include "stdlib.h"
#include "string.h"
#include <algorithm>
#include <cfloat>
#include <cmath>
#include <cstddef>
#include <cstdlib>
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

struct emxArray_creal_T
{
  creal_T *data;
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

struct emxArray_ptrdiff_t
{
  ptrdiff_t *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

struct emxArray_char_T
{
  char_T *data;
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
  "ec_cwtAvg",                         // fFunctionName
  nullptr,                             // fRTCallStack
  false,                               // bDebugMode

  { 3334663369U, 2606893378U, 3553281593U, 3751928550U },// fSigWrd
  nullptr                              // fSigMem
};

static emlrtMCInfo emlrtMCI{ 53,       // lineNo
  14,                                  // colNo
  "nonConstPrint",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/strfun/sprintf.m"// pName
};

static emlrtMCInfo b_emlrtMCI{ 55,     // lineNo
  15,                                  // colNo
  "nonConstPrint",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/strfun/sprintf.m"// pName
};

static emlrtMCInfo c_emlrtMCI{ 14,     // lineNo
  25,                                  // colNo
  "warning",                           // fName
  "/usr/local/MATLAB/R2024a/toolbox/shared/coder/coder/lib/+coder/+internal/warning.m"// pName
};

static emlrtMCInfo d_emlrtMCI{ 14,     // lineNo
  9,                                   // colNo
  "warning",                           // fName
  "/usr/local/MATLAB/R2024a/toolbox/shared/coder/coder/lib/+coder/+internal/warning.m"// pName
};

static emlrtMCInfo e_emlrtMCI{ 53,     // lineNo
  19,                                  // colNo
  "flt2str",                           // fName
  "/usr/local/MATLAB/R2024a/toolbox/shared/coder/coder/lib/+coder/+internal/flt2str.m"// pName
};

static emlrtRTEInfo emlrtRTEI{ 999,    // lineNo
  17,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo b_emlrtRTEI{ 1000, // lineNo
  17,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo c_emlrtRTEI{ 1009, // lineNo
  13,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo d_emlrtRTEI{ 28,   // lineNo
  9,                                   // colNo
  "colon",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/ops/colon.m"// pName
};

static emlrtRTEInfo e_emlrtRTEI{ 129,  // lineNo
  6,                                   // colNo
  "applyBinaryScalarFunction",         // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/applyBinaryScalarFunction.m"// pName
};

static emlrtRTEInfo f_emlrtRTEI{ 24,   // lineNo
  1,                                   // colNo
  "ec_cwtAvg",                         // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwtAvg.m"// pName
};

static emlrtRTEInfo g_emlrtRTEI{ 18,   // lineNo
  5,                                   // colNo
  "wavbpfilters",                      // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/wavbpfilters.m"// pName
};

static emlrtRTEInfo h_emlrtRTEI{ 60,   // lineNo
  20,                                  // colNo
  "bsxfun",                            // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/elmat/bsxfun.m"// pName
};

static emlrtRTEInfo i_emlrtRTEI{ 18,   // lineNo
  5,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo j_emlrtRTEI{ 31,   // lineNo
  9,                                   // colNo
  "wavbpfilters",                      // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/wavbpfilters.m"// pName
};

static emlrtRTEInfo k_emlrtRTEI{ 30,   // lineNo
  21,                                  // colNo
  "applyScalarFunction",               // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/applyScalarFunction.m"// pName
};

static emlrtRTEInfo l_emlrtRTEI{ 33,   // lineNo
  9,                                   // colNo
  "wavbpfilters",                      // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/wavbpfilters.m"// pName
};

static emlrtRTEInfo m_emlrtRTEI{ 25,   // lineNo
  5,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo n_emlrtRTEI{ 31,   // lineNo
  23,                                  // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo o_emlrtRTEI{ 31,   // lineNo
  1,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo p_emlrtRTEI{ 34,   // lineNo
  9,                                   // colNo
  "wavbpfilters",                      // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/wavbpfilters.m"// pName
};

static emlrtRTEInfo q_emlrtRTEI{ 33,   // lineNo
  1,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo r_emlrtRTEI{ 956,  // lineNo
  13,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo s_emlrtRTEI{ 41,   // lineNo
  1,                                   // colNo
  "wavbpfilters",                      // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/wavbpfilters.m"// pName
};

static emlrtRTEInfo t_emlrtRTEI{ 26,   // lineNo
  1,                                   // colNo
  "ec_cwtAvg",                         // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwtAvg.m"// pName
};

static emlrtRTEInfo u_emlrtRTEI{ 1,    // lineNo
  22,                                  // colNo
  "ec_cwtAvg",                         // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwtAvg.m"// pName
};

static emlrtRTEInfo v_emlrtRTEI{ 135,  // lineNo
  1,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo w_emlrtRTEI{ 143,  // lineNo
  1,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo x_emlrtRTEI{ 1,    // lineNo
  1,                                   // colNo
  "cuFFTNDCallback",                   // fName
  "/usr/local/MATLAB/R2024a/toolbox/gpucoder/gpucoder/+gpucoder/+internal/cuFFTNDCallback.p"// pName
};

static emlrtRTEInfo y_emlrtRTEI{ 138,  // lineNo
  19,                                  // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo ab_emlrtRTEI{ 138, // lineNo
  6,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo bb_emlrtRTEI{ 161, // lineNo
  1,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo cb_emlrtRTEI{ 180, // lineNo
  5,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo db_emlrtRTEI{ 22,  // lineNo
  32,                                  // colNo
  "scNormalize",                       // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/scNormalize.m"// pName
};

static emlrtRTEInfo eb_emlrtRTEI{ 12,  // lineNo
  5,                                   // colNo
  "trapz",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/trapz.m"// pName
};

static emlrtRTEInfo fb_emlrtRTEI{ 211, // lineNo
  24,                                  // colNo
  "trapz",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/trapz.m"// pName
};

static emlrtRTEInfo gb_emlrtRTEI{ 96,  // lineNo
  5,                                   // colNo
  "trapz",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/trapz.m"// pName
};

static emlrtRTEInfo hb_emlrtRTEI{ 294, // lineNo
  5,                                   // colNo
  "scaleSpectrum",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/scaleSpectrum.m"// pName
};

static emlrtRTEInfo ib_emlrtRTEI{ 298, // lineNo
  18,                                  // colNo
  "scaleSpectrum",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/scaleSpectrum.m"// pName
};

static emlrtRTEInfo jb_emlrtRTEI{ 297, // lineNo
  5,                                   // colNo
  "scaleSpectrum",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/scaleSpectrum.m"// pName
};

static emlrtRTEInfo kb_emlrtRTEI{ 35,  // lineNo
  5,                                   // colNo
  "ec_cwtAvg",                         // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwtAvg.m"// pName
};

static emlrtRTEInfo lb_emlrtRTEI{ 41,  // lineNo
  9,                                   // colNo
  "ec_cwtAvg",                         // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwtAvg.m"// pName
};

static emlrtRTEInfo mb_emlrtRTEI{ 37,  // lineNo
  20,                                  // colNo
  "kaiser",                            // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/eml/kaiser.m"// pName
};

static emlrtRTEInfo nb_emlrtRTEI{ 816, // lineNo
  63,                                  // colNo
  "ResampleParser",                    // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/+resample/ResampleParser.m"// pName
};

static emlrtRTEInfo ob_emlrtRTEI{ 245, // lineNo
  9,                                   // colNo
  "firls",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m"// pName
};

static emlrtRTEInfo pb_emlrtRTEI{ 243, // lineNo
  9,                                   // colNo
  "firls",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m"// pName
};

static emlrtRTEInfo qb_emlrtRTEI{ 816, // lineNo
  17,                                  // colNo
  "ResampleParser",                    // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/+resample/ResampleParser.m"// pName
};

static emlrtRTEInfo rb_emlrtRTEI{ 247, // lineNo
  5,                                   // colNo
  "firls",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m"// pName
};

static emlrtRTEInfo sb_emlrtRTEI{ 154, // lineNo
  1,                                   // colNo
  "resample",                          // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/resample.m"// pName
};

static emlrtRTEInfo tb_emlrtRTEI{ 258, // lineNo
  13,                                  // colNo
  "firls",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m"// pName
};

static emlrtRTEInfo ub_emlrtRTEI{ 274, // lineNo
  33,                                  // colNo
  "firls",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m"// pName
};

static emlrtRTEInfo vb_emlrtRTEI{ 275, // lineNo
  33,                                  // colNo
  "firls",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m"// pName
};

static emlrtRTEInfo wb_emlrtRTEI{ 276, // lineNo
  33,                                  // colNo
  "firls",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m"// pName
};

static emlrtRTEInfo xb_emlrtRTEI{ 777, // lineNo
  13,                                  // colNo
  "ResampleParser",                    // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/+resample/ResampleParser.m"// pName
};

static emlrtRTEInfo yb_emlrtRTEI{ 277, // lineNo
  33,                                  // colNo
  "firls",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m"// pName
};

static emlrtRTEInfo ac_emlrtRTEI{ 286, // lineNo
  5,                                   // colNo
  "firls",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m"// pName
};

static emlrtRTEInfo bc_emlrtRTEI{ 281, // lineNo
  9,                                   // colNo
  "firls",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m"// pName
};

static emlrtRTEInfo cc_emlrtRTEI{ 778, // lineNo
  15,                                  // colNo
  "ResampleParser",                    // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/+resample/ResampleParser.m"// pName
};

static emlrtRTEInfo dc_emlrtRTEI{ 341, // lineNo
  13,                                  // colNo
  "firls",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m"// pName
};

static emlrtRTEInfo ec_emlrtRTEI{ 347, // lineNo
  9,                                   // colNo
  "firls",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m"// pName
};

static emlrtRTEInfo fc_emlrtRTEI{ 345, // lineNo
  9,                                   // colNo
  "firls",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m"// pName
};

static emlrtRTEInfo gc_emlrtRTEI{ 76,  // lineNo
  9,                                   // colNo
  "eml_mtimes_helper",                 // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/ops/eml_mtimes_helper.m"// pName
};

static emlrtRTEInfo hc_emlrtRTEI{ 39,  // lineNo
  9,                                   // colNo
  "ec_cwtAvg",                         // fName
  "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwtAvg.m"// pName
};

static emlrtRTEInfo ic_emlrtRTEI{ 341, // lineNo
  9,                                   // colNo
  "firls",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m"// pName
};

static emlrtRTEInfo jc_emlrtRTEI{ 61,  // lineNo
  9,                                   // colNo
  "xgeqp3",                            // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/xgeqp3.m"// pName
};

static emlrtRTEInfo kc_emlrtRTEI{ 91,  // lineNo
  5,                                   // colNo
  "upsample",                          // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/upsample.m"// pName
};

static emlrtRTEInfo lc_emlrtRTEI{ 27,  // lineNo
  23,                                  // colNo
  "xgetrfs_gpu",                       // fName
  "/usr/local/MATLAB/R2024a/toolbox/gpucoder/gpucoder/+coder/+internal/+lapack/xgetrfs_gpu.m"// pName
};

static emlrtRTEInfo mc_emlrtRTEI{ 1,   // lineNo
  21,                                  // colNo
  "flipud",                            // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/elmat/flipud.m"// pName
};

static emlrtRTEInfo nc_emlrtRTEI{ 92,  // lineNo
  22,                                  // colNo
  "xgeqp3",                            // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/xgeqp3.m"// pName
};

static emlrtRTEInfo oc_emlrtRTEI{ 105, // lineNo
  1,                                   // colNo
  "xgeqp3",                            // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/xgeqp3.m"// pName
};

static emlrtRTEInfo pc_emlrtRTEI{ 68,  // lineNo
  9,                                   // colNo
  "xgetrfs_gpu",                       // fName
  "/usr/local/MATLAB/R2024a/toolbox/gpucoder/gpucoder/+coder/+internal/+lapack/xgetrfs_gpu.m"// pName
};

static emlrtRTEInfo qc_emlrtRTEI{ 353, // lineNo
  9,                                   // colNo
  "firls",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m"// pName
};

static emlrtRTEInfo rc_emlrtRTEI{ 355, // lineNo
  9,                                   // colNo
  "firls",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m"// pName
};

static emlrtRTEInfo sc_emlrtRTEI{ 1,   // lineNo
  1,                                   // colNo
  "upfirdnGPUImpl",                    // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/+codegenable/+gpu/upfirdnGPUImpl.p"// pName
};

static emlrtRTEInfo tc_emlrtRTEI{ 158, // lineNo
  24,                                  // colNo
  "mtimes",                            // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+blas/mtimes.m"// pName
};

static emlrtRTEInfo uc_emlrtRTEI{ 119, // lineNo
  5,                                   // colNo
  "qrsolve",                           // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/qrsolve.m"// pName
};

static emlrtRTEInfo vc_emlrtRTEI{ 1,   // lineNo
  1,                                   // colNo
  "stencil_codegen",                   // fName
  "/usr/local/MATLAB/R2024a/toolbox/gpucoder/gpucoder/+gpucoder/+internal/stencil_codegen.p"// pName
};

static emlrtRTEInfo wc_emlrtRTEI{ 172, // lineNo
  20,                                  // colNo
  "colon",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/ops/colon.m"// pName
};

static emlrtRTEInfo xc_emlrtRTEI{ 91,  // lineNo
  14,                                  // colNo
  "downsample",                        // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/downsample.m"// pName
};

static emlrtRTEInfo yc_emlrtRTEI{ 24,  // lineNo
  13,                                  // colNo
  "uniformResampleKernel",             // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/+resample/uniformResampleKernel.m"// pName
};

static emlrtRTEInfo ad_emlrtRTEI{ 71,  // lineNo
  5,                                   // colNo
  "upfirdn",                           // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/eml/upfirdn.m"// pName
};

static emlrtRTEInfo bd_emlrtRTEI{ 1276,// lineNo
  30,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo cd_emlrtRTEI{ 1276,// lineNo
  25,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo dd_emlrtRTEI{ 16,  // lineNo
  5,                                   // colNo
  "wavbpfilters",                      // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/wavbpfilters.m"// pName
};

static emlrtRTEInfo ed_emlrtRTEI{ 16,  // lineNo
  5,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo fd_emlrtRTEI{ 26,  // lineNo
  9,                                   // colNo
  "wavbpfilters",                      // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/wavbpfilters.m"// pName
};

static emlrtRTEInfo gd_emlrtRTEI{ 21,  // lineNo
  1,                                   // colNo
  "morsebpfilters",                    // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/morsebpfilters.m"// pName
};

static emlrtRTEInfo hd_emlrtRTEI{ 32,  // lineNo
  18,                                  // colNo
  "getCWTScales",                      // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/getCWTScales.m"// pName
};

static emlrtRTEInfo id_emlrtRTEI{ 34,  // lineNo
  42,                                  // colNo
  "wavbpfilters",                      // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/wavbpfilters.m"// pName
};

static emlrtRTEInfo jd_emlrtRTEI{ 32,  // lineNo
  13,                                  // colNo
  "getCWTScales",                      // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/getCWTScales.m"// pName
};

static emlrtRTEInfo kd_emlrtRTEI{ 934, // lineNo
  26,                                  // colNo
  "cwtfilterbank",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/cwtfilterbank.m"// pName
};

static emlrtRTEInfo ld_emlrtRTEI{ 287, // lineNo
  5,                                   // colNo
  "scaleSpectrum",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/scaleSpectrum.m"// pName
};

static emlrtRTEInfo md_emlrtRTEI{ 151, // lineNo
  5,                                   // colNo
  "wt",                                // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m"// pName
};

static emlrtRTEInfo nd_emlrtRTEI{ 12,  // lineNo
  12,                                  // colNo
  "scNormalize",                       // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/scNormalize.m"// pName
};

static emlrtRTEInfo od_emlrtRTEI{ 12,  // lineNo
  1,                                   // colNo
  "scNormalize",                       // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/scNormalize.m"// pName
};

static emlrtRTEInfo pd_emlrtRTEI{ 26,  // lineNo
  43,                                  // colNo
  "scNormalize",                       // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/scNormalize.m"// pName
};

static emlrtRTEInfo qd_emlrtRTEI{ 26,  // lineNo
  37,                                  // colNo
  "scNormalize",                       // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/scNormalize.m"// pName
};

static emlrtRTEInfo rd_emlrtRTEI{ 293, // lineNo
  14,                                  // colNo
  "scaleSpectrum",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/scaleSpectrum.m"// pName
};

static emlrtRTEInfo sd_emlrtRTEI{ 293, // lineNo
  5,                                   // colNo
  "scaleSpectrum",                     // fName
  "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/scaleSpectrum.m"// pName
};

static emlrtRTEInfo td_emlrtRTEI{ 816, // lineNo
  22,                                  // colNo
  "ResampleParser",                    // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/+resample/ResampleParser.m"// pName
};

static emlrtRTEInfo ud_emlrtRTEI{ 253, // lineNo
  20,                                  // colNo
  "firls",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m"// pName
};

static emlrtRTEInfo vd_emlrtRTEI{ 274, // lineNo
  9,                                   // colNo
  "firls",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m"// pName
};

static emlrtRTEInfo wd_emlrtRTEI{ 275, // lineNo
  9,                                   // colNo
  "firls",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m"// pName
};

static emlrtRTEInfo xd_emlrtRTEI{ 276, // lineNo
  9,                                   // colNo
  "firls",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m"// pName
};

static emlrtRTEInfo yd_emlrtRTEI{ 778, // lineNo
  27,                                  // colNo
  "ResampleParser",                    // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/+resample/ResampleParser.m"// pName
};

static emlrtRTEInfo ae_emlrtRTEI{ 277, // lineNo
  9,                                   // colNo
  "firls",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m"// pName
};

static emlrtRTEInfo be_emlrtRTEI{ 778, // lineNo
  13,                                  // colNo
  "ResampleParser",                    // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/+resample/ResampleParser.m"// pName
};

static emlrtRTEInfo ce_emlrtRTEI{ 295, // lineNo
  33,                                  // colNo
  "firls",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m"// pName
};

static emlrtRTEInfo de_emlrtRTEI{ 88,  // lineNo
  5,                                   // colNo
  "upsample",                          // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/upsample.m"// pName
};

static emlrtRTEInfo ee_emlrtRTEI{ 355, // lineNo
  17,                                  // colNo
  "firls",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m"// pName
};

static emlrtRTEInfo fe_emlrtRTEI{ 297, // lineNo
  46,                                  // colNo
  "firls",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m"// pName
};

static emlrtRTEInfo ge_emlrtRTEI{ 27,  // lineNo
  1,                                   // colNo
  "xgetrfs_gpu",                       // fName
  "/usr/local/MATLAB/R2024a/toolbox/gpucoder/gpucoder/+coder/+internal/+lapack/xgetrfs_gpu.m"// pName
};

static emlrtRTEInfo he_emlrtRTEI{ 298, // lineNo
  39,                                  // colNo
  "firls",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m"// pName
};

static emlrtRTEInfo ie_emlrtRTEI{ 1,   // lineNo
  1,                                   // colNo
  "gpu_conv2_kernel",                  // fName
  "/usr/local/MATLAB/R2024a/toolbox/gpucoder/gpucoder/+coder/+internal/+images/gpu_conv2_kernel.p"// pName
};

static emlrtRTEInfo je_emlrtRTEI{ 22,  // lineNo
  23,                                  // colNo
  "uniformScalarVectorCore",           // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/+resample/uniformScalarVectorCore.m"// pName
};

static emlrtRTEInfo ke_emlrtRTEI{ 1,   // lineNo
  1,                                   // colNo
  "_coder_ec_cwtAvg_api",              // fName
  ""                                   // pName
};

static emlrtRTEInfo le_emlrtRTEI{ 297, // lineNo
  13,                                  // colNo
  "firls",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m"// pName
};

static emlrtRTEInfo me_emlrtRTEI{ 297, // lineNo
  9,                                   // colNo
  "firls",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m"// pName
};

static emlrtRTEInfo ne_emlrtRTEI{ 295, // lineNo
  13,                                  // colNo
  "firls",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m"// pName
};

static emlrtRTEInfo oe_emlrtRTEI{ 295, // lineNo
  9,                                   // colNo
  "firls",                             // fName
  "/usr/local/MATLAB/R2024a/toolbox/signal/signal/firls.m"// pName
};

static char_T (*global_gpu_cv)[128];
static real_T (*global_gpu_table100)[100];
static boolean_T gpuConstsCopied_ec_cwtAvg;

// Function Declarations
static int64_T b_computeEndIdx(int64_T start, int64_T end, int64_T stride);
static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real_T *ret);
static real_T (*b_emlrt_marshallIn(const mxArray *b_nullptr, const char_T
  *identifier))[2];
static real_T (*b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[2];
static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_char_T *ret);
static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, char_T ret[23]);
static void b_feval(const mxArray *m, const mxArray *m1, emlrtMCInfo *location);
static void b_raiseCudaError(int32_T errCode, const char_T *file, uint32_T
  b_line, const char_T *errorName, const char_T *errorString);
static const mxArray *b_sprintf(const mxArray *m1, const mxArray *m2,
  emlrtMCInfo *location);
static void binary_expand_op(emxArray_real_T *in1, real_T in2, const
  emxArray_real_T *in3, real_T in4, const emxArray_real_T *in5);
static void binary_expand_op_1(emxArray_real_T *in1, real_T in2, const
  emxArray_real_T *in3, const emxArray_real_T *in4, const emxArray_real_T *in5);
static void binary_expand_op_2(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3);
static void binary_expand_op_4(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3);
static void binary_expand_op_5(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3);
static void binary_expand_op_6(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3);
static void binary_expand_op_7(real_T in1_data[], int32_T in1_size[2], const
  real_T in2_data[], const int32_T in2_size[2], const real_T in3_data[], const
  int32_T in3_size[2], const real_T in4_data[], const int32_T in4_size[2]);
static real_T c_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId);
static void checkCudaError(cudaError_t errCode, const char_T *file, uint32_T
  b_line);
namespace coder
{
  namespace internal
  {
    static void warning();
  }
}

static int64_T computeEndIdx(int64_T start, int64_T end, int64_T stride);
static uint64_T computeNumIters(int32_T ub);
static uint64_T computeNumIters(int32_T ub, int32_T b_ub);
static uint64_T computeNumIters(int64_T ub);
static void cublasCheck(cublasStatus_t errCode, const char_T *file, uint32_T
  b_line);
static void cusolverCheck(cusolverStatus_t errCode, const char_T *file, uint32_T
  b_line);
static real_T (*d_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
  msgId))[2];
static int32_T div_s32(int32_T numerator, int32_T denominator);
static
#ifdef __CUDACC__

__device__
#endif

int32_T div_s32_device(int32_T numerator, int32_T denominator);
static __global__ void ec_cwtAvg_kernel1(creal_T *dc1, creal_T *dc6);
static __global__ void ec_cwtAvg_kernel10(emxArray_real_T fb_Omega);
static __global__ void ec_cwtAvg_kernel100(const emxArray_real_T a, const
  int32_T b_a, emxArray_real_T x);
static __global__ void ec_cwtAvg_kernel101(const emxArray_real_T x, const
  int32_T b, emxArray_real_T h);
static __global__ void ec_cwtAvg_kernel102(const emxArray_real_T b, const
  int32_T b_b, emxArray_real_T a);
static __global__ void ec_cwtAvg_kernel103(const int32_T omega_tmp2,
  emxArray_real_T a);
static __global__ void ec_cwtAvg_kernel104(const int32_T G, emxArray_int32_T
  jpvt);
static __global__ void ec_cwtAvg_kernel105(const int32_T b, const int32_T nx,
  emxArray_real_T G, int32_T G_dim0);
static __global__ void ec_cwtAvg_kernel106(const int32_T b, emxArray_real_T tau);
static __global__ void ec_cwtAvg_kernel107(const int32_T i, const int64_T b,
  emxArray_real_T tau);
static __global__ void ec_cwtAvg_kernel108(const int32_T nx, emxArray_int32_T
  jpvt);
static __global__ void ec_cwtAvg_kernel109(const int32_T G, emxArray_real_T a);
static __global__ void ec_cwtAvg_kernel11(const emxArray_real_T omega_tmp2,
  const int32_T b, emxArray_real_T fb_Omega);
static __global__ void ec_cwtAvg_kernel110(const int32_T omega_tmp2,
  emxArray_real_T b);
static __global__ void ec_cwtAvg_kernel111(const emxArray_real_T b, const
  emxArray_int32_T jpvt, const int32_T ix, emxArray_real_T a);
static __global__ void ec_cwtAvg_kernel112(const emxArray_real_T b, const
  int32_T b_b, emxArray_real_T a);
static __global__ void ec_cwtAvg_kernel113(emxArray_real_T a);
static __global__ void ec_cwtAvg_kernel114(const int32_T b, emxArray_real_T m);
static __global__ void ec_cwtAvg_kernel115(const int32_T abswt2S,
  emxArray_real_T savgpTMP);
static __global__ void ec_cwtAvg_kernel116(const int32_T abswt2S,
  emxArray_real_T savgpTMP);
static __global__ void ec_cwtAvg_kernel117(const emxArray_real_T fb_Scales,
  const int32_T b, emxArray_real_T c);
static __global__ void ec_cwtAvg_kernel118(const int32_T lidx, const
  emxArray_real_T fb_Scales, emxArray_real_T c);
static __global__ void ec_cwtAvg_kernel119(const emxArray_real_T fb_Scales,
  emxArray_real_T c);
static __global__ void ec_cwtAvg_kernel12(const int32_T nrefine, const int32_T i,
  const emxArray_real_T omega_tmp2, const int32_T y_size_idx_1, emxArray_real_T
  fb_Omega, int32_T omega_tmp2_dim1);
static __global__ void ec_cwtAvg_kernel120(const emxArray_real_T fb_Scales,
  const int32_T b, emxArray_real_T c);
static __global__ void ec_cwtAvg_kernel121(const emxArray_real_T fb_Scales,
  const int32_T lidx, emxArray_real_T c);
static __global__ void ec_cwtAvg_kernel122(const emxArray_real_T fb_Scales,
  const int32_T b, emxArray_real_T c);
static __global__ void ec_cwtAvg_kernel123(const real_T r, emxArray_real_T c,
  int32_T z_dim0);
static __global__ void ec_cwtAvg_kernel124(const emxArray_real_T fb_Scales,
  emxArray_real_T c);
static __global__ void ec_cwtAvg_kernel125(const emxArray_real_T fb_Scales,
  const int32_T b, emxArray_real_T c);
static __global__ void ec_cwtAvg_kernel126(const emxArray_real_T fb_Scales,
  emxArray_real_T c, int32_T z_dim0);
static __global__ void ec_cwtAvg_kernel127(const emxArray_uint32_T y,
  emxArray_real_T c);
static __global__ void ec_cwtAvg_kernel128(const emxArray_uint32_T y, const
  int32_T b, emxArray_real_T c);
static __global__ void ec_cwtAvg_kernel129(const emxArray_uint32_T y,
  emxArray_real_T c, int32_T abscfssq_dim1);
static __global__ void ec_cwtAvg_kernel13(emxArray_real_T y);
static __global__ void ec_cwtAvg_kernel130(const int32_T b, emxArray_uint32_T y);
static __global__ void ec_cwtAvg_kernel131(real_T interval[650]);
static __global__ void ec_cwtAvg_kernel132(real_T interval[650]);
static __global__ void ec_cwtAvg_kernel133(const int32_T nrefine, real_T
  interval[650]);
static __global__ void ec_cwtAvg_kernel134(const real_T interval[650], const
  int32_T b, real_T subs[1298]);
static __global__ void ec_cwtAvg_kernel135(const real_T x_data[9735], const
  int32_T b, real_T xt_data[9735], real_T b_x_data[9735]);
static __global__ void ec_cwtAvg_kernel136(const int32_T b, real_T fx_data[9735]);
static __global__ void ec_cwtAvg_kernel137(const real_T x_data[9735], const
  int32_T x_size, real_T a_data[9735]);
static __global__ void ec_cwtAvg_kernel138(const real_T a_data[9735], const
  int32_T b, real_T y_data[9735]);
static __global__ void ec_cwtAvg_kernel139(const real_T y_data[9735], const
  int32_T b, real_T x_data[9735]);
static __global__ void ec_cwtAvg_kernel14(const emxArray_real_T y, const real_T
  fc, const int32_T b, emxArray_real_T b_y);
static __global__ void ec_cwtAvg_kernel140(const real_T x_data[9735], const
  int32_T b, real_T y_data[9735]);
static __global__ void ec_cwtAvg_kernel141(const real_T y_data[9735], const
  int32_T b, real_T b_y_data[9735]);
static __global__ void ec_cwtAvg_kernel142(const real_T xt_data[9735], const
  real_T x_data[9735], const real_T y_data[9735], const int32_T y_size, real_T
  fx_data[9735]);
static __global__ void ec_cwtAvg_kernel143(const real_T cfsposdft_re, const
  emxArray_creal_T cfsposdft, const int32_T b_cfsposdft, emxArray_creal_T cfspos);
static __global__ void ec_cwtAvg_kernel144(const int32_T b, emxArray_creal_T
  xposdft, uint32_T xSize_dim1);
static __global__ void ec_cwtAvg_kernel145(const emxArray_real_T fb_Omega, const
  emxArray_real_T fb_Scales, const int32_T b_fb_Scales, const int32_T b,
  emxArray_real_T somega, int32_T somega_dim0);
static __global__ void ec_cwtAvg_kernel146(const emxArray_real_T somega, const
  int32_T b_somega, emxArray_real_T w);
static __global__ void ec_cwtAvg_kernel147(const emxArray_real_T w, const
  int32_T b_w, emxArray_real_T expnt);
static __global__ void ec_cwtAvg_kernel148(const int32_T b, emxArray_real_T
  expnt);
static __global__ void ec_cwtAvg_kernel149(const emxArray_real_T w, const
  int32_T b, emxArray_real_T y);
static __global__ void ec_cwtAvg_kernel15(const emxArray_real_T y, const real_T
  r, const int32_T b_y, emxArray_real_T fb_Scales);
static __global__ void ec_cwtAvg_kernel150(const emxArray_real_T y, const
  emxArray_real_T expnt, const int32_T b_expnt, emxArray_real_T daughter);
static __global__ void ec_cwtAvg_kernel151(const int32_T nrefine,
  emxArray_real_T daughter);
static __global__ void ec_cwtAvg_kernel152(const emxArray_real_T fb_Scales,
  const int32_T b_fb_Scales, emxArray_real_T f);
static __global__ void ec_cwtAvg_kernel153(const emxArray_real_T fb_Omega, const
  emxArray_real_T fb_Scales, const int32_T b_fb_Scales, const int32_T b,
  emxArray_real_T somega, int32_T somega_dim0);
static __global__ void ec_cwtAvg_kernel154(const int32_T b, emxArray_real_T y);
static __global__ void ec_cwtAvg_kernel155(const char_T cv[128], char_T wav[5],
  char_T wname[5], char_T b_dim0, char_T b_dim1, char_T b_dim2, char_T b_dim3,
  char_T b_dim4);
static __global__ void ec_cwtAvg_kernel156(real_T interval[650]);
static __global__ void ec_cwtAvg_kernel157(real_T interval[650]);
static __global__ void ec_cwtAvg_kernel158(const int32_T nrefine, real_T
  interval[650]);
static __global__ void ec_cwtAvg_kernel159(real_T interval[650]);
static __global__ void ec_cwtAvg_kernel16(const emxArray_real_T somega, const
  int32_T b, emxArray_real_T absomega);
static __global__ void ec_cwtAvg_kernel160(real_T interval[650]);
static __global__ void ec_cwtAvg_kernel161(const int32_T nrefine, real_T
  interval[650]);
static __global__ void ec_cwtAvg_kernel162(emxArray_real_T y);
static __global__ void ec_cwtAvg_kernel163(const emxArray_real_T y, const real_T
  delta, const int32_T b, emxArray_real_T b_y);
static __global__ void ec_cwtAvg_kernel164(const emxArray_real_T y, const real_T
  r, const int32_T b_y, emxArray_real_T fb_Scales);
static __global__ void ec_cwtAvg_kernel165(const int32_T b, emxArray_real_T y);
static __global__ void ec_cwtAvg_kernel166(const real_T interval[650], const
  int32_T b, real_T subs[1298]);
static __global__ void ec_cwtAvg_kernel167(const real_T x_data[9735], const
  int32_T b, real_T xt_data[9735], real_T b_x_data[9735]);
static __global__ void ec_cwtAvg_kernel168(const int32_T b, real_T fx_data[9735]);
static __global__ void ec_cwtAvg_kernel169(const real_T x_data[9735], const
  int32_T b, real_T dv15_data[9735]);
static __global__ void ec_cwtAvg_kernel17(const emxArray_real_T absomega, const
  int32_T b_absomega, emxArray_real_T powscales);
static __global__ void ec_cwtAvg_kernel170(const real_T x_data[9735], const
  int32_T b, real_T y_data[9735]);
static __global__ void ec_cwtAvg_kernel171(const real_T y_data[9735], const
  int32_T b, real_T b_y_data[9735]);
static __global__ void ec_cwtAvg_kernel172(const real_T xt_data[9735], const
  real_T y_data[9735], const real_T dv15_data[9735], const int32_T dv15_size,
  real_T fx_data[9735]);
static __global__ void ec_cwtAvg_kernel173(const real_T interval[650], const
  int32_T b, real_T subs[1298]);
static __global__ void ec_cwtAvg_kernel174(const real_T x_data[9735], const
  int32_T b, real_T xt_data[9735], real_T b_x_data[9735]);
static __global__ void ec_cwtAvg_kernel175(const int32_T b, real_T fx_data[9735]);
static __global__ void ec_cwtAvg_kernel176(const real_T x_data[9735], const
  int32_T b, real_T y_data[9735]);
static __global__ void ec_cwtAvg_kernel177(const real_T x_data[9735], const
  int32_T b, real_T y_data[9735]);
static __global__ void ec_cwtAvg_kernel178(const real_T y_data[9735], const
  real_T b_y_data[9735], const int32_T y_size, real_T a_data[9735]);
static __global__ void ec_cwtAvg_kernel179(const real_T a_data[9735], const
  int32_T b, real_T dv11_data[9735]);
static __global__ void ec_cwtAvg_kernel18(const int32_T b, emxArray_real_T
  absomega);
static __global__ void ec_cwtAvg_kernel180(const real_T x_data[9735], const
  int32_T b, real_T y_data[9735]);
static __global__ void ec_cwtAvg_kernel181(const real_T y_data[9735], const
  int32_T b, real_T b_y_data[9735]);
static __global__ void ec_cwtAvg_kernel182(const real_T xt_data[9735], const
  real_T y_data[9735], const real_T dv11_data[9735], const int32_T dv11_size,
  real_T fx_data[9735]);
static __global__ void ec_cwtAvg_kernel183(const int32_T b, emxArray_int32_T
  omega_tmp1);
static __global__ void ec_cwtAvg_kernel184(const real_T interval[650], const
  int32_T b, real_T subs[1298]);
static __global__ void ec_cwtAvg_kernel185(const real_T x_data[9735], const
  int32_T b, real_T xt_data[9735], real_T b_x_data[9735]);
static __global__ void ec_cwtAvg_kernel186(const int32_T b, real_T fx_data[9735]);
static __global__ void ec_cwtAvg_kernel187(const real_T x_data[9735], const
  int32_T b, real_T dv10_data[9735]);
static __global__ void ec_cwtAvg_kernel188(const real_T x_data[9735], const
  int32_T b, real_T y_data[9735]);
static __global__ void ec_cwtAvg_kernel189(const real_T y_data[9735], const
  int32_T b, real_T b_y_data[9735]);
static __global__ void ec_cwtAvg_kernel19(const emxArray_real_T powscales, const
  emxArray_real_T absomega, const int32_T b_absomega, emxArray_real_T x);
static __global__ void ec_cwtAvg_kernel190(const real_T xt_data[9735], const
  real_T y_data[9735], const real_T dv10_data[9735], const int32_T dv10_size,
  real_T fx_data[9735]);
static __global__ void ec_cwtAvg_kernel191(const real_T interval[650], const
  int32_T b, real_T subs[1298]);
static __global__ void ec_cwtAvg_kernel192(const real_T x_data[9735], const
  int32_T b, real_T xt_data[9735], real_T b_x_data[9735]);
static __global__ void ec_cwtAvg_kernel193(const int32_T b, real_T fx_data[9735]);
static __global__ void ec_cwtAvg_kernel194(const real_T x_data[9735], const
  int32_T b, real_T y_data[9735]);
static __global__ void ec_cwtAvg_kernel195(const real_T x_data[9735], const
  int32_T b, real_T y_data[9735]);
static __global__ void ec_cwtAvg_kernel196(const real_T y_data[9735], const
  real_T b_y_data[9735], const int32_T y_size, real_T a_data[9735]);
static __global__ void ec_cwtAvg_kernel197(const real_T a_data[9735], const
  int32_T b, real_T dv4_data[9735]);
static __global__ void ec_cwtAvg_kernel198(const real_T x_data[9735], const
  int32_T b, real_T y_data[9735]);
static __global__ void ec_cwtAvg_kernel199(const real_T y_data[9735], const
  int32_T b, real_T b_y_data[9735]);
static __global__ void ec_cwtAvg_kernel2(const char_T cv[128], char_T wname[5],
  char_T wav[5], char_T b_dim0, char_T b_dim1, char_T b_dim2, char_T b_dim3,
  char_T b_dim4);
static __global__ void ec_cwtAvg_kernel20(const int32_T b, emxArray_real_T x);
static __global__ void ec_cwtAvg_kernel200(const real_T xt_data[9735], const
  real_T y_data[9735], const real_T dv4_data[9735], const int32_T dv4_size,
  real_T fx_data[9735]);
static __global__ void ec_cwtAvg_kernel21(const emxArray_real_T somega, const
  emxArray_real_T x, const int32_T b_x, emxArray_real_T daughter);
static __global__ void ec_cwtAvg_kernel22(const emxArray_real_T fb_Scales, const
  int32_T b_fb_Scales, emxArray_real_T f);
static __global__ void ec_cwtAvg_kernel23(const real_T fs, const int32_T i,
  emxArray_real_T f);
static __global__ void ec_cwtAvg_kernel24(const emxArray_real_T f, const int32_T
  b_f, emxArray_real_T freqs);
static __global__ void ec_cwtAvg_kernel25(const int32_T nx, const
  emxArray_real_T x, const int32_T b_x, emxArray_real_T xv, int32_T x_dim0);
static __global__ void ec_cwtAvg_kernel26(const int32_T nx, const
  emxArray_real_T x, const int32_T b, emxArray_real_T b_x, int32_T x_dim0);
static __global__ void ec_cwtAvg_kernel27(const int32_T fb_SignalPad, const
  int32_T b, emxArray_real_T x);
static __global__ void ec_cwtAvg_kernel28(const emxArray_real_T x, const int32_T
  b, emxArray_real_T xv);
static __global__ void ec_cwtAvg_kernel29(const emxArray_real_T xv, const
  int32_T b_xv, emxArray_creal_T xposdft);
static __global__ void ec_cwtAvg_kernel3(real_T interval[650]);
static __global__ void ec_cwtAvg_kernel30(const emxArray_creal_T xposdft, const
  emxArray_real_T daughter, const int32_T ix, const int32_T cfsposdft, const
  int32_T nrefine, emxArray_creal_T b_cfsposdft, int32_T daughter_dim0, int32_T
  cfsposdft_dim0);
static __global__ void ec_cwtAvg_kernel31(const int32_T xSize, emxArray_creal_T
  cfspos);
static __global__ void ec_cwtAvg_kernel32(const emxArray_creal_T cfspos, const
  int32_T b, emxArray_real_T y);
static __global__ void ec_cwtAvg_kernel33(const emxArray_real_T y, const int32_T
  b, emxArray_real_T abscfssq);
static __global__ void ec_cwtAvg_kernel34(const emxArray_real_T abscfssq, const
  int32_T b_abscfssq, emxArray_real_T a);
static __global__ void ec_cwtAvg_kernel35(const emxArray_real_T fb_Scales, const
  emxArray_real_T a, const int32_T lidx, const int32_T abscfssq, const int32_T
  nrefine, emxArray_real_T b_abscfssq, int32_T a_dim0, int32_T fb_Scales_dim1,
  int32_T abscfssq_dim0);
static __global__ void ec_cwtAvg_kernel36(const int32_T abscfssq,
  emxArray_real_T z);
static __global__ void ec_cwtAvg_kernel37(const emxArray_uint32_T y, const
  int32_T b, emxArray_real_T c);
static __global__ void ec_cwtAvg_kernel38(const emxArray_uint32_T y,
  emxArray_real_T c, int32_T abscfssq_dim1);
static __global__ void ec_cwtAvg_kernel39(const real_T a, const int32_T b,
  emxArray_creal_T cfspos);
static __global__ void ec_cwtAvg_kernel4(real_T interval[650]);
static __global__ void ec_cwtAvg_kernel40(const emxArray_creal_T cfspos, const
  int32_T b, emxArray_real_T y);
static __global__ void ec_cwtAvg_kernel41(const emxArray_real_T y, const int32_T
  b, emxArray_real_T abswt2);
static __global__ void ec_cwtAvg_kernel42(const emxArray_real_T fb_Scales, const
  emxArray_real_T abswt2, const int32_T b_abswt2, const int32_T c_abswt2,
  emxArray_real_T abswt2S, int32_T abswt2S_dim0, int32_T abswt2_dim0);
static __global__ void ec_cwtAvg_kernel43(const emxArray_real_T abswt2S, const
  int32_T b, const int32_T b_abswt2S, emxArray_real_T y, int32_T y_dim0, int32_T
  abswt2S_dim0);
static __global__ void ec_cwtAvg_kernel44(const emxArray_real_T fb_Scales,
  real_T *r);
static __global__ void ec_cwtAvg_kernel45(const real_T *r, emxArray_real_T
  savgpTMP);
static __global__ void ec_cwtAvg_kernel46(const emxArray_real_T savgpTMP, const
  int32_T b_savgpTMP, emxArray_real_T xCh);
static __global__ void ec_cwtAvg_kernel47(const int32_T b, emxArray_real_T dv22);
static __global__ void ec_cwtAvg_kernel48(const emxArray_real_T dv22, const
  emxArray_real_T h, const int32_T b_h, emxArray_real_T h1);
static __global__ void ec_cwtAvg_kernel49(const real_T r, const emxArray_real_T
  h1, const real_T q_ok, const int32_T b_h1, emxArray_real_T opts_filter);
static __global__ void ec_cwtAvg_kernel5(const int32_T nrefine, real_T interval
  [650]);
static __global__ void ec_cwtAvg_kernel50(const int32_T delta, emxArray_real_T h);
static __global__ void ec_cwtAvg_kernel51(const emxArray_uint32_T y, const
  real_T delta, const int32_T b_y, emxArray_int32_T iv9);
static __global__ void ec_cwtAvg_kernel52(const emxArray_real_T opts_filter,
  const emxArray_int32_T iv9, const int32_T b_iv9, emxArray_real_T h);
static __global__ void ec_cwtAvg_kernel53(const int32_T xCh, emxArray_real_T
  yCol);
static __global__ void ec_cwtAvg_kernel54(const emxArray_real_T xCh, const
  int32_T lidx, const int32_T omega_tmp2, emxArray_real_T yCol);
static __global__ void ec_cwtAvg_kernel55(const emxArray_real_T yCol, const
  int32_T origSiz, emxArray_real_T x);
static __global__ void ec_cwtAvg_kernel56(const emxArray_real_T h, const
  emxArray_real_T yCol, emxArray_real_T w);
static __global__ void ec_cwtAvg_kernel57(const int32_T ix, const int32_T b,
  int32_T lshift[2]);
static __global__ void ec_cwtAvg_kernel58(const int32_T ix, const int32_T lidx,
  const int32_T nG, int32_T csz[2]);
static __global__ void ec_cwtAvg_kernel59(const emxArray_real_T w, const int32_T
  xt_size_dim0, const int32_T ix, const int32_T b, const int32_T c,
  emxArray_real_T b_w, int32_T w_dim0);
static __global__ void ec_cwtAvg_kernel6(real_T interval[650]);
static __global__ void ec_cwtAvg_kernel60(const emxArray_real_T w, const int32_T
  xt_size, emxArray_real_T y);
static __global__ void ec_cwtAvg_kernel61(const emxArray_real_T w, const int32_T
  xt_size_dim0, const int32_T ix, const int32_T b, const int32_T c,
  emxArray_real_T b_w, int32_T w_dim0);
static __global__ void ec_cwtAvg_kernel62(const emxArray_real_T w, const int32_T
  xt_size_dim0, const int32_T b, const int32_T c, emxArray_real_T y, int32_T
  y_dim0);
static __global__ void ec_cwtAvg_kernel63(emxArray_real_T y);
static __global__ void ec_cwtAvg_kernel64(const emxArray_real_T y, const
  emxArray_real_T b_y, const real_T intDsq, const int32_T b, emxArray_real_T xCh);
static __global__ void ec_cwtAvg_kernel65(const int32_T b, emxArray_real_T y);
static __global__ void ec_cwtAvg_kernel66(const int32_T b, emxArray_real_T w);
static __global__ void ec_cwtAvg_kernel67(const emxArray_real_T yCol, const
  emxArray_real_T h, emxArray_real_T w);
static __global__ void ec_cwtAvg_kernel68(const int32_T nG, emxArray_real_T
  expanded);
static __global__ void ec_cwtAvg_kernel69(const int32_T lidx, const
  emxArray_int32_T y, const int32_T b_y, emxArray_int32_T iv14);
static __global__ void ec_cwtAvg_kernel7(real_T interval[650]);
static __global__ void ec_cwtAvg_kernel70(const emxArray_real_T h, const
  emxArray_int32_T iv14, const int32_T omega_tmp2, emxArray_real_T expanded);
static __global__ void ec_cwtAvg_kernel71(const emxArray_real_T yCol, const
  emxArray_real_T expanded, const emxArray_int32_T rows, const int32_T
  origSiz_dim0, const int32_T b, emxArray_real_T w);
static __global__ void ec_cwtAvg_kernel72(const int32_T b, emxArray_real_T w);
static __global__ void ec_cwtAvg_kernel73(const emxArray_real_T c, const int32_T
  b, emxArray_real_T w);
static __global__ void ec_cwtAvg_kernel74(const int32_T nG, emxArray_real_T
  expanded);
static __global__ void ec_cwtAvg_kernel75(const int32_T lidx, const
  emxArray_int32_T y, const int32_T b_y, emxArray_int32_T iv15);
static __global__ void ec_cwtAvg_kernel76(const emxArray_real_T yCol, const
  emxArray_int32_T iv15, const int32_T xt_size, emxArray_real_T expanded);
static __global__ void ec_cwtAvg_kernel77(const emxArray_real_T expanded, const
  emxArray_int32_T rows, const emxArray_real_T h, const int32_T b,
  emxArray_real_T w, int32_T h_dim0);
static __global__ void ec_cwtAvg_kernel78(const int32_T b, emxArray_uint32_T y);
static __global__ void ec_cwtAvg_kernel79(const creal_T *dc6, const real_T
  table100[100], const creal_T dc7, const creal_T *dc1, const int32_T ix, const
  int32_T lidx, const int32_T nrefine, const int32_T i, const int64_T b,
  emxArray_real_T dv22, real_T q1_dim0, real_T q1_dim1, real_T q1_dim2, real_T
  q1_dim3, real_T q1_dim4, real_T q1_dim5, real_T q1_dim6, real_T q1_dim7,
  real_T p1_dim0, real_T p1_dim1, real_T p1_dim2, real_T p1_dim3, real_T p1_dim4,
  real_T p1_dim5, real_T p1_dim6, real_T p1_dim7, real_T q2_dim0, real_T q2_dim1,
  real_T q2_dim2, real_T q2_dim3, real_T q2_dim4, real_T q2_dim5, real_T q2_dim6,
  real_T q2_dim7, real_T p2_dim0, real_T p2_dim1, real_T p2_dim2, real_T p2_dim3,
  real_T p2_dim4, real_T p2_dim5, real_T p2_dim6, real_T p2_dim7, real_T q4_dim0,
  real_T q4_dim1, real_T q4_dim2, real_T q4_dim3, real_T q4_dim4, real_T q4_dim5,
  real_T q4_dim6, real_T q4_dim7, real_T p4_dim0, real_T p4_dim1, real_T p4_dim2,
  real_T p4_dim3, real_T p4_dim4, real_T p4_dim5, real_T p4_dim6, real_T p4_dim7,
  real_T c_dim0, real_T c_dim1, real_T c_dim2, real_T c_dim3, real_T c_dim4,
  real_T c_dim5, real_T c_dim6);
static __global__ void ec_cwtAvg_kernel8(const int32_T nrefine, real_T interval
  [650]);
static __global__ void ec_cwtAvg_kernel80(const int32_T b, emxArray_real_T m);
static __global__ void ec_cwtAvg_kernel81(const emxArray_real_T m, const int32_T
  b_m, emxArray_real_T k);
static __global__ void ec_cwtAvg_kernel82(const int32_T k, emxArray_real_T G);
static __global__ void ec_cwtAvg_kernel83(const int32_T k, emxArray_real_T b);
static __global__ void ec_cwtAvg_kernel84(const real_T delta, const
  emxArray_real_T k, const int32_T b_k, emxArray_real_T dv23);
static __global__ void ec_cwtAvg_kernel85(const real_T delta, const
  emxArray_real_T k, const int32_T b, emxArray_real_T dv24, emxArray_real_T dv23);
static __global__ void ec_cwtAvg_kernel86(const int32_T b, emxArray_real_T dv24);
static __global__ void ec_cwtAvg_kernel87(const emxArray_real_T k, const
  emxArray_real_T dv24, const emxArray_real_T dv23, const real_T a, const
  int32_T b, emxArray_real_T b_b);
static __global__ void ec_cwtAvg_kernel88(const real_T delta, const
  emxArray_real_T k, const int32_T b_k, emxArray_real_T y);
static __global__ void ec_cwtAvg_kernel89(const real_T delta, const
  emxArray_real_T k, const int32_T b, emxArray_real_T y, emxArray_real_T b_y);
static __global__ void ec_cwtAvg_kernel9(const real_T fc, const emxArray_int32_T
  omega_tmp1, const int32_T b_omega_tmp1, emxArray_real_T omega_tmp2);
static __global__ void ec_cwtAvg_kernel90(const int32_T b, emxArray_real_T y);
static __global__ void ec_cwtAvg_kernel91(const emxArray_real_T y, const real_T
  delta, const emxArray_real_T b_y, const real_T a, const int32_T b,
  emxArray_real_T b_b);
static __global__ void ec_cwtAvg_kernel92(const real_T r, const real_T b_r,
  const int32_T nG, const int32_T nx, const int32_T b, emxArray_real_T sinc4A,
  emxArray_real_T sinc3A, emxArray_real_T sinc2A, emxArray_real_T sinc1A);
static __global__ void ec_cwtAvg_kernel93(const emxArray_real_T sinc4A, const
  emxArray_real_T sinc2A, const real_T r, const emxArray_real_T sinc3A, const
  emxArray_real_T sinc1A, const real_T b_r, const int32_T nG, const int32_T b,
  const int32_T c, emxArray_real_T G, int32_T G_dim0);
static __global__ void ec_cwtAvg_kernel94(const real_T intFsq, emxArray_real_T
  b0);
static __global__ void ec_cwtAvg_kernel95(const emxArray_real_T b, const int32_T
  c, emxArray_real_T b0);
static __global__ void ec_cwtAvg_kernel96(const emxArray_real_T b0, const
  int32_T b_b0, emxArray_real_T b);
static __global__ void ec_cwtAvg_kernel97(const int32_T G, emxArray_real_T a);
static __global__ void ec_cwtAvg_kernel98(const emxArray_real_T a, const int32_T
  ix, const int32_T nrefine, const int32_T y_size_idx_1, emxArray_real_T h);
static __global__ void ec_cwtAvg_kernel99(const emxArray_real_T a, const int32_T
  ix, const int32_T nrefine, const int32_T lidx, emxArray_real_T h);
static void ec_cwtAvg_once();
static void emlrtExitTimeCleanupDtorFcn(const void *r);
static void emlrt_marshallIn(const mxArray *b_nullptr, const char_T *identifier,
  emxArray_real_T *y);
static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y);
static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, char_T y[23]);
static void emlrt_marshallIn(const mxArray *a__output_of_sprintf_, const char_T *
  identifier, char_T y[23]);
static real_T emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId);
static real_T emlrt_marshallIn(const mxArray *a__output_of_length_, const char_T
  *identifier);
static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_char_T *y);
static void emlrt_marshallIn(const mxArray *tmpStr, const char_T *identifier,
  emxArray_char_T *y);
static const mxArray *emlrt_marshallOut(const cell_wrap_0 u_data[], const
  int32_T u_size[2]);
static const mxArray *emlrt_marshallOut(const emxArray_real_T *u);
static void emxEnsureCapacity_cell_wrap_0(cell_wrap_0 data[65534], const int32_T
  size[2], int32_T oldNumel, const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_char_T(emxArray_char_T *emxArray, int32_T oldNumel,
  const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_creal_T(emxArray_creal_T *emxArray, int32_T
  oldNumel, const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_int32_T(emxArray_int32_T *emxArray, int32_T
  oldNumel, const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_ptrdiff_t(emxArray_ptrdiff_t *emxArray, int32_T
  oldNumel, const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_real_T(emxArray_real_T *emxArray, int32_T oldNumel,
  const emlrtRTEInfo *srcLocation);
static void emxEnsureCapacity_uint32_T(emxArray_uint32_T *emxArray, int32_T
  oldNumel, const emlrtRTEInfo *srcLocation);
static void emxExpand_cell_wrap_0_1x65534(cell_wrap_0 data[65534], int32_T
  fromIndex, int32_T toIndex, const emlrtRTEInfo *srcLocation);
static void emxFreeStruct_cell_wrap_0(cell_wrap_0 *pStruct);
static void emxFree_cell_wrap_0_1x65534(emxArray_cell_wrap_0_1x65534 *pEmxArray);
static void emxFree_char_T(emxArray_char_T **pEmxArray);
static void emxFree_creal_T(emxArray_creal_T **pEmxArray);
static void emxFree_int32_T(emxArray_int32_T **pEmxArray);
static void emxFree_ptrdiff_t(emxArray_ptrdiff_t **pEmxArray);
static void emxFree_real_T(emxArray_real_T **pEmxArray);
static void emxFree_uint32_T(emxArray_uint32_T **pEmxArray);
static void emxInitStruct_cell_wrap_0(cell_wrap_0 *pStruct, const emlrtRTEInfo
  *srcLocation, boolean_T doPush);
static void emxInit_cell_wrap_0_1x65534(emxArray_cell_wrap_0_1x65534 *pEmxArray);
static void emxInit_char_T(emxArray_char_T **pEmxArray, int32_T numDimensions,
  const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_creal_T(emxArray_creal_T **pEmxArray, int32_T numDimensions,
  const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_int32_T(emxArray_int32_T **pEmxArray, int32_T numDimensions,
  const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_ptrdiff_t(emxArray_ptrdiff_t **pEmxArray, int32_T
  numDimensions, const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_real_T(emxArray_real_T **pEmxArray, int32_T numDimensions,
  const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxInit_uint32_T(emxArray_uint32_T **pEmxArray, int32_T
  numDimensions, const emlrtRTEInfo *srcLocation, boolean_T doPush);
static void emxTrim_cell_wrap_0_1x65534(cell_wrap_0 data[65534], int32_T
  fromIndex, int32_T toIndex);
static const mxArray *feval(const mxArray *m1, const mxArray *m2, const mxArray *
  m3, emlrtMCInfo *location);
static const mxArray *feval(const mxArray *m1, const mxArray *m2, emlrtMCInfo
  *location);
static void gpuEmxEnsureCapacity_creal_T(const emxArray_creal_T *cpu,
  emxArray_creal_T *gpu, boolean_T needsCopy);
static void gpuEmxEnsureCapacity_int32_T(const emxArray_int32_T *cpu,
  emxArray_int32_T *gpu, boolean_T needsCopy);
static void gpuEmxEnsureCapacity_real_T(const emxArray_real_T *cpu,
  emxArray_real_T *gpu, boolean_T needsCopy);
static void gpuEmxEnsureCapacity_uint32_T(const emxArray_uint32_T *cpu,
  emxArray_uint32_T *gpu, boolean_T needsCopy);
static void gpuEmxFree_creal_T(emxArray_creal_T *gpu);
static void gpuEmxFree_int32_T(emxArray_int32_T *gpu);
static void gpuEmxFree_real_T(emxArray_real_T *gpu);
static void gpuEmxFree_uint32_T(emxArray_uint32_T *gpu);
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
static void gpuEmxReset_real_T(emxArray_real_T *gpu);
static void gpuEmxReset_uint32_T(emxArray_uint32_T *gpu);
static const mxArray *length(const mxArray *m1, emlrtMCInfo *location);
static void raiseCudaError(int32_T errCode, const char_T *file, uint32_T b_line,
  const char_T *errorName, const char_T *errorString);
static real_T rt_powd_snf(real_T u0, real_T u1);
static real_T rt_remd_snf(real_T u0, real_T u1);

// Function Definitions
static int64_T b_computeEndIdx(int64_T start, int64_T end, int64_T stride)
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

static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, char_T ret[23])
{
  static const int32_T dims[2]{ 1, 23 };

  emlrtCheckBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "char", false, 2U, (
    const void *)&dims[0]);
  emlrtImportCharArrayR2015b(emlrtRootTLSGlobal, src, &ret[0], 23);
  emlrtDestroyArray(&src);
}

static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_char_T *ret)
{
  static const int32_T dims[2]{ 1, -1 };

  int32_T iv[2];
  int32_T i;
  boolean_T bv[2]{ false, true };

  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "char", false, 2U, (
    const void *)&dims[0], &bv[0], &iv[0]);
  i = ret->size[0] * ret->size[1];
  ret->size[0] = iv[0];
  ret->size[1] = iv[1];
  emxEnsureCapacity_char_T(ret, i, static_cast<emlrtRTEInfo *>(nullptr));
  emlrtImportArrayR2015b(emlrtRootTLSGlobal, src, &ret->data[0], 1, false);
  emlrtDestroyArray(&src);
}

static real_T (*b_emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId))[2]
{
  real_T (*y)[2];
  y = d_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
static real_T (*b_emlrt_marshallIn(const mxArray *b_nullptr, const char_T
*identifier))[2]
{
  emlrtMsgIdentifier thisId;
  real_T (*y)[2];
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(emlrtAlias(b_nullptr), &thisId);
  emlrtDestroyArray(&b_nullptr);
  return y;
}

static void b_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
  *msgId, emxArray_real_T *ret)
{
  static const int32_T dims[2]{ -1, -1 };

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

static void b_feval(const mxArray *m, const mxArray *m1, emlrtMCInfo *location)
{
  const mxArray *pArrays[2];
  pArrays[0] = m;
  pArrays[1] = m1;
  emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 0, nullptr, 2, &pArrays[0], "feval",
                        true, location);
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

static void binary_expand_op(emxArray_real_T *in1, real_T in2, const
  emxArray_real_T *in3, real_T in4, const emxArray_real_T *in5)
{
  emxArray_real_T *b_in1;
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_1_0;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&b_in1, 1, &le_emlrtRTEI, true);
  i = b_in1->size[0];
  if (in3->size[0] == 1) {
    b_in1->size[0] = in1->size[0];
  } else {
    b_in1->size[0] = in3->size[0];
  }

  emxEnsureCapacity_real_T(b_in1, i, &le_emlrtRTEI);
  stride_0_0 = (in1->size[0] != 1);
  stride_1_0 = (in3->size[0] != 1);
  if (in3->size[0] == 1) {
    b = in1->size[0];
  } else {
    b = in3->size[0];
  }

  for (i = 0; i < b; i++) {
    b_in1->data[i] = in1->data[i * stride_0_0] + (in2 * in3->data[i * stride_1_0]
      - in4 * in5->data[i * stride_1_0]);
  }

  i = in1->size[0];
  in1->size[0] = b_in1->size[0];
  emxEnsureCapacity_real_T(in1, i, &me_emlrtRTEI);
  for (i = 0; i < b_in1->size[0]; i++) {
    in1->data[i] = b_in1->data[i];
  }

  emxFree_real_T(&b_in1);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

static void binary_expand_op_1(emxArray_real_T *in1, real_T in2, const
  emxArray_real_T *in3, const emxArray_real_T *in4, const emxArray_real_T *in5)
{
  emxArray_real_T *b_in1;
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_1_0;
  int32_T stride_2_0;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&b_in1, 1, &ne_emlrtRTEI, true);
  i = b_in1->size[0];
  if (in5->size[0] == 1) {
    b = in3->size[0];
  } else {
    b = in5->size[0];
  }

  if (b == 1) {
    b_in1->size[0] = in1->size[0];
  } else if (in5->size[0] == 1) {
    b_in1->size[0] = in3->size[0];
  } else {
    b_in1->size[0] = in5->size[0];
  }

  emxEnsureCapacity_real_T(b_in1, i, &ne_emlrtRTEI);
  stride_0_0 = (in1->size[0] != 1);
  stride_1_0 = (in3->size[0] != 1);
  stride_2_0 = (in5->size[0] != 1);
  if (in5->size[0] == 1) {
    b = in3->size[0];
  } else {
    b = in5->size[0];
  }

  if (b == 1) {
    b = in1->size[0];
  } else if (in5->size[0] == 1) {
    b = in3->size[0];
  } else {
    b = in5->size[0];
  }

  for (i = 0; i < b; i++) {
    b_in1->data[i] = in1->data[i * stride_0_0] + in2 * (in3->data[i * stride_1_0]
      - in4->data[i * stride_1_0]) / (in5->data[i * stride_2_0] * in5->data[i *
      stride_2_0]);
  }

  i = in1->size[0];
  in1->size[0] = b_in1->size[0];
  emxEnsureCapacity_real_T(in1, i, &oe_emlrtRTEI);
  for (i = 0; i < b_in1->size[0]; i++) {
    in1->data[i] = b_in1->data[i];
  }

  emxFree_real_T(&b_in1);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

static void binary_expand_op_2(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3)
{
  int32_T i;
  int32_T in3_idx_0;
  int32_T stride_0_0;
  int32_T stride_1_0;
  in3_idx_0 = in3->size[1];
  i = in1->size[0] * in1->size[1];
  if (in3_idx_0 == 1) {
    in1->size[0] = in2->size[0];
  } else {
    in1->size[0] = in3_idx_0;
  }

  in1->size[1] = in2->size[1];
  emxEnsureCapacity_real_T(in1, i, &hb_emlrtRTEI);
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
        * i] / in3->data[i1 * stride_1_0];
    }
  }
}

static void binary_expand_op_4(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3)
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

  emxEnsureCapacity_real_T(in1, i, &o_emlrtRTEI);
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
      in1->data[i1 + in1->size[0] * i] = 0.0050536085896138528 * in2->data[i1 *
        stride_0_0 + in2->size[0] * aux_0_1] * static_cast<real_T>(in3->data[i1 *
        stride_1_0 + in3->size[0] * aux_1_1] > 0.0);
    }

    aux_1_1 += stride_1_1;
    aux_0_1 += stride_0_1;
  }
}

static void binary_expand_op_5(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3)
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

  emxEnsureCapacity_real_T(in1, i, &n_emlrtRTEI);
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
      in1->data[i1 + in1->size[0] * i] = 20.0 * in2->data[i1 * stride_0_0 +
        in2->size[0] * aux_0_1] - in3->data[i1 * stride_1_0 + in3->size[0] *
        aux_1_1];
    }

    aux_1_1 += stride_1_1;
    aux_0_1 += stride_0_1;
  }
}

static void binary_expand_op_6(emxArray_real_T *in1, const emxArray_real_T *in2,
  const emxArray_real_T *in3)
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

  emxEnsureCapacity_real_T(in1, i, &p_emlrtRTEI);
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
      in1->data[i1 + in1->size[0] * i] = 5.43656365691809 * in2->data[i1 *
        stride_0_0 + in2->size[0] * aux_0_1] * static_cast<real_T>(in3->data[i1 *
        stride_1_0 + in3->size[0] * aux_1_1] < 0.99999999999999978);
    }

    aux_1_1 += stride_1_1;
    aux_0_1 += stride_0_1;
  }
}

static void binary_expand_op_7(real_T in1_data[], int32_T in1_size[2], const
  real_T in2_data[], const int32_T in2_size[2], const real_T in3_data[], const
  int32_T in3_size[2], const real_T in4_data[], const int32_T in4_size[2])
{
  int32_T stride_0_1;
  int32_T stride_1_1;
  in1_size[0] = 1;
  in1_size[1] = in4_size[1];
  stride_0_1 = (in2_size[1] != 1);
  stride_1_1 = (in3_size[1] != 1);
  for (int32_T i{0}; i < in4_size[1]; i++) {
    in1_data[i] = in2_data[i * stride_0_1] * in3_data[i * stride_1_1] *
      in4_data[i];
  }
}

static real_T c_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier
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

static void checkCudaError(cudaError_t errCode, const char_T *file, uint32_T
  b_line)
{
  if (errCode != cudaSuccess) {
    b_raiseCudaError(errCode, file, b_line, cudaGetErrorName(errCode),
                     cudaGetErrorString(errCode));
  }
}

//
//
namespace coder
{
  namespace internal
  {
    static void warning()
    {
      static const int32_T iv[2]{ 1, 7 };

      static const int32_T iv1[2]{ 1, 7 };

      static const int32_T iv2[2]{ 1, 39 };

      static const char_T msgID[39]{ 's', 'i', 'g', 'n', 'a', 'l', ':', 'c', 'h',
        'e', 'c', 'k', '_', 'o', 'r', 'd', 'e', 'r', ':', 'I', 'n', 'v', 'a',
        'l', 'i', 'd', 'O', 'r', 'd', 'e', 'r', 'R', 'o', 'u', 'n', 'd', 'i',
        'n', 'g' };

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
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 39, m2, &msgID[0]);
      emlrtAssign(&c_y, m2);
      b_feval(y, feval(b_y, c_y, &c_emlrtMCI), &d_emlrtMCI);
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

static uint64_T computeNumIters(int64_T ub)
{
  uint64_T numIters;
  numIters = 0UL;
  if (ub >= 0L) {
    numIters = static_cast<uint64_T>(ub + 1L);
  }

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

static real_T (*d_emlrt_marshallIn(const mxArray *src, const emlrtMsgIdentifier *
  msgId))[2]
{
  static const int32_T dims[2]{ 1, 2 };

  real_T (*ret)[2];
  int32_T iv[2];
  boolean_T bv[2]{ false, false };

  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "double", false, 2U,
    (const void *)&dims[0], &bv[0], &iv[0]);
  ret = (real_T (*)[2])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
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

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel1(creal_T *dc1,
  creal_T *dc6)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    dc6->re = CUDART_INF;
    dc1->re = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel10
  (emxArray_real_T fb_Omega)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    fb_Omega.data[0] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel100(const
  emxArray_real_T a, const int32_T b_a, emxArray_real_T x)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_a);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    x.data[bcoef] = a.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel101(const
  emxArray_real_T x, const int32_T b, emxArray_real_T h)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    h.data[bcoef] = 0.5 * x.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel102(const
  emxArray_real_T b, const int32_T b_b, emxArray_real_T a)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    a.data[bcoef] = b.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel103(const
  int32_T omega_tmp2, emxArray_real_T a)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(omega_tmp2);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    a.data[bcoef] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel104(const
  int32_T G, emxArray_int32_T jpvt)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(G);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    jpvt.data[bcoef] = 0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel105(const
  int32_T b, const int32_T nx, emxArray_real_T G, int32_T G_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(nx) + 1UL) * (static_cast<uint64_T>(b) + 1UL)
    - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    int32_T kk;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    kk = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
      (static_cast<uint64_T>(b) + 1UL));
    G.data[kk * G_dim0 + i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel106(const
  int32_T b, emxArray_real_T tau)
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
    tau.data[k] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel107(const
  int32_T i, const int64_T b, emxArray_real_T tau)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int64_T k;
    k = static_cast<int64_T>(idx);
    tau.data[static_cast<int32_T>(static_cast<int64_T>(i) + k) - 1] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel108(const
  int32_T nx, emxArray_int32_T jpvt)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nx);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    jpvt.data[k] = k + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel109(const
  int32_T G, emxArray_real_T a)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(G);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    a.data[bcoef] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel11(const
  emxArray_real_T omega_tmp2, const int32_T b, emxArray_real_T fb_Omega)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    fb_Omega.data[bcoef + 1] = omega_tmp2.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel110(const
  int32_T omega_tmp2, emxArray_real_T b)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(omega_tmp2);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    b.data[bcoef] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel111(const
  emxArray_real_T b, const emxArray_int32_T jpvt, const int32_T ix,
  emxArray_real_T a)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(ix);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    a.data[jpvt.data[i] - 1] = b.data[i];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel112(const
  emxArray_real_T b, const int32_T b_b, emxArray_real_T a)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    a.data[bcoef] = 4.0 * b.data[bcoef];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel113
  (emxArray_real_T a)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    a.data[0] /= 2.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel114(const
  int32_T b, emxArray_real_T m)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    m.data[bcoef] = static_cast<real_T>(bcoef);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel115(const
  int32_T abswt2S, emxArray_real_T savgpTMP)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(abswt2S);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    savgpTMP.data[bcoef] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel116(const
  int32_T abswt2S, emxArray_real_T savgpTMP)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(abswt2S);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    savgpTMP.data[bcoef] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel117(const
  emxArray_real_T fb_Scales, const int32_T b, emxArray_real_T c)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    c.data[bcoef] = fb_Scales.data[0];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel118(const
  int32_T lidx, const emxArray_real_T fb_Scales, emxArray_real_T c)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    real_T r;
    r = 0.5 * fb_Scales.data[0];
    c.data[0] = r;
    c.data[lidx - 1] = r;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel119(const
  emxArray_real_T fb_Scales, emxArray_real_T c)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[0] = 0.5 * (fb_Scales.data[1] - fb_Scales.data[0]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel12(const
  int32_T nrefine, const int32_T i, const emxArray_real_T omega_tmp2, const
  int32_T y_size_idx_1, emxArray_real_T fb_Omega, int32_T omega_tmp2_dim1)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(y_size_idx_1);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    fb_Omega.data[(bcoef + omega_tmp2_dim1) + 1] = -omega_tmp2.data[i + nrefine *
      bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel120(const
  emxArray_real_T fb_Scales, const int32_T b, emxArray_real_T c)
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
    c.data[k + 1] = 0.5 * (fb_Scales.data[k + 2] - fb_Scales.data[k]);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel121(const
  emxArray_real_T fb_Scales, const int32_T lidx, emxArray_real_T c)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[lidx - 1] = 0.5 * (fb_Scales.data[lidx - 1] - fb_Scales.data[lidx - 2]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel122(const
  emxArray_real_T fb_Scales, const int32_T b, emxArray_real_T c)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    c.data[bcoef] = fb_Scales.data[0];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel123(const real_T
  r, emxArray_real_T c, int32_T z_dim0)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[0] = r;
    c.data[z_dim0 - 1] = r;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel124(const
  emxArray_real_T fb_Scales, emxArray_real_T c)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[0] = 0.5 * (fb_Scales.data[1] - fb_Scales.data[0]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel125(const
  emxArray_real_T fb_Scales, const int32_T b, emxArray_real_T c)
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
    c.data[k + 1] = 0.5 * (fb_Scales.data[k + 2] - fb_Scales.data[k]);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel126(const
  emxArray_real_T fb_Scales, emxArray_real_T c, int32_T z_dim0)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[z_dim0 - 1] = 0.5 * (fb_Scales.data[z_dim0 - 1] -
      fb_Scales.data[z_dim0 - 2]);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel127(const
  emxArray_uint32_T y, emxArray_real_T c)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[0] = 0.5 * static_cast<real_T>(static_cast<int32_T>(y.data[1]) -
      static_cast<int32_T>(y.data[0]));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel128(const
  emxArray_uint32_T y, const int32_T b, emxArray_real_T c)
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
    c.data[k + 1] = 0.5 * static_cast<real_T>(static_cast<int32_T>(y.data[k + 2])
      - static_cast<int32_T>(y.data[k]));
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel129(const
  emxArray_uint32_T y, emxArray_real_T c, int32_T abscfssq_dim1)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[abscfssq_dim1 - 1] = 0.5 * static_cast<real_T>(static_cast<int32_T>
      (y.data[abscfssq_dim1 - 1]) - static_cast<int32_T>(y.data[abscfssq_dim1 -
      2]));
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel13
  (emxArray_real_T y)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    y.data[0] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel130(const
  int32_T b, emxArray_uint32_T y)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    y.data[bcoef] = static_cast<uint32_T>(bcoef) + 1U;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel131(real_T
  interval[650])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    interval[0] = -1.0;
    interval[1] = 1.0;
  }
}

static __global__ __launch_bounds__(128, 1) void ec_cwtAvg_kernel132(real_T
  interval[650])
{
  int32_T k;
  k = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (k < 648) {
    interval[k + 2] = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel133(const
  int32_T nrefine, real_T interval[650])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    interval[1] = interval[nrefine];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel134(const
  real_T interval[650], const int32_T b, real_T subs[1298])
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
    subs[k << 1] = interval[k];
    subs[(k << 1) + 1] = interval[k + 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel135(const
  real_T x_data[9735], const int32_T b, real_T xt_data[9735], real_T b_x_data
  [9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    real_T sgn;
    real_T tkd1mtk;
    int32_T k;
    k = static_cast<int32_T>(idx);
    sgn = x_data[k];
    tkd1mtk = sgn * sgn;
    b_x_data[k] = 0.29999999999999982 * sgn * (3.0 - tkd1mtk) + 5.0;
    xt_data[k] = 0.89999999999999947 * (1.0 - tkd1mtk);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel136(const
  int32_T b, real_T fx_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    fx_data[bcoef] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel137(const
  real_T x_data[9735], const int32_T x_size, real_T a_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(x_size);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    a_data[bcoef] = (x_data[bcoef] - 5.0) / 0.6;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel138(const
  real_T a_data[9735], const int32_T b, real_T y_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    real_T sgn;
    int32_T k;
    k = static_cast<int32_T>(idx);
    sgn = a_data[k];
    y_data[k] = sgn * sgn;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel139(const
  real_T y_data[9735], const int32_T b, real_T x_data[9735])
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
    x_data[k] = exp(-2.0 * (1.0 / (1.0 - y_data[k])));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel14(const
  emxArray_real_T y, const real_T fc, const int32_T b, emxArray_real_T b_y)
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
    b_y.data[k] = pow(fc, y.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel140(const
  real_T x_data[9735], const int32_T b, real_T y_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    y_data[bcoef] = 14.7781121978613 * x_data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel141(const
  real_T y_data[9735], const int32_T b, real_T b_y_data[9735])
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
    b_y_data[k] = y_data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel142(const
  real_T xt_data[9735], const real_T x_data[9735], const real_T y_data[9735],
  const int32_T y_size, real_T fx_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(y_size);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    fx_data[bcoef] = y_data[bcoef] / x_data[bcoef] * xt_data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel143(const
  real_T cfsposdft_re, const emxArray_creal_T cfsposdft, const int32_T
  b_cfsposdft, emxArray_creal_T cfspos)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_cfsposdft);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    real_T sgn;
    real_T tkd1mtk;
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    tkd1mtk = cfsposdft.data[bcoef].re;
    sgn = cfsposdft.data[bcoef].im;
    if (sgn == 0.0) {
      cfspos.data[bcoef].re = tkd1mtk / cfsposdft_re;
      cfspos.data[bcoef].im = 0.0;
    } else if (tkd1mtk == 0.0) {
      cfspos.data[bcoef].re = 0.0;
      cfspos.data[bcoef].im = sgn / cfsposdft_re;
    } else {
      cfspos.data[bcoef].re = tkd1mtk / cfsposdft_re;
      cfspos.data[bcoef].im = sgn / cfsposdft_re;
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel144(const
  int32_T b, emxArray_creal_T xposdft, uint32_T xSize_dim1)
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
    xposdft.data[(static_cast<int32_T>(xSize_dim1) - i) - 1].re = xposdft.data[i
      + 1].re;
    xposdft.data[(static_cast<int32_T>(xSize_dim1) - i) - 1].im =
      -xposdft.data[i + 1].im;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel145(const
  emxArray_real_T fb_Omega, const emxArray_real_T fb_Scales, const int32_T
  b_fb_Scales, const int32_T b, emxArray_real_T somega, int32_T somega_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b) + 1UL) * (static_cast<uint64_T>
    (b_fb_Scales) + 1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    int32_T kk;
    kk = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_fb_Scales) + 1UL));
    bcoef = static_cast<int32_T>((idx - static_cast<uint64_T>(kk)) / (
      static_cast<uint64_T>(b_fb_Scales) + 1UL));
    somega.data[kk + somega_dim0 * bcoef] = fb_Scales.data[kk] *
      fb_Omega.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel146(const
  emxArray_real_T somega, const int32_T b_somega, emxArray_real_T w)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_somega);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    w.data[bcoef] = (somega.data[bcoef] - 5.0) / 0.6;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel147(const
  emxArray_real_T w, const int32_T b_w, emxArray_real_T expnt)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_w);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    expnt.data[bcoef] = -1.0 / (1.0 - w.data[bcoef] * w.data[bcoef]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel148(const
  int32_T b, emxArray_real_T expnt)
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
    expnt.data[k] = exp(expnt.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel149(const
  emxArray_real_T w, const int32_T b, emxArray_real_T y)
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
    y.data[k] = fabs(w.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel15(const
  emxArray_real_T y, const real_T r, const int32_T b_y, emxArray_real_T
  fb_Scales)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    fb_Scales.data[bcoef] = r * y.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel150(const
  emxArray_real_T y, const emxArray_real_T expnt, const int32_T b_expnt,
  emxArray_real_T daughter)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_expnt);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    daughter.data[bcoef] = 5.43656365691809 * expnt.data[bcoef] *
      static_cast<real_T>(y.data[bcoef] < 0.99999999999999978);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel151(const
  int32_T nrefine, emxArray_real_T daughter)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nrefine);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    if (isnan(daughter.data[i])) {
      daughter.data[i] = 0.0;
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel152(const
  emxArray_real_T fb_Scales, const int32_T b_fb_Scales, emxArray_real_T f)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fb_Scales);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    f.data[bcoef] = 0.79577471545947676 / fb_Scales.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel153(const
  emxArray_real_T fb_Omega, const emxArray_real_T fb_Scales, const int32_T
  b_fb_Scales, const int32_T b, emxArray_real_T somega, int32_T somega_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b) + 1UL) * (static_cast<uint64_T>
    (b_fb_Scales) + 1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    int32_T kk;
    kk = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_fb_Scales) + 1UL));
    bcoef = static_cast<int32_T>((idx - static_cast<uint64_T>(kk)) / (
      static_cast<uint64_T>(b_fb_Scales) + 1UL));
    somega.data[kk + somega_dim0 * bcoef] = fb_Scales.data[kk] *
      fb_Omega.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel154(const
  int32_T b, emxArray_real_T y)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    y.data[bcoef] = static_cast<real_T>(bcoef);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel155(const char_T
  cv[128], char_T wav[5], char_T wname[5], char_T b_dim0, char_T b_dim1, char_T
  b_dim2, char_T b_dim3, char_T b_dim4)
{
  __shared__ char_T b_shared[5];
  int32_T k;
  if (mwGetThreadIndexWithinBlock() == 0U) {
    b_shared[0] = b_dim0;
    b_shared[1] = b_dim1;
    b_shared[2] = b_dim2;
    b_shared[3] = b_dim3;
    b_shared[4] = b_dim4;
  }

  __syncthreads();
  k = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (k < 5) {
    wname[k] = cv[static_cast<int32_T>(b_shared[k])];
    wav[k] = cv[static_cast<int32_T>(cv[static_cast<int32_T>(b_shared[k])])];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel156(real_T
  interval[650])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    interval[0] = 0.0;
    interval[1] = 1.0;
  }
}

static __global__ __launch_bounds__(128, 1) void ec_cwtAvg_kernel157(real_T
  interval[650])
{
  int32_T k;
  k = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (k < 648) {
    interval[k + 2] = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel158(const
  int32_T nrefine, real_T interval[650])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    interval[1] = interval[nrefine];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel159(real_T
  interval[650])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    interval[0] = 0.0;
    interval[1] = 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel16(const
  emxArray_real_T somega, const int32_T b, emxArray_real_T absomega)
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
    absomega.data[k] = fabs(somega.data[k]);
  }
}

static __global__ __launch_bounds__(128, 1) void ec_cwtAvg_kernel160(real_T
  interval[650])
{
  int32_T k;
  k = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (k < 648) {
    interval[k + 2] = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel161(const
  int32_T nrefine, real_T interval[650])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    interval[1] = interval[nrefine];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel162
  (emxArray_real_T y)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    y.data[0] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel163(const
  emxArray_real_T y, const real_T delta, const int32_T b, emxArray_real_T b_y)
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
    b_y.data[k] = pow(delta, y.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel164(const
  emxArray_real_T y, const real_T r, const int32_T b_y, emxArray_real_T
  fb_Scales)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    fb_Scales.data[bcoef] = r * y.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel165(const
  int32_T b, emxArray_real_T y)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    y.data[bcoef] = static_cast<real_T>(bcoef);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel166(const
  real_T interval[650], const int32_T b, real_T subs[1298])
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
    subs[k << 1] = interval[k];
    subs[(k << 1) + 1] = interval[k + 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel167(const
  real_T x_data[9735], const int32_T b, real_T xt_data[9735], real_T b_x_data
  [9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    real_T sgn;
    real_T tkd1mtk;
    int32_T k;
    k = static_cast<int32_T>(idx);
    sgn = x_data[k];
    tkd1mtk = sgn / (1.0 - sgn);
    b_x_data[k] = tkd1mtk * tkd1mtk;
    xt_data[k] = 2.0 * tkd1mtk / ((1.0 - sgn) * (1.0 - sgn));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel168(const
  int32_T b, real_T fx_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    fx_data[bcoef] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel169(const
  real_T x_data[9735], const int32_T b, real_T dv15_data[9735])
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
    dv15_data[k] = pow(x_data[k], 40.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel17(const
  emxArray_real_T absomega, const int32_T b_absomega, emxArray_real_T powscales)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_absomega);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    powscales.data[bcoef] = absomega.data[bcoef] * absomega.data[bcoef] *
      absomega.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel170(const
  real_T x_data[9735], const int32_T b, real_T y_data[9735])
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
    y_data[k] = pow(x_data[k], 3.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel171(const
  real_T y_data[9735], const int32_T b, real_T b_y_data[9735])
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
    b_y_data[k] = exp(-2.0 * y_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel172(const
  real_T xt_data[9735], const real_T y_data[9735], const real_T dv15_data[9735],
  const int32_T dv15_size, real_T fx_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv15_size);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    fx_data[bcoef] = dv15_data[bcoef] * y_data[bcoef] * xt_data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel173(const
  real_T interval[650], const int32_T b, real_T subs[1298])
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
    subs[k << 1] = interval[k];
    subs[(k << 1) + 1] = interval[k + 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel174(const
  real_T x_data[9735], const int32_T b, real_T xt_data[9735], real_T b_x_data
  [9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    real_T sgn;
    real_T tkd1mtk;
    int32_T k;
    k = static_cast<int32_T>(idx);
    sgn = x_data[k];
    tkd1mtk = sgn / (1.0 - sgn);
    b_x_data[k] = tkd1mtk * tkd1mtk;
    xt_data[k] = 2.0 * tkd1mtk / ((1.0 - sgn) * (1.0 - sgn));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel175(const
  int32_T b, real_T fx_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    fx_data[bcoef] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel176(const
  real_T x_data[9735], const int32_T b, real_T y_data[9735])
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
    y_data[k] = pow(x_data[k], 19.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel177(const
  real_T x_data[9735], const int32_T b, real_T y_data[9735])
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
    y_data[k] = pow(x_data[k], 22.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel178(const
  real_T y_data[9735], const real_T b_y_data[9735], const int32_T y_size, real_T
  a_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(y_size);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    a_data[bcoef] = 20.0 * b_y_data[bcoef] - 3.0 * y_data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel179(const
  real_T a_data[9735], const int32_T b, real_T dv11_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    real_T sgn;
    int32_T k;
    k = static_cast<int32_T>(idx);
    sgn = a_data[k];
    dv11_data[k] = sgn * sgn;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel18(const
  int32_T b, emxArray_real_T absomega)
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
    absomega.data[k] = log(absomega.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel180(const
  real_T x_data[9735], const int32_T b, real_T y_data[9735])
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
    y_data[k] = pow(x_data[k], 3.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel181(const
  real_T y_data[9735], const int32_T b, real_T b_y_data[9735])
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
    b_y_data[k] = exp(-2.0 * y_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel182(const
  real_T xt_data[9735], const real_T y_data[9735], const real_T dv11_data[9735],
  const int32_T dv11_size, real_T fx_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv11_size);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    fx_data[bcoef] = dv11_data[bcoef] * y_data[bcoef] * xt_data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel183(const
  int32_T b, emxArray_int32_T omega_tmp1)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    omega_tmp1.data[bcoef] = bcoef + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel184(const
  real_T interval[650], const int32_T b, real_T subs[1298])
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
    subs[k << 1] = interval[k];
    subs[(k << 1) + 1] = interval[k + 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel185(const
  real_T x_data[9735], const int32_T b, real_T xt_data[9735], real_T b_x_data
  [9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    real_T sgn;
    real_T tkd1mtk;
    int32_T k;
    k = static_cast<int32_T>(idx);
    sgn = x_data[k];
    tkd1mtk = sgn / (1.0 - sgn);
    b_x_data[k] = tkd1mtk * tkd1mtk;
    xt_data[k] = 2.0 * tkd1mtk / ((1.0 - sgn) * (1.0 - sgn));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel186(const
  int32_T b, real_T fx_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    fx_data[bcoef] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel187(const
  real_T x_data[9735], const int32_T b, real_T dv10_data[9735])
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
    dv10_data[k] = pow(x_data[k], 40.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel188(const
  real_T x_data[9735], const int32_T b, real_T y_data[9735])
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
    y_data[k] = pow(x_data[k], 3.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel189(const
  real_T y_data[9735], const int32_T b, real_T b_y_data[9735])
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
    b_y_data[k] = exp(-2.0 * y_data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel19(const
  emxArray_real_T powscales, const emxArray_real_T absomega, const int32_T
  b_absomega, emxArray_real_T x)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_absomega);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    x.data[bcoef] = 20.0 * absomega.data[bcoef] - powscales.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel190(const
  real_T xt_data[9735], const real_T y_data[9735], const real_T dv10_data[9735],
  const int32_T dv10_size, real_T fx_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv10_size);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    fx_data[bcoef] = dv10_data[bcoef] * y_data[bcoef] * xt_data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel191(const
  real_T interval[650], const int32_T b, real_T subs[1298])
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
    subs[k << 1] = interval[k];
    subs[(k << 1) + 1] = interval[k + 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel192(const
  real_T x_data[9735], const int32_T b, real_T xt_data[9735], real_T b_x_data
  [9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    real_T sgn;
    real_T tkd1mtk;
    int32_T k;
    k = static_cast<int32_T>(idx);
    sgn = x_data[k];
    tkd1mtk = sgn / (1.0 - sgn);
    b_x_data[k] = tkd1mtk * tkd1mtk;
    xt_data[k] = 2.0 * tkd1mtk / ((1.0 - sgn) * (1.0 - sgn));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel193(const
  int32_T b, real_T fx_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    fx_data[bcoef] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel194(const
  real_T x_data[9735], const int32_T b, real_T y_data[9735])
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
    y_data[k] = pow(x_data[k], 19.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel195(const
  real_T x_data[9735], const int32_T b, real_T y_data[9735])
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
    y_data[k] = pow(x_data[k], 22.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel196(const
  real_T y_data[9735], const real_T b_y_data[9735], const int32_T y_size, real_T
  a_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(y_size);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    a_data[bcoef] = 20.0 * b_y_data[bcoef] - 3.0 * y_data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel197(const
  real_T a_data[9735], const int32_T b, real_T dv4_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    real_T sgn;
    int32_T k;
    k = static_cast<int32_T>(idx);
    sgn = a_data[k];
    dv4_data[k] = sgn * sgn;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel198(const
  real_T x_data[9735], const int32_T b, real_T y_data[9735])
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
    y_data[k] = pow(x_data[k], 3.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel199(const
  real_T y_data[9735], const int32_T b, real_T b_y_data[9735])
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
    b_y_data[k] = exp(-2.0 * y_data[k]);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel2(const char_T
  cv[128], char_T wname[5], char_T wav[5], char_T b_dim0, char_T b_dim1, char_T
  b_dim2, char_T b_dim3, char_T b_dim4)
{
  __shared__ char_T b_shared[5];
  int32_T k;
  if (mwGetThreadIndexWithinBlock() == 0U) {
    b_shared[0] = b_dim0;
    b_shared[1] = b_dim1;
    b_shared[2] = b_dim2;
    b_shared[3] = b_dim3;
    b_shared[4] = b_dim4;
  }

  __syncthreads();
  k = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (k < 5) {
    wav[k] = cv[static_cast<int32_T>(b_shared[k])];
    wname[k] = cv[static_cast<int32_T>(cv[static_cast<int32_T>(b_shared[k])])];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel20(const
  int32_T b, emxArray_real_T x)
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
    x.data[k] = exp(x.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel200(const
  real_T xt_data[9735], const real_T y_data[9735], const real_T dv4_data[9735],
  const int32_T dv4_size, real_T fx_data[9735])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(dv4_size);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    fx_data[bcoef] = dv4_data[bcoef] * y_data[bcoef] * xt_data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel21(const
  emxArray_real_T somega, const emxArray_real_T x, const int32_T b_x,
  emxArray_real_T daughter)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    daughter.data[bcoef] = 0.0050536085896138528 * x.data[bcoef] *
      static_cast<real_T>(somega.data[bcoef] > 0.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel22(const
  emxArray_real_T fb_Scales, const int32_T b_fb_Scales, emxArray_real_T f)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_fb_Scales);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    f.data[bcoef] = 1.8820720577620569 / fb_Scales.data[bcoef] /
      6.2831853071795862;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel23(const
  real_T fs, const int32_T i, emxArray_real_T f)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(i);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    f.data[bcoef] *= fs;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel24(const
  emxArray_real_T f, const int32_T b_f, emxArray_real_T freqs)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_f);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    freqs.data[bcoef] = f.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel25(const
  int32_T nx, const emxArray_real_T x, const int32_T b_x, emxArray_real_T xv,
  int32_T x_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    xv.data[bcoef] = x.data[bcoef + x_dim0 * nx];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel26(const
  int32_T nx, const emxArray_real_T x, const int32_T b, emxArray_real_T b_x,
  int32_T x_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    b_x.data[bcoef] = x.data[bcoef + x_dim0 * nx];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel27(const
  int32_T fb_SignalPad, const int32_T b, emxArray_real_T x)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    real_T tkd1mtk;
    int32_T itime;
    int32_T kk;
    kk = static_cast<int32_T>(idx);
    itime = (fb_SignalPad - kk) - 1;
    tkd1mtk = x.data[kk];
    x.data[kk] = x.data[itime];
    x.data[itime] = tkd1mtk;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel28(const
  emxArray_real_T x, const int32_T b, emxArray_real_T xv)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    xv.data[bcoef] = x.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel29(const
  emxArray_real_T xv, const int32_T b_xv, emxArray_creal_T xposdft)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_xv);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    xposdft.data[bcoef].re = xv.data[bcoef];
    xposdft.data[bcoef].im = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel3(real_T
  interval[650])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    interval[0] = 0.0;
    interval[1] = 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel30(const
  emxArray_creal_T xposdft, const emxArray_real_T daughter, const int32_T ix,
  const int32_T cfsposdft, const int32_T nrefine, emxArray_creal_T b_cfsposdft,
  int32_T daughter_dim0, int32_T cfsposdft_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(nrefine) + 1UL) * (static_cast<uint64_T>
    (cfsposdft) + 1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    int32_T icounter;
    int32_T itime;
    int32_T k;
    icounter = static_cast<int32_T>(idx % (static_cast<uint64_T>(cfsposdft) +
      1UL));
    k = static_cast<int32_T>((idx - static_cast<uint64_T>(icounter)) / (
      static_cast<uint64_T>(cfsposdft) + 1UL));
    itime = ix * k + 1;
    bcoef = static_cast<int32_T>(daughter_dim0 != 1);
    b_cfsposdft.data[icounter + cfsposdft_dim0 * k].re = daughter.data[bcoef *
      icounter + daughter_dim0 * (itime - 1)] * xposdft.data[k].re;
    b_cfsposdft.data[icounter + cfsposdft_dim0 * k].im = daughter.data[bcoef *
      icounter + daughter_dim0 * (itime - 1)] * xposdft.data[k].im;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel31(const
  int32_T xSize, emxArray_creal_T cfspos)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(xSize);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    cfspos.data[bcoef].re = 0.0;
    cfspos.data[bcoef].im = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel32(const
  emxArray_creal_T cfspos, const int32_T b, emxArray_real_T y)
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
    y.data[k] = hypot(cfspos.data[k].re, cfspos.data[k].im);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel33(const
  emxArray_real_T y, const int32_T b, emxArray_real_T abscfssq)
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
    abscfssq.data[k] = y.data[k] * y.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel34(const
  emxArray_real_T abscfssq, const int32_T b_abscfssq, emxArray_real_T a)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_abscfssq);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    a.data[bcoef] = abscfssq.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel35(const
  emxArray_real_T fb_Scales, const emxArray_real_T a, const int32_T lidx, const
  int32_T abscfssq, const int32_T nrefine, emxArray_real_T b_abscfssq, int32_T
  a_dim0, int32_T fb_Scales_dim1, int32_T abscfssq_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(nrefine) + 1UL) * (static_cast<uint64_T>
    (abscfssq) + 1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T icounter;
    int32_T k;
    icounter = static_cast<int32_T>(idx % (static_cast<uint64_T>(abscfssq) + 1UL));
    k = static_cast<int32_T>((idx - static_cast<uint64_T>(icounter)) / (
      static_cast<uint64_T>(abscfssq) + 1UL));
    b_abscfssq.data[icounter + abscfssq_dim0 * k] = a.data[static_cast<int32_T>
      (a_dim0 != 1) * icounter + a_dim0 * (lidx * k)] / fb_Scales.data[
      static_cast<int32_T>(fb_Scales_dim1 != 1) * icounter];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel36(const
  int32_T abscfssq, emxArray_real_T z)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(abscfssq);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    z.data[bcoef] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel37(const
  emxArray_uint32_T y, const int32_T b, emxArray_real_T c)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    c.data[bcoef] = static_cast<real_T>(y.data[0]);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel38(const
  emxArray_uint32_T y, emxArray_real_T c, int32_T abscfssq_dim1)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    real_T r;
    r = 0.5 * static_cast<real_T>(y.data[0]);
    c.data[0] = r;
    c.data[abscfssq_dim1 - 1] = r;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel39(const
  real_T a, const int32_T b, emxArray_creal_T cfspos)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    cfspos.data[bcoef].re *= a;
    cfspos.data[bcoef].im *= a;
  }
}

static __global__ __launch_bounds__(128, 1) void ec_cwtAvg_kernel4(real_T
  interval[650])
{
  int32_T k;
  k = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (k < 648) {
    interval[k + 2] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel40(const
  emxArray_creal_T cfspos, const int32_T b, emxArray_real_T y)
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
    y.data[k] = hypot(cfspos.data[k].re, cfspos.data[k].im);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel41(const
  emxArray_real_T y, const int32_T b, emxArray_real_T abswt2)
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
    abswt2.data[k] = y.data[k] * y.data[k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel42(const
  emxArray_real_T fb_Scales, const emxArray_real_T abswt2, const int32_T
  b_abswt2, const int32_T c_abswt2, emxArray_real_T abswt2S, int32_T
  abswt2S_dim0, int32_T abswt2_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c_abswt2) + 1UL) * (static_cast<uint64_T>
    (b_abswt2) + 1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    int32_T kk;
    kk = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_abswt2) + 1UL));
    bcoef = static_cast<int32_T>((idx - static_cast<uint64_T>(kk)) / (
      static_cast<uint64_T>(b_abswt2) + 1UL));
    abswt2S.data[kk + abswt2S_dim0 * bcoef] = abswt2.data[kk + abswt2_dim0 *
      bcoef] / fb_Scales.data[kk];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel43(const
  emxArray_real_T abswt2S, const int32_T b, const int32_T b_abswt2S,
  emxArray_real_T y, int32_T y_dim0, int32_T abswt2S_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(b_abswt2S) + 1UL) * (static_cast<uint64_T>(b)
    + 1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    int32_T kk;
    kk = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    bcoef = static_cast<int32_T>((idx - static_cast<uint64_T>(kk)) / (
      static_cast<uint64_T>(b) + 1UL));
    y.data[kk + y_dim0 * bcoef] = abswt2S.data[kk + abswt2S_dim0 * bcoef];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel44(const
  emxArray_real_T fb_Scales, real_T *r)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    *r = fb_Scales.data[0] * 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel45(const real_T *
  r, emxArray_real_T savgpTMP)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    savgpTMP.data[0] = *r;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel46(const
  emxArray_real_T savgpTMP, const int32_T b_savgpTMP, emxArray_real_T xCh)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_savgpTMP);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    xCh.data[bcoef] = savgpTMP.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel47(const
  int32_T b, emxArray_real_T dv22)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    dv22.data[bcoef] = 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel48(const
  emxArray_real_T dv22, const emxArray_real_T h, const int32_T b_h,
  emxArray_real_T h1)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_h);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    h1.data[bcoef] = h.data[bcoef] * dv22.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel49(const
  real_T r, const emxArray_real_T h1, const real_T q_ok, const int32_T b_h1,
  emxArray_real_T opts_filter)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_h1);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    opts_filter.data[bcoef] = q_ok * h1.data[bcoef] / r;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel5(const int32_T
  nrefine, real_T interval[650])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    interval[1] = interval[nrefine];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel50(const
  int32_T delta, emxArray_real_T h)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(delta);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    h.data[bcoef] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel51(const
  emxArray_uint32_T y, const real_T delta, const int32_T b_y, emxArray_int32_T
  iv9)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    iv9.data[bcoef] = static_cast<int32_T>(delta + static_cast<real_T>
      (y.data[bcoef]));
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel52(const
  emxArray_real_T opts_filter, const emxArray_int32_T iv9, const int32_T b_iv9,
  emxArray_real_T h)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_iv9);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    h.data[iv9.data[bcoef] - 1] = opts_filter.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel53(const
  int32_T xCh, emxArray_real_T yCol)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(xCh);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    yCol.data[bcoef] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel54(const
  emxArray_real_T xCh, const int32_T lidx, const int32_T omega_tmp2,
  emxArray_real_T yCol)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(omega_tmp2);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    yCol.data[lidx * bcoef] = xCh.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel55(const
  emxArray_real_T yCol, const int32_T origSiz, emxArray_real_T x)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(origSiz);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    x.data[bcoef] = yCol.data[bcoef];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel56(const
  emxArray_real_T h, const emxArray_real_T yCol, emxArray_real_T w)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    w.data[0] = yCol.data[0] * h.data[0];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel57(const
  int32_T ix, const int32_T b, int32_T lshift[2])
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T kk;
    kk = lshift[0];
    lshift[0] = lshift[1 - ix];
    lshift[1 - ix] = kk;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel58(const int32_T
  ix, const int32_T lidx, const int32_T nG, int32_T csz[2])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    csz[nG - 1] = div_s32_device(lidx, ix) + 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel59(const
  emxArray_real_T w, const int32_T xt_size_dim0, const int32_T ix, const int32_T
  b, const int32_T c, emxArray_real_T b_w, int32_T w_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c) + 1UL) * (static_cast<uint64_T>(b) + 1UL)
    - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    int32_T kk;
    kk = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    bcoef = static_cast<int32_T>((idx - static_cast<uint64_T>(kk)) / (
      static_cast<uint64_T>(b) + 1UL));
    b_w.data[kk + w_dim0 * bcoef] = w.data[ix * kk + xt_size_dim0 * bcoef];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel6(real_T
  interval[650])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    interval[0] = 0.0;
    interval[1] = 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel60(const
  emxArray_real_T w, const int32_T xt_size, emxArray_real_T y)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(xt_size);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    y.data[bcoef] = w.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel61(const
  emxArray_real_T w, const int32_T xt_size_dim0, const int32_T ix, const int32_T
  b, const int32_T c, emxArray_real_T b_w, int32_T w_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c) + 1UL) * (static_cast<uint64_T>(b) + 1UL)
    - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    int32_T kk;
    kk = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    bcoef = static_cast<int32_T>((idx - static_cast<uint64_T>(kk)) / (
      static_cast<uint64_T>(b) + 1UL));
    b_w.data[kk + w_dim0 * bcoef] = w.data[ix * kk + xt_size_dim0 * bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel62(const
  emxArray_real_T w, const int32_T xt_size_dim0, const int32_T b, const int32_T
  c, emxArray_real_T y, int32_T y_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c) + 1UL) * (static_cast<uint64_T>(b) + 1UL)
    - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    int32_T kk;
    kk = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    bcoef = static_cast<int32_T>((idx - static_cast<uint64_T>(kk)) / (
      static_cast<uint64_T>(b) + 1UL));
    y.data[kk + y_dim0 * bcoef] = w.data[kk + xt_size_dim0 * bcoef];
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel63
  (emxArray_real_T y)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    y.data[0] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel64(const
  emxArray_real_T y, const emxArray_real_T b_y, const real_T intDsq, const
  int32_T b, emxArray_real_T xCh)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    xCh.data[bcoef] = y.data[static_cast<int32_T>(intDsq + b_y.data[bcoef]) - 1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel65(const
  int32_T b, emxArray_real_T y)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    y.data[bcoef] = static_cast<real_T>(bcoef) + 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel66(const
  int32_T b, emxArray_real_T w)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    w.data[bcoef] = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel67(const
  emxArray_real_T yCol, const emxArray_real_T h, emxArray_real_T w)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    real_T fc;
    fc = h.data[0] * yCol.data[0];
    w.data[0] = fc;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel68(const
  int32_T nG, emxArray_real_T expanded)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nG);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    expanded.data[bcoef] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel69(const
  int32_T lidx, const emxArray_int32_T y, const int32_T b_y, emxArray_int32_T
  iv14)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    int32_T icounter;
    bcoef = static_cast<int32_T>(idx);
    icounter = y.data[bcoef];
    if ((lidx < 0) && (icounter < MIN_int32_T - lidx)) {
      icounter = MIN_int32_T;
    } else if ((lidx > 0) && (icounter > MAX_int32_T - lidx)) {
      icounter = MAX_int32_T;
    } else {
      icounter += lidx;
    }

    iv14.data[bcoef] = icounter - 1;
  }
}

static __global__ __launch_bounds__(128, 1) void ec_cwtAvg_kernel7(real_T
  interval[650])
{
  int32_T k;
  k = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (k < 648) {
    interval[k + 2] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel70(const
  emxArray_real_T h, const emxArray_int32_T iv14, const int32_T omega_tmp2,
  emxArray_real_T expanded)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(omega_tmp2);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    expanded.data[iv14.data[bcoef]] = h.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel71(const
  emxArray_real_T yCol, const emxArray_real_T expanded, const emxArray_int32_T
  rows, const int32_T origSiz_dim0, const int32_T b, emxArray_real_T w)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    real_T tkd1mtk;
    int32_T itime;
    itime = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    tkd1mtk = 0.0;
    for (int32_T bcoef{0}; bcoef < origSiz_dim0; bcoef++) {
      int32_T icounter;
      icounter = rows.data[bcoef];
      if ((itime + 1 < 0) && (icounter < MAX_int32_T - itime)) {
        icounter = MIN_int32_T;
      } else if ((itime + 1 > 0) && (icounter > 2147483646 - itime)) {
        icounter = MAX_int32_T;
      } else {
        icounter = (itime + icounter) + 1;
      }

      tkd1mtk += expanded.data[icounter - 1] * yCol.data[(origSiz_dim0 - bcoef)
        - 1];
    }

    w.data[itime] = tkd1mtk;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel72(const
  int32_T b, emxArray_real_T w)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    w.data[bcoef] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel73(const
  emxArray_real_T c, const int32_T b, emxArray_real_T w)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    w.data[bcoef] = c.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel74(const
  int32_T nG, emxArray_real_T expanded)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(nG);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    expanded.data[bcoef] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel75(const
  int32_T lidx, const emxArray_int32_T y, const int32_T b_y, emxArray_int32_T
  iv15)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    int32_T icounter;
    bcoef = static_cast<int32_T>(idx);
    icounter = y.data[bcoef];
    if ((lidx < 0) && (icounter < MIN_int32_T - lidx)) {
      icounter = MIN_int32_T;
    } else if ((lidx > 0) && (icounter > MAX_int32_T - lidx)) {
      icounter = MAX_int32_T;
    } else {
      icounter += lidx;
    }

    iv15.data[bcoef] = icounter - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel76(const
  emxArray_real_T yCol, const emxArray_int32_T iv15, const int32_T xt_size,
  emxArray_real_T expanded)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(xt_size);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    expanded.data[iv15.data[bcoef]] = yCol.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel77(const
  emxArray_real_T expanded, const emxArray_int32_T rows, const emxArray_real_T h,
  const int32_T b, emxArray_real_T w, int32_T h_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    real_T tkd1mtk;
    int32_T itime;
    itime = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    tkd1mtk = 0.0;
    for (int32_T bcoef{0}; bcoef < h_dim0; bcoef++) {
      int32_T icounter;
      icounter = rows.data[bcoef];
      if (icounter > 2147483646 - itime) {
        icounter = MAX_int32_T;
      } else {
        icounter = (itime + icounter) + 1;
      }

      tkd1mtk += expanded.data[icounter - 1] * h.data[(h_dim0 - bcoef) - 1];
    }

    w.data[itime] = tkd1mtk;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel78(const
  int32_T b, emxArray_uint32_T y)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    y.data[bcoef] = static_cast<uint32_T>(bcoef) + 1U;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel79(const
  creal_T *dc6, const real_T table100[100], const creal_T dc7, const creal_T
  *dc1, const int32_T ix, const int32_T lidx, const int32_T nrefine, const
  int32_T i, const int64_T b, emxArray_real_T dv22, real_T q1_dim0, real_T
  q1_dim1, real_T q1_dim2, real_T q1_dim3, real_T q1_dim4, real_T q1_dim5,
  real_T q1_dim6, real_T q1_dim7, real_T p1_dim0, real_T p1_dim1, real_T p1_dim2,
  real_T p1_dim3, real_T p1_dim4, real_T p1_dim5, real_T p1_dim6, real_T p1_dim7,
  real_T q2_dim0, real_T q2_dim1, real_T q2_dim2, real_T q2_dim3, real_T q2_dim4,
  real_T q2_dim5, real_T q2_dim6, real_T q2_dim7, real_T p2_dim0, real_T p2_dim1,
  real_T p2_dim2, real_T p2_dim3, real_T p2_dim4, real_T p2_dim5, real_T p2_dim6,
  real_T p2_dim7, real_T q4_dim0, real_T q4_dim1, real_T q4_dim2, real_T q4_dim3,
  real_T q4_dim4, real_T q4_dim5, real_T q4_dim6, real_T q4_dim7, real_T p4_dim0,
  real_T p4_dim1, real_T p4_dim2, real_T p4_dim3, real_T p4_dim4, real_T p4_dim5,
  real_T p4_dim6, real_T p4_dim7, real_T c_dim0, real_T c_dim1, real_T c_dim2,
  real_T c_dim3, real_T c_dim4, real_T c_dim5, real_T c_dim6)
{
  __shared__ real_T p1_shared[8];
  __shared__ real_T p2_shared[8];
  __shared__ real_T p4_shared[8];
  __shared__ real_T q1_shared[8];
  __shared__ real_T q2_shared[8];
  __shared__ real_T q4_shared[8];
  __shared__ real_T c_shared[7];
  creal_T z;
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  int32_T itime;
  if (mwGetThreadIndexWithinBlock() == 0U) {
    p1_shared[0] = p1_dim0;
    p1_shared[1] = p1_dim1;
    p1_shared[2] = p1_dim2;
    p1_shared[3] = p1_dim3;
    p1_shared[4] = p1_dim4;
    p1_shared[5] = p1_dim5;
    p1_shared[6] = p1_dim6;
    p1_shared[7] = p1_dim7;
    q1_shared[0] = q1_dim0;
    q1_shared[1] = q1_dim1;
    q1_shared[2] = q1_dim2;
    q1_shared[3] = q1_dim3;
    q1_shared[4] = q1_dim4;
    q1_shared[5] = q1_dim5;
    q1_shared[6] = q1_dim6;
    q1_shared[7] = q1_dim7;
    p2_shared[0] = p2_dim0;
    p2_shared[1] = p2_dim1;
    p2_shared[2] = p2_dim2;
    p2_shared[3] = p2_dim3;
    p2_shared[4] = p2_dim4;
    p2_shared[5] = p2_dim5;
    p2_shared[6] = p2_dim6;
    p2_shared[7] = p2_dim7;
    q2_shared[0] = q2_dim0;
    q2_shared[1] = q2_dim1;
    q2_shared[2] = q2_dim2;
    q2_shared[3] = q2_dim3;
    q2_shared[4] = q2_dim4;
    q2_shared[5] = q2_dim5;
    q2_shared[6] = q2_dim6;
    q2_shared[7] = q2_dim7;
    p4_shared[0] = p4_dim0;
    p4_shared[1] = p4_dim1;
    p4_shared[2] = p4_dim2;
    p4_shared[3] = p4_dim3;
    p4_shared[4] = p4_dim4;
    p4_shared[5] = p4_dim5;
    p4_shared[6] = p4_dim6;
    p4_shared[7] = p4_dim7;
    q4_shared[0] = q4_dim0;
    q4_shared[1] = q4_dim1;
    q4_shared[2] = q4_dim2;
    q4_shared[3] = q4_dim3;
    q4_shared[4] = q4_dim4;
    q4_shared[5] = q4_dim5;
    q4_shared[6] = q4_dim6;
    q4_shared[7] = q4_dim7;
    c_shared[0] = c_dim0;
    c_shared[1] = c_dim1;
    c_shared[2] = c_dim2;
    c_shared[3] = c_dim3;
    c_shared[4] = c_dim4;
    c_shared[5] = c_dim5;
    c_shared[6] = c_dim6;
  }

  __syncthreads();
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    creal_T tmp;
    creal_T zd;
    int64_T k;
    real_T sgn;
    k = static_cast<int64_T>(idx);
    sgn = static_cast<real_T>(nrefine + (((static_cast<int32_T>
      (static_cast<int64_T>(i) + k) - lidx) - 1) << 1)) / (static_cast<real_T>
      (ix) - 1.0);
    zd.re = 5.0 * sqrt((1.0 - sgn) * (sgn + 1.0));
    if (isnan(zd.re)) {
      tmp = *dc1;
    } else {
      creal_T dk;
      creal_T pt;
      creal_T s;
      real_T aa;
      real_T ak;
      real_T az;
      real_T b_atol;
      real_T fkk;
      real_T i2;
      real_T im;
      real_T re;
      real_T sqk;
      real_T tkd1mtk;
      int32_T bcoef;
      int32_T ierr;
      boolean_T guard1;
      ierr = 0;
      tkd1mtk = hypot(zd.re, 0.0);
      if (tkd1mtk > 1.0737418235E+9) {
        ierr = 4;
      } else if (tkd1mtk > 32767.999992370605) {
        ierr = 3;
      }

      tmp.re = 0.0;
      tmp.im = 0.0;
      fkk = hypot(zd.re, 0.0);
      guard1 = false;
      if (fkk <= 2.0) {
        bcoef = 0;
        az = hypot(zd.re, 0.0);
        if (az == 0.0) {
          tmp.re = 1.0;
          tmp.im = 0.0;
        } else if (az < 2.2250738585072014E-305) {
          tmp.re = 1.0;
          tmp.im = 0.0;
        } else {
          dk.re = 0.5 * zd.re;
          if (az > 4.7170688552396617E-153) {
            pt.re = dk.re * dk.re;
            i2 = hypot(pt.re, 0.0);
          } else {
            pt.re = 0.0;
            i2 = 0.0;
          }

          sgn = dk.re;
          if (log(sgn) * 0.0 > -700.92179369444591) {
            b_atol = 2.2204460492503131E-16 * i2;
            dk.re = 1.0;
            dk.im = 0.0;
            if (!static_cast<int32_T>(i2 < 2.2204460492503131E-16)) {
              s.re = 1.0;
              s.im = 0.0;
              ak = 3.0;
              sqk = 1.0;
              aa = 2.0;
              do {
                sgn = 1.0 / sqk;
                re = s.re * pt.re - s.im * 0.0;
                im = s.re * 0.0 + s.im * pt.re;
                s.re = sgn * re;
                s.im = sgn * im;
                dk.re += s.re;
                dk.im += s.im;
                sqk += ak;
                ak += 2.0;
                aa = aa * i2 * sgn;
              } while (!!static_cast<int32_T>(aa > b_atol));
            }

            tkd1mtk = dk.re - dk.im * 0.0;
            sgn = dk.re * 0.0 + dk.im;
            tmp.re = tkd1mtk - sgn * 0.0;
            tmp.im = tkd1mtk * 0.0 + sgn;
          } else {
            bcoef = 1;
            if (i2 > 0.0) {
              bcoef = -1;
            }
          }
        }

        if (bcoef < 0) {
          itime = 1;
        } else {
          itime = bcoef;
        }

        if ((1 - itime != 0) && (bcoef < 0)) {
          guard1 = true;
        }
      } else {
        guard1 = true;
      }

      if (guard1) {
        if (fkk < 21.784271729432426) {
          creal_T ck;
          creal_T cs1;
          creal_T p1;
          int32_T b_i;
          int32_T icounter;
          boolean_T errflag;
          boolean_T exitg1;
          bcoef = 0;
          az = hypot(zd.re, 0.0);
          sqk = floor(az);
          ck.re = (sqk + 1.0) / zd.re;
          dk.re = 2.0 / zd.re;
          p1.re = 0.0;
          p1.im = 0.0;
          cs1.re = 1.0;
          cs1.im = 0.0;
          sgn = ((sqk + 1.0) + 1.0) / az;
          sgn += sqrt(sgn * sgn - 1.0);
          tkd1mtk = sgn * sgn;
          i2 = (tkd1mtk + tkd1mtk) / ((tkd1mtk - 1.0) * (sgn - 1.0)) /
            2.2204460492503131E-16;
          ak = sqk + 1.0;
          errflag = true;
          icounter = 0;
          b_i = 1;
          exitg1 = false;
          while ((static_cast<boolean_T>(!static_cast<int32_T>(exitg1))) && (b_i
                  < 81)) {
            icounter++;
            pt = cs1;
            tkd1mtk = ck.re * cs1.re - 0.0 * cs1.im;
            sgn = ck.re * cs1.im + 0.0 * cs1.re;
            cs1.re = p1.re - tkd1mtk;
            cs1.im = p1.im - sgn;
            p1 = pt;
            ck.re += dk.re;
            if (hypot(cs1.re, cs1.im) > i2 * ak * ak) {
              errflag = false;
              exitg1 = true;
            } else {
              ak++;
              b_i++;
            }
          }

          if (errflag) {
            bcoef = -2;
          } else {
            int32_T kk;
            boolean_T guard2;
            icounter++;
            kk = 0;
            guard2 = false;
            if (static_cast<int32_T>(sqk) <= 0) {
              p1.re = 0.0;
              p1.im = 0.0;
              cs1.re = 1.0;
              cs1.im = 0.0;
              ck.re = 1.0 / zd.re;
              i2 = sqrt(1.0 / az / 2.2204460492503131E-16);
              itime = 1;
              errflag = true;
              b_i = 1;
              exitg1 = false;
              while ((static_cast<boolean_T>(!static_cast<int32_T>(exitg1))) &&
                     (b_i < 81)) {
                kk++;
                pt = cs1;
                tkd1mtk = ck.re * cs1.re - 0.0 * cs1.im;
                sgn = ck.re * cs1.im + 0.0 * cs1.re;
                cs1.re = p1.re - tkd1mtk;
                cs1.im = p1.im - sgn;
                p1 = pt;
                ck.re += dk.re;
                tkd1mtk = hypot(cs1.re, cs1.im);
                if (tkd1mtk >= i2 * ak * ak) {
                  if (itime == 2) {
                    errflag = false;
                    exitg1 = true;
                  } else {
                    sgn = hypot(ck.re, 0.0);
                    sgn = fmin(sgn + sqrt(sgn * sgn - 1.0), tkd1mtk / hypot
                               (pt.re, pt.im));
                    i2 *= sqrt(sgn / (sgn * sgn - 1.0));
                    itime = 2;
                    b_i++;
                  }
                } else {
                  b_i++;
                }
              }

              if (errflag) {
                bcoef = -2;
              } else {
                guard2 = true;
              }
            } else {
              guard2 = true;
            }

            if (guard2) {
              itime = icounter + static_cast<int32_T>(sqk);
              kk++;
              if (itime >= kk) {
                kk = itime;
              }

              fkk = static_cast<real_T>(kk);
              p1.re = 0.0;
              p1.im = 0.0;
              cs1 = dc7;
              az = static_cast<real_T>(kk) + 1.0;
              if (!static_cast<int32_T>(static_cast<real_T>(kk) + 1.0 < 0.0)) {
                if (static_cast<real_T>(kk) + 1.0 <= 2.2204460492503131E-16) {
                  az = -log(static_cast<real_T>(kk) + 1.0);
                } else if (static_cast<real_T>(kk) + 1.0 <= 0.5) {
                  tkd1mtk = 1.0;
                  sgn = 0.0;
                  for (b_i = 0; b_i < 8; b_i++) {
                    sgn = sgn * (static_cast<real_T>(kk) + 1.0) + p1_shared[b_i];
                    tkd1mtk = tkd1mtk * (static_cast<real_T>(kk) + 1.0) +
                      q1_shared[b_i];
                  }

                  az = -log(static_cast<real_T>(kk) + 1.0) + (static_cast<real_T>
                    (kk) + 1.0) * ((static_cast<real_T>(kk) + 1.0) * (sgn /
                    tkd1mtk) - 0.57721566490153287);
                } else if (static_cast<real_T>(kk) + 1.0 <= 0.6796875) {
                  tkd1mtk = 1.0;
                  sgn = 0.0;
                  for (b_i = 0; b_i < 8; b_i++) {
                    sgn = sgn * (((static_cast<real_T>(kk) + 1.0) - 0.5) - 0.5)
                      + p2_shared[b_i];
                    tkd1mtk = tkd1mtk * (((static_cast<real_T>(kk) + 1.0) - 0.5)
                                         - 0.5) + q2_shared[b_i];
                  }

                  az = -log(static_cast<real_T>(kk) + 1.0) +
                    (((static_cast<real_T>(kk) + 1.0) - 0.5) - 0.5) * ((((
                    static_cast<real_T>(kk) + 1.0) - 0.5) - 0.5) * (sgn /
                    tkd1mtk) + 0.42278433509846713);
                } else if (static_cast<real_T>(kk) + 1.0 <= 100.0) {
                  az = table100[kk];
                } else if (static_cast<real_T>(kk) + 1.0 <= 1.5) {
                  tkd1mtk = 1.0;
                  sgn = 0.0;
                  for (b_i = 0; b_i < 8; b_i++) {
                    sgn = sgn * (((static_cast<real_T>(kk) + 1.0) - 0.5) - 0.5)
                      + p1_shared[b_i];
                    tkd1mtk = tkd1mtk * (((static_cast<real_T>(kk) + 1.0) - 0.5)
                                         - 0.5) + q1_shared[b_i];
                  }

                  az = (((static_cast<real_T>(kk) + 1.0) - 0.5) - 0.5) * ((((
                    static_cast<real_T>(kk) + 1.0) - 0.5) - 0.5) * (sgn /
                    tkd1mtk) - 0.57721566490153287);
                } else if (static_cast<real_T>(kk) + 1.0 <= 4.0) {
                  tkd1mtk = 1.0;
                  sgn = 0.0;
                  for (b_i = 0; b_i < 8; b_i++) {
                    sgn = sgn * ((static_cast<real_T>(kk) + 1.0) - 2.0) +
                      p2_shared[b_i];
                    tkd1mtk = tkd1mtk * ((static_cast<real_T>(kk) + 1.0) - 2.0)
                      + q2_shared[b_i];
                  }

                  az = ((static_cast<real_T>(kk) + 1.0) - 2.0) * (((static_cast<
                    real_T>(kk) + 1.0) - 2.0) * (sgn / tkd1mtk) +
                    0.42278433509846713);
                } else if (static_cast<real_T>(kk) + 1.0 <= 12.0) {
                  tkd1mtk = -1.0;
                  sgn = 0.0;
                  for (b_i = 0; b_i < 8; b_i++) {
                    sgn = sgn * ((static_cast<real_T>(kk) + 1.0) - 4.0) +
                      p4_shared[b_i];
                    tkd1mtk = tkd1mtk * ((static_cast<real_T>(kk) + 1.0) - 4.0)
                      + q4_shared[b_i];
                  }

                  az = ((static_cast<real_T>(kk) + 1.0) - 4.0) * (sgn / tkd1mtk)
                    + 1.791759469228055;
                } else {
                  sgn = 0.0057083835261;
                  tkd1mtk = 1.0 / ((static_cast<real_T>(kk) + 1.0) * (
                    static_cast<real_T>(kk) + 1.0));
                  for (b_i = 0; b_i < 6; b_i++) {
                    sgn = sgn * tkd1mtk + c_shared[b_i];
                  }

                  sgn /= static_cast<real_T>(kk) + 1.0;
                  tkd1mtk = log(static_cast<real_T>(kk) + 1.0);
                  az = ((sgn + 0.91893853320467278) - 0.5 * tkd1mtk) + (
                    static_cast<real_T>(kk) + 1.0) * (tkd1mtk - 1.0);
                }
              }

              tkd1mtk = static_cast<real_T>(kk) + 1.0;
              if (!static_cast<int32_T>(static_cast<real_T>(kk) + 1.0 < 0.0)) {
                if (static_cast<real_T>(kk) + 1.0 <= 2.2204460492503131E-16) {
                  tkd1mtk = -log(static_cast<real_T>(kk) + 1.0);
                } else if (static_cast<real_T>(kk) + 1.0 <= 0.5) {
                  tkd1mtk = 1.0;
                  sgn = 0.0;
                  for (b_i = 0; b_i < 8; b_i++) {
                    sgn = sgn * (static_cast<real_T>(kk) + 1.0) + p1_shared[b_i];
                    tkd1mtk = tkd1mtk * (static_cast<real_T>(kk) + 1.0) +
                      q1_shared[b_i];
                  }

                  tkd1mtk = -log(static_cast<real_T>(kk) + 1.0) +
                    (static_cast<real_T>(kk) + 1.0) * ((static_cast<real_T>(kk)
                    + 1.0) * (sgn / tkd1mtk) - 0.57721566490153287);
                } else if (static_cast<real_T>(kk) + 1.0 <= 0.6796875) {
                  tkd1mtk = 1.0;
                  sgn = 0.0;
                  for (b_i = 0; b_i < 8; b_i++) {
                    sgn = sgn * (((static_cast<real_T>(kk) + 1.0) - 0.5) - 0.5)
                      + p2_shared[b_i];
                    tkd1mtk = tkd1mtk * (((static_cast<real_T>(kk) + 1.0) - 0.5)
                                         - 0.5) + q2_shared[b_i];
                  }

                  tkd1mtk = -log(static_cast<real_T>(kk) + 1.0) + (((
                    static_cast<real_T>(kk) + 1.0) - 0.5) - 0.5) * ((((
                    static_cast<real_T>(kk) + 1.0) - 0.5) - 0.5) * (sgn /
                    tkd1mtk) + 0.42278433509846713);
                } else if (static_cast<real_T>(kk) + 1.0 <= 100.0) {
                  tkd1mtk = table100[kk];
                } else if (static_cast<real_T>(kk) + 1.0 <= 1.5) {
                  tkd1mtk = 1.0;
                  sgn = 0.0;
                  for (b_i = 0; b_i < 8; b_i++) {
                    sgn = sgn * (((static_cast<real_T>(kk) + 1.0) - 0.5) - 0.5)
                      + p1_shared[b_i];
                    tkd1mtk = tkd1mtk * (((static_cast<real_T>(kk) + 1.0) - 0.5)
                                         - 0.5) + q1_shared[b_i];
                  }

                  tkd1mtk = (((static_cast<real_T>(kk) + 1.0) - 0.5) - 0.5) *
                    ((((static_cast<real_T>(kk) + 1.0) - 0.5) - 0.5) * (sgn /
                      tkd1mtk) - 0.57721566490153287);
                } else if (static_cast<real_T>(kk) + 1.0 <= 4.0) {
                  tkd1mtk = 1.0;
                  sgn = 0.0;
                  for (b_i = 0; b_i < 8; b_i++) {
                    sgn = sgn * ((static_cast<real_T>(kk) + 1.0) - 2.0) +
                      p2_shared[b_i];
                    tkd1mtk = tkd1mtk * ((static_cast<real_T>(kk) + 1.0) - 2.0)
                      + q2_shared[b_i];
                  }

                  tkd1mtk = ((static_cast<real_T>(kk) + 1.0) - 2.0) * (((
                    static_cast<real_T>(kk) + 1.0) - 2.0) * (sgn / tkd1mtk) +
                    0.42278433509846713);
                } else if (static_cast<real_T>(kk) + 1.0 <= 12.0) {
                  tkd1mtk = -1.0;
                  sgn = 0.0;
                  for (b_i = 0; b_i < 8; b_i++) {
                    sgn = sgn * ((static_cast<real_T>(kk) + 1.0) - 4.0) +
                      p4_shared[b_i];
                    tkd1mtk = tkd1mtk * ((static_cast<real_T>(kk) + 1.0) - 4.0)
                      + q4_shared[b_i];
                  }

                  tkd1mtk = ((static_cast<real_T>(kk) + 1.0) - 4.0) * (sgn /
                    tkd1mtk) + 1.791759469228055;
                } else {
                  sgn = 0.0057083835261;
                  tkd1mtk = 1.0 / ((static_cast<real_T>(kk) + 1.0) * (
                    static_cast<real_T>(kk) + 1.0));
                  for (b_i = 0; b_i < 6; b_i++) {
                    sgn = sgn * tkd1mtk + c_shared[b_i];
                  }

                  sgn /= static_cast<real_T>(kk) + 1.0;
                  tkd1mtk = log(static_cast<real_T>(kk) + 1.0);
                  tkd1mtk = ((sgn + 0.91893853320467278) - 0.5 * tkd1mtk) + (
                    static_cast<real_T>(kk) + 1.0) * (tkd1mtk - 1.0);
                }
              }

              i2 = exp(az - tkd1mtk);
              s.re = 0.0;
              s.im = 0.0;
              for (b_i = 0; b_i < kk; b_i++) {
                pt = cs1;
                tkd1mtk = fkk * dk.re;
                sgn = fkk * 0.0;
                sqk = tkd1mtk * cs1.re - sgn * cs1.im;
                sgn = tkd1mtk * cs1.im + sgn * cs1.re;
                cs1.re = p1.re + sqk;
                cs1.im = p1.im + sgn;
                p1 = pt;
                sgn = i2 * (1.0 - 0.0 / fkk);
                s.re += (sgn + i2) * pt.re;
                s.im += (sgn + i2) * pt.im;
                i2 = sgn;
                fkk--;
              }

              tmp = cs1;
              dk.re = log(dk.re);
              re = 0.0 * dk.re;
              im = 0.0 * dk.re;
              dk.re = re + zd.re;
              cs1.re += s.re;
              cs1.im += s.im;
              p1.re = 1.0 / hypot(cs1.re, cs1.im);
              if (dk.re == 0.0) {
                dk.re = cos(im);
                dk.im = sin(im);
              } else if (im == 0.0) {
                sgn = dk.re;
                dk.re = exp(sgn);
                dk.im = 0.0;
              } else {
                dk.re = CUDART_NAN;
                dk.im = CUDART_NAN;
              }

              tkd1mtk = dk.re * p1.re - dk.im * 0.0;
              sgn = dk.re * 0.0 + dk.im * p1.re;
              sqk = cs1.re * p1.re + cs1.im * 0.0;
              i2 = cs1.re * 0.0 - cs1.im * p1.re;
              dk.re = tkd1mtk * sqk - sgn * i2;
              dk.im = tkd1mtk * i2 + sgn * sqk;
              re = tmp.re * dk.re - tmp.im * dk.im;
              im = tmp.re * dk.im + tmp.im * dk.re;
              tmp.re = re;
              tmp.im = im;
            }
          }

          if (bcoef < 0) {
            if (bcoef == -2) {
              itime = -2;
            } else {
              itime = -1;
            }
          } else {
            itime = 0;
          }
        } else {
          bcoef = 0;
          sgn = sqrt(0.15915494309189535 / zd.re);
          if (zd.re > 700.92179369444591) {
            bcoef = -1;
            tmp = *dc1;
          } else {
            creal_T ck;
            creal_T cs1;
            int32_T b_i;
            boolean_T errflag;
            boolean_T exitg1;
            if (zd.re == 0.0) {
              dk.re = 1.0;
            } else {
              dk.re = exp(zd.re);
            }

            re = sgn * dk.re;
            im = sgn * 0.0;
            s.re = 8.0 * zd.re;
            s.im = 0.0;
            i2 = 8.0 * hypot(zd.re, 0.0);
            sqk = -1.0;
            b_atol = 2.2204460492503131E-16 / i2;
            sgn = 1.0;
            cs1.re = 1.0;
            cs1.im = 0.0;
            pt.re = 1.0;
            pt.im = 0.0;
            ck.re = 1.0;
            ck.im = 0.0;
            ak = 0.0;
            aa = 1.0;
            tkd1mtk = i2;
            dk = s;
            errflag = true;
            b_i = 1;
            exitg1 = false;
            while ((static_cast<boolean_T>(!static_cast<int32_T>(exitg1))) &&
                   (b_i < 46)) {
              ck.re *= sqk;
              ck.im *= sqk;
              if (ck.im == 0.0) {
                fkk = ck.re / dk.re;
                az = 0.0;
              } else if (ck.re == 0.0) {
                fkk = 0.0;
                az = CUDART_NAN;
              } else {
                fkk = ck.re / dk.re;
                az = CUDART_NAN;
              }

              ck.re = fkk;
              ck.im = az;
              pt.re += fkk;
              pt.im += az;
              sgn = -sgn;
              cs1.re += fkk * sgn;
              cs1.im += az * sgn;
              dk.re += s.re;
              aa = aa * fabs(sqk) / tkd1mtk;
              tkd1mtk += i2;
              ak += 8.0;
              sqk -= ak;
              if (aa <= b_atol) {
                errflag = false;
                exitg1 = true;
              } else {
                b_i++;
              }
            }

            if (errflag) {
              bcoef = -2;
            } else {
              if (zd.re + zd.re < 700.92179369444591) {
                dk.re = -2.0 * zd.re;
                if (dk.re == 0.0) {
                  dk.re = 1.0;
                  dk.im = -0.0;
                } else {
                  sgn = dk.re;
                  dk.re = exp(sgn);
                  dk.im = 0.0;
                }

                fkk = dk.re * pt.re - dk.im * pt.im;
                az = dk.re * pt.im + dk.im * pt.re;
                cs1.re += fkk * 0.0 - az * 0.0;
                cs1.im += fkk * 0.0 + az * 0.0;
              }

              tmp.re = cs1.re * re - cs1.im * im;
              tmp.im = cs1.re * im + cs1.im * re;
            }
          }

          if (bcoef < 0) {
            if (bcoef == -2) {
              itime = -2;
            } else {
              itime = -1;
            }
          } else {
            itime = 0;
          }
        }
      }

      guard1 = false;
      if (itime < 0) {
        if (itime == -2) {
          tmp = *dc1;
        } else {
          ierr = 2;
          guard1 = true;
        }
      } else {
        guard1 = true;
      }

      if (guard1 && (ierr == 2)) {
        tmp = *dc6;
      }

      if (zd.re > 0.0) {
        sgn = tmp.re;
        tmp.re = sgn;
        tmp.im = 0.0;
      }
    }

    if (tmp.im == 0.0) {
      z.re = tmp.re / 27.239871823604449;
      z.im = 0.0;
    } else if (tmp.re == 0.0) {
      z.re = 0.0;
      z.im = CUDART_NAN;
    } else {
      z.re = tmp.re / 27.239871823604449;
      z.im = CUDART_NAN;
    }

    dv22.data[static_cast<int32_T>(static_cast<int64_T>(i) + k) - 1] = hypot
      (z.re, z.im);
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel8(const int32_T
  nrefine, real_T interval[650])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    interval[1] = interval[nrefine];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel80(const
  int32_T b, emxArray_real_T m)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    m.data[bcoef] = static_cast<real_T>(bcoef) + 0.5;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel81(const
  emxArray_real_T m, const int32_T b_m, emxArray_real_T k)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_m);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    k.data[bcoef] = m.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel82(const
  int32_T k, emxArray_real_T G)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(k);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    G.data[bcoef] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel83(const
  int32_T k, emxArray_real_T b)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(k);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    b.data[bcoef] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel84(const
  real_T delta, const emxArray_real_T k, const int32_T b_k, emxArray_real_T dv23)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_k);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    dv23.data[bcoef] = 6.2831853071795862 * k.data[bcoef] * delta;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel85(const
  real_T delta, const emxArray_real_T k, const int32_T b, emxArray_real_T dv24,
  emxArray_real_T dv23)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b_k;
    b_k = static_cast<int32_T>(idx);
    dv23.data[b_k] = cos(dv23.data[b_k]);
    dv24.data[b_k] = 6.2831853071795862 * k.data[b_k] * delta;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel86(const
  int32_T b, emxArray_real_T dv24)
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
    dv24.data[k] = cos(dv24.data[k]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel87(const
  emxArray_real_T k, const emxArray_real_T dv24, const emxArray_real_T dv23,
  const real_T a, const int32_T b, emxArray_real_T b_b)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    b_b.data[bcoef] += a * (dv23.data[bcoef] - dv24.data[bcoef]) / (k.data[bcoef]
      * k.data[bcoef]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel88(const
  real_T delta, const emxArray_real_T k, const int32_T b_k, emxArray_real_T y)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_k);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    y.data[bcoef] = 2.0 * k.data[bcoef] * delta;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel89(const
  real_T delta, const emxArray_real_T k, const int32_T b, emxArray_real_T y,
  emxArray_real_T b_y)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b_k;
    b_k = static_cast<int32_T>(idx);
    if (fabs(b_y.data[b_k]) < 1.0020841800044864E-292) {
      b_y.data[b_k] = 1.0;
    } else {
      real_T sgn;
      sgn = 3.1415926535897931 * b_y.data[b_k];
      sgn = sin(sgn) / sgn;
      b_y.data[b_k] = sgn;
    }

    y.data[b_k] = 2.0 * k.data[b_k] * delta;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel9(const real_T
  fc, const emxArray_int32_T omega_tmp1, const int32_T b_omega_tmp1,
  emxArray_real_T omega_tmp2)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_omega_tmp1);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    omega_tmp2.data[bcoef] = static_cast<real_T>(omega_tmp1.data[bcoef]) * fc;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel90(const
  int32_T b, emxArray_real_T y)
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
    if (fabs(y.data[k]) < 1.0020841800044864E-292) {
      y.data[k] = 1.0;
    } else {
      real_T sgn;
      sgn = 3.1415926535897931 * y.data[k];
      sgn = sin(sgn) / sgn;
      y.data[k] = sgn;
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel91(const
  emxArray_real_T y, const real_T delta, const emxArray_real_T b_y, const real_T
  a, const int32_T b, emxArray_real_T b_b)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    b_b.data[bcoef] += a * b_y.data[bcoef] - delta * y.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel92(const
  real_T r, const real_T b_r, const int32_T nG, const int32_T nx, const int32_T
  b, emxArray_real_T sinc4A, emxArray_real_T sinc3A, emxArray_real_T sinc2A,
  emxArray_real_T sinc1A)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    real_T az;
    real_T i2;
    real_T sgn;
    real_T sqk;
    int32_T kk;
    uint32_T i1Map;
    kk = static_cast<int32_T>(idx);
    i1Map = (static_cast<uint32_T>(kk) + static_cast<uint32_T>(nx)) + 1U;
    i2 = (static_cast<real_T>(kk) + 1.0) - static_cast<real_T>(nG);
    sqk = b_r * static_cast<real_T>(i1Map);
    sgn = r * static_cast<real_T>(i1Map);
    az = b_r * i2;
    i2 *= r;
    if (fabs(sqk) < 1.0020841800044864E-292) {
      sinc1A.data[kk] = 1.0;
    } else {
      sqk *= 3.1415926535897931;
      sinc1A.data[kk] = sin(sqk) / sqk;
    }

    if (fabs(sgn) < 1.0020841800044864E-292) {
      sinc2A.data[kk] = 1.0;
    } else {
      sgn *= 3.1415926535897931;
      sinc2A.data[kk] = sin(sgn) / sgn;
    }

    if (fabs(az) < 1.0020841800044864E-292) {
      sinc3A.data[kk] = 1.0;
    } else {
      az *= 3.1415926535897931;
      sinc3A.data[kk] = sin(az) / az;
    }

    if (fabs(i2) < 1.0020841800044864E-292) {
      sinc4A.data[kk] = 1.0;
    } else {
      i2 *= 3.1415926535897931;
      sinc4A.data[kk] = sin(i2) / i2;
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel93(const
  emxArray_real_T sinc4A, const emxArray_real_T sinc2A, const real_T r, const
  emxArray_real_T sinc3A, const emxArray_real_T sinc1A, const real_T b_r, const
  int32_T nG, const int32_T b, const int32_T c, emxArray_real_T G, int32_T
  G_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c) + 1UL) * (static_cast<uint64_T>(b) + 1UL)
    - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    real_T tkd1mtk;
    int32_T itime;
    int32_T kk;
    uint32_T i1Map;
    itime = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    kk = static_cast<int32_T>((idx - static_cast<uint64_T>(itime)) / (
      static_cast<uint64_T>(b) + 1UL));
    i1Map = (static_cast<uint32_T>(itime) + static_cast<uint32_T>(kk)) + 1U;
    tkd1mtk = static_cast<real_T>(itime - kk) + static_cast<real_T>(nG);
    G.data[itime + G_dim0 * kk] += 0.25 * (b_r * (sinc1A.data
      [static_cast<int32_T>(i1Map) - 1] + sinc3A.data[static_cast<int32_T>
      (tkd1mtk) - 1]) - r * (sinc2A.data[static_cast<int32_T>(i1Map) - 1] +
      sinc4A.data[static_cast<int32_T>(tkd1mtk) - 1]));
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel94(const real_T
  intFsq, emxArray_real_T b0)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    b0.data[0] = intFsq;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel95(const
  emxArray_real_T b, const int32_T c, emxArray_real_T b0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    b0.data[bcoef + 1] = b.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel96(const
  emxArray_real_T b0, const int32_T b_b0, emxArray_real_T b)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_b0);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    b.data[bcoef] = b0.data[bcoef];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel97(const
  int32_T G, emxArray_real_T a)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(G);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    a.data[bcoef] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwtAvg_kernel98(const
  emxArray_real_T a, const int32_T ix, const int32_T nrefine, const int32_T
  y_size_idx_1, emxArray_real_T h)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(y_size_idx_1);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T bcoef;
    bcoef = static_cast<int32_T>(idx);
    h.data[bcoef] = a.data[nrefine + ix * bcoef] / 2.0;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_cwtAvg_kernel99(const
  emxArray_real_T a, const int32_T ix, const int32_T nrefine, const int32_T lidx,
  emxArray_real_T h)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    h.data[div_s32_device(lidx - nrefine, ix) + 1] = a.data[0];
  }
}

static void ec_cwtAvg_once()
{
  mex_InitInfAndNan();
  checkCudaError(mwCudaMalloc(&global_gpu_cv, sizeof(char_T [128])), __FILE__,
                 __LINE__);
  checkCudaError(mwCudaMalloc(&global_gpu_table100, sizeof(real_T [100])),
                 __FILE__, __LINE__);
}

static void emlrtExitTimeCleanupDtorFcn(const void *r)
{
  emlrtExitTimeCleanup(&emlrtContextGlobal);
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

static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, char_T y[23])
{
  b_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void emlrt_marshallIn(const mxArray *tmpStr, const char_T *identifier,
  emxArray_char_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  emlrt_marshallIn(emlrtAlias(tmpStr), &thisId, y);
  emlrtDestroyArray(&tmpStr);
}

static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_char_T *y)
{
  b_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static real_T emlrt_marshallIn(const mxArray *a__output_of_length_, const char_T
  *identifier)
{
  emlrtMsgIdentifier thisId;
  real_T y;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  y = emlrt_marshallIn(emlrtAlias(a__output_of_length_), &thisId);
  emlrtDestroyArray(&a__output_of_length_);
  return y;
}

static real_T emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId)
{
  real_T y;
  y = c_emlrt_marshallIn(emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static void emlrt_marshallIn(const mxArray *a__output_of_sprintf_, const char_T *
  identifier, char_T y[23])
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  emlrt_marshallIn(emlrtAlias(a__output_of_sprintf_), &thisId, y);
  emlrtDestroyArray(&a__output_of_sprintf_);
}

static void emlrt_marshallIn(const mxArray *u, const emlrtMsgIdentifier
  *parentId, emxArray_real_T *y)
{
  b_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static const mxArray *emlrt_marshallOut(const cell_wrap_0 u_data[], const
  int32_T u_size[2])
{
  const mxArray *b_y;
  const mxArray *m;
  const mxArray *y;
  real_T *pData;
  int32_T iv[2];
  int32_T n;
  y = nullptr;
  emlrtAssign(&y, emlrtCreateCellArrayR2014a(2, &u_size[0]));
  n = u_size[1];
  for (int32_T i{0}; i < n; i++) {
    int32_T b_i;
    int32_T i1;
    b_y = nullptr;
    iv[0] = u_data[i].f1->size[0];
    iv[1] = u_data[i].f1->size[1];
    m = emlrtCreateNumericArray(2, &iv[0], mxDOUBLE_CLASS, mxREAL);
    pData = emlrtMxGetPr(m);
    i1 = 0;
    b_i = 0;
    while (b_i < u_data[i].f1->size[1]) {
      int32_T loopUpperBound;
      loopUpperBound = u_data[i].f1->size[0];
      for (b_i = 0; b_i < loopUpperBound; b_i++) {
        pData[i1 + b_i] = u_data[i].f1->data[b_i];
      }

      if (u_data[i].f1->size[0] - 1 >= 0) {
        i1 += u_data[i].f1->size[0];
      }

      b_i = 1;
    }

    emlrtAssign(&b_y, m);
    emlrtSetCell(y, i, b_y);
  }

  return y;
}

static const mxArray *emlrt_marshallOut(const emxArray_real_T *u)
{
  static const int32_T iv[1]{ 0 };

  const mxArray *m;
  const mxArray *y;
  y = nullptr;
  m = emlrtCreateNumericArray(1, (const void *)&iv[0], mxDOUBLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m, &u->data[0]);
  emlrtSetDimensions((mxArray *)m, &u->size[0], 1);
  emlrtAssign(&y, m);
  return y;
}

static void emxEnsureCapacity_cell_wrap_0(cell_wrap_0 data[65534], const int32_T
  size[2], int32_T oldNumel, const emlrtRTEInfo *srcLocation)
{
  int32_T newNumel;
  if (oldNumel < 0) {
    oldNumel = 0;
  }

  newNumel = size[0] * size[1];
  if (oldNumel > newNumel) {
    emxTrim_cell_wrap_0_1x65534(data, newNumel, oldNumel);
  } else if (oldNumel < newNumel) {
    emxExpand_cell_wrap_0_1x65534(data, oldNumel, newNumel, srcLocation);
  }
}

static void emxEnsureCapacity_char_T(emxArray_char_T *emxArray, int32_T oldNumel,
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

    newData = emlrtMallocMex(static_cast<uint32_T>(i) * sizeof(char_T));
    if (newData == nullptr) {
      emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
    }

    if (emxArray->data != nullptr) {
      std::copy(emxArray->data, emxArray->data + static_cast<uint32_T>(oldNumel),
                static_cast<char_T *>(newData));
      if (emxArray->canFreeData) {
        emlrtFreeMex(emxArray->data);
      }
    }

    emxArray->data = static_cast<char_T *>(newData);
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

    newData = emlrtMallocMex(static_cast<uint32_T>(i) * sizeof(uint32_T));
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

static void emxExpand_cell_wrap_0_1x65534(cell_wrap_0 data[65534], int32_T
  fromIndex, int32_T toIndex, const emlrtRTEInfo *srcLocation)
{
  int64_T b;
  b = b_computeEndIdx(static_cast<int64_T>(fromIndex), static_cast<int64_T>
                      (toIndex - 1), 1L);
  for (int64_T i{0L}; i <= b; i++) {
    emxInitStruct_cell_wrap_0(&data[static_cast<int32_T>(fromIndex + i)],
      srcLocation, false);
  }
}

static void emxFreeStruct_cell_wrap_0(cell_wrap_0 *pStruct)
{
  emxFree_real_T(&pStruct->f1);
}

static void emxFree_cell_wrap_0_1x65534(emxArray_cell_wrap_0_1x65534 *pEmxArray)
{
  int32_T numEl;
  numEl = pEmxArray->size[0] * pEmxArray->size[1];
  for (int32_T i{0}; i < numEl; i++) {
    emxFreeStruct_cell_wrap_0(&pEmxArray->data[i]);
  }
}

static void emxFree_char_T(emxArray_char_T **pEmxArray)
{
  if (*pEmxArray != static_cast<emxArray_char_T *>(nullptr)) {
    if (((*pEmxArray)->data != static_cast<char_T *>(nullptr)) && (*pEmxArray)
        ->canFreeData) {
      emlrtFreeMex((*pEmxArray)->data);
    }

    emlrtFreeMex((*pEmxArray)->size);
    emlrtRemoveHeapReference(emlrtRootTLSGlobal, (void *)pEmxArray);
    emlrtFreeEmxArray(*pEmxArray);
    *pEmxArray = static_cast<emxArray_char_T *>(nullptr);
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

static void emxInitStruct_cell_wrap_0(cell_wrap_0 *pStruct, const emlrtRTEInfo
  *srcLocation, boolean_T doPush)
{
  emxInit_real_T(&pStruct->f1, 2, srcLocation, doPush);
}

static void emxInit_cell_wrap_0_1x65534(emxArray_cell_wrap_0_1x65534 *pEmxArray)
{
  pEmxArray->size[0] = 0;
  pEmxArray->size[1] = 0;
}

static void emxInit_char_T(emxArray_char_T **pEmxArray, int32_T numDimensions,
  const emlrtRTEInfo *srcLocation, boolean_T doPush)
{
  emxArray_char_T *emxArray;
  *pEmxArray = static_cast<emxArray_char_T *>(emlrtMallocEmxArray(sizeof
    (emxArray_char_T)));
  if ((void *)*pEmxArray == nullptr) {
    emlrtHeapAllocationErrorR2012b(srcLocation, emlrtRootTLSGlobal);
  }

  if (doPush) {
    emlrtPushHeapReferenceStackEmxArray(emlrtRootTLSGlobal, false, (void *)
      pEmxArray, (void *)&emxFree_char_T, nullptr, nullptr, nullptr);
  }

  emxArray = *pEmxArray;
  emxArray->data = static_cast<char_T *>(nullptr);
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

static void emxTrim_cell_wrap_0_1x65534(cell_wrap_0 data[65534], int32_T
  fromIndex, int32_T toIndex)
{
  int64_T b;
  b = b_computeEndIdx(static_cast<int64_T>(fromIndex), static_cast<int64_T>
                      (toIndex - 1), 1L);
  for (int64_T i{0L}; i <= b; i++) {
    emxFreeStruct_cell_wrap_0(&data[static_cast<int32_T>(fromIndex + i)]);
  }
}

static const mxArray *feval(const mxArray *m1, const mxArray *m2, const mxArray *
  m3, emlrtMCInfo *location)
{
  const mxArray *pArrays[3];
  const mxArray *m;
  pArrays[0] = m1;
  pArrays[1] = m2;
  pArrays[2] = m3;
  return emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 1, &m, 3, &pArrays[0],
    "feval", true, location);
}

static const mxArray *feval(const mxArray *m1, const mxArray *m2, emlrtMCInfo
  *location)
{
  const mxArray *pArrays[2];
  const mxArray *m;
  pArrays[0] = m1;
  pArrays[1] = m2;
  return emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 1, &m, 2, &pArrays[0],
    "feval", true, location);
}

static void gpuEmxEnsureCapacity_creal_T(const emxArray_creal_T *cpu,
  emxArray_creal_T *gpu, boolean_T needsCopy)
{
  creal_T *newData;
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
      (creal_T)), __FILE__, __LINE__);
    needsCopy = (needsCopy && gpu->canFreeData);
    if (needsCopy) {
      checkCudaError(cudaMemcpy(newData, gpu->data, static_cast<uint32_T>
        (totalSizeGpu) * sizeof(creal_T), cudaMemcpyDeviceToDevice), __FILE__,
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

static void gpuEmxEnsureCapacity_uint32_T(const emxArray_uint32_T *cpu,
  emxArray_uint32_T *gpu, boolean_T needsCopy)
{
  int32_T i;
  int32_T totalSizeCpu;
  int32_T totalSizeGpu;
  uint32_T *newData;
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
      (uint32_T)), __FILE__, __LINE__);
    needsCopy = (needsCopy && gpu->canFreeData);
    if (needsCopy) {
      checkCudaError(cudaMemcpy(newData, gpu->data, static_cast<uint32_T>
        (totalSizeGpu) * sizeof(uint32_T), cudaMemcpyDeviceToDevice), __FILE__,
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

static void gpuEmxFree_creal_T(emxArray_creal_T *gpu)
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

static void gpuEmxFree_real_T(emxArray_real_T *gpu)
{
  if (gpu->data != (void *)4207599121UL) {
    checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
  }

  emlrtFreeMex(gpu->size);
}

static void gpuEmxFree_uint32_T(emxArray_uint32_T *gpu)
{
  if (gpu->data != (void *)4207599121UL) {
    checkCudaError(mwCudaFree(gpu->data), __FILE__, __LINE__);
  }

  emlrtFreeMex(gpu->size);
}

static void gpuEmxMemcpyCpuToGpu_creal_T(emxArray_creal_T *gpu, const
  emxArray_creal_T *cpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }

  checkCudaError(cudaMemcpy(gpu->data, cpu->data, static_cast<uint32_T>
    (actualSize) * sizeof(creal_T), cudaMemcpyHostToDevice), __FILE__, __LINE__);
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

static void gpuEmxMemcpyCpuToGpu_real_T(emxArray_real_T *gpu, const
  emxArray_real_T *cpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }

  checkCudaError(cudaMemcpy(gpu->data, cpu->data, static_cast<uint32_T>
    (actualSize) * sizeof(real_T), cudaMemcpyHostToDevice), __FILE__, __LINE__);
}

static void gpuEmxMemcpyGpuToCpu_creal_T(emxArray_creal_T *cpu, emxArray_creal_T
  *gpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }

  checkCudaError(cudaMemcpy(cpu->data, gpu->data, static_cast<uint32_T>
    (actualSize) * sizeof(creal_T), cudaMemcpyDeviceToHost), __FILE__, __LINE__);
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

static void gpuEmxMemcpyGpuToCpu_real_T(emxArray_real_T *cpu, emxArray_real_T
  *gpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }

  checkCudaError(cudaMemcpy(cpu->data, gpu->data, static_cast<uint32_T>
    (actualSize) * sizeof(real_T), cudaMemcpyDeviceToHost), __FILE__, __LINE__);
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

static void gpuEmxReset_uint32_T(emxArray_uint32_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_uint32_T));
}

static const mxArray *length(const mxArray *m1, emlrtMCInfo *location)
{
  const mxArray *m;
  const mxArray *pArray;
  pArray = m1;
  return emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 1, &m, 1, &pArray, "length",
    true, location);
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

static real_T rt_powd_snf(real_T u0, real_T u1)
{
  real_T y;
  if (std::isnan(u0) || std::isnan(u1)) {
    y = rtNaN;
  } else {
    real_T b;
    real_T c;
    b = std::abs(u0);
    c = std::abs(u1);
    if (std::isinf(u1)) {
      if (b == 1.0) {
        y = 1.0;
      } else if (b > 1.0) {
        if (u1 > 0.0) {
          y = rtInf;
        } else {
          y = 0.0;
        }
      } else if (u1 > 0.0) {
        y = 0.0;
      } else {
        y = rtInf;
      }
    } else if (c == 0.0) {
      y = 1.0;
    } else if (c == 1.0) {
      if (u1 > 0.0) {
        y = u0;
      } else {
        y = 1.0 / u0;
      }
    } else if (u1 == 2.0) {
      y = u0 * u0;
    } else if ((u1 == 0.5) && (u0 >= 0.0)) {
      y = std::sqrt(u0);
    } else if ((u0 < 0.0) && (u1 > std::floor(u1))) {
      y = rtNaN;
    } else {
      y = std::pow(u0, u1);
    }
  }

  return y;
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

void b_ec_cwtAvg_api(ec_cwtAvgStackData *SD, const mxArray * const prhs[5],
                     int32_T nlhs, const mxArray *plhs[2])
{
  emxArray_real_T *freqs;
  emxArray_real_T *x;
  real_T (*ds)[2];
  real_T (*fLims)[2];
  real_T fOctave;
  real_T fs;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);

  // Marshall function inputs
  emxInit_real_T(&x, 2, &ke_emlrtRTEI, true);
  x->canFreeData = false;
  emlrt_marshallIn(emlrtAlias(prhs[0]), "x", x);
  fs = emlrt_marshallIn(emlrtAliasP(prhs[1]), "fs");
  fLims = b_emlrt_marshallIn(emlrtAlias(prhs[2]), "fLims");
  fOctave = emlrt_marshallIn(emlrtAliasP(prhs[3]), "fOctave");
  ds = b_emlrt_marshallIn(emlrtAlias(prhs[4]), "ds");

  // Invoke the target function
  emxInit_cell_wrap_0_1x65534(&SD->f1.y);
  emxInit_real_T(&freqs, 1, &ke_emlrtRTEI, true);
  ec_cwtAvg(SD, x, fs, *fLims, fOctave, *ds, SD->f1.y.data, SD->f1.y.size, freqs);
  emxFree_real_T(&x);

  // Marshall function outputs
  plhs[0] = emlrt_marshallOut(SD->f1.y.data, SD->f1.y.size);
  emxFree_cell_wrap_0_1x65534(&SD->f1.y);
  if (nlhs > 1) {
    freqs->canFreeData = false;
    plhs[1] = emlrt_marshallOut(freqs);
  }

  emxFree_real_T(&freqs);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
}

//
// function [y,freqs] = ec_cwtAvg(x,fs,fLims,fOctave,ds)
void ec_cwtAvg(ec_cwtAvgStackData *SD, const emxArray_real_T *cpu_x, real_T fs,
               const real_T fLims[2], real_T fOctave, const real_T ds[2],
               cell_wrap_0 y_data[], int32_T y_size[2], emxArray_real_T
               *cpu_freqs)
{
  static const creal_T dc7{ 1.0020841800044864E-289,// re
    0.0                                // im
  };

  static creal_T cpu_dc1{ 0.0,         // re
    0.0                                // im
  };

  static creal_T cpu_dc6{ 0.0,         // re
    0.0                                // im
  };

  static const real_T cpu_table100[100]{ 0.0, 0.0, 0.69314718055994529,
    1.791759469228055, 3.1780538303479458, 4.7874917427820458,
    6.5792512120101012, 8.5251613610654147, 10.604602902745251,
    12.801827480081469, 15.104412573075516, 17.502307845873887,
    19.987214495661885, 22.552163853123425, 25.19122118273868, 27.89927138384089,
    30.671860106080672, 33.505073450136891, 36.395445208033053,
    39.339884187199495, 42.335616460753485, 45.380138898476908,
    48.471181351835227, 51.606675567764377, 54.784729398112319,
    58.003605222980518, 61.261701761002, 64.557538627006338, 67.88974313718154,
    71.257038967168015, 74.658236348830158, 78.0922235533153, 81.557959456115043,
    85.054467017581516, 88.580827542197682, 92.1361756036871, 95.7196945421432,
    99.330612454787428, 102.96819861451381, 106.63176026064346,
    110.32063971475739, 114.03421178146171, 117.77188139974507,
    121.53308151543864, 125.3172711493569, 129.12393363912722,
    132.95257503561632, 136.80272263732635, 140.67392364823425,
    144.5657439463449, 148.47776695177302, 152.40959258449735, 156.3608363030788,
    160.3311282166309, 164.32011226319517, 168.32744544842765,
    172.35279713916279, 176.39584840699735, 180.45629141754378,
    184.53382886144948, 188.6281734236716, 192.7390472878449, 196.86618167289,
    201.00931639928152, 205.1681994826412, 209.34258675253685,
    213.53224149456327, 217.73693411395422, 221.95644181913033,
    226.1905483237276, 230.43904356577696, 234.70172344281826,
    238.97838956183432, 243.26884900298271, 247.57291409618688,
    251.89040220972319, 256.22113555000954, 260.56494097186322,
    264.92164979855278, 269.29109765101981, 273.67312428569369,
    278.06757344036612, 282.4742926876304, 286.893133295427, 291.32395009427029,
    295.76660135076065, 300.22094864701415, 304.68685676566872,
    309.1641935801469, 313.65282994987905, 318.1526396202093, 322.66349912672615,
    327.1852877037752, 331.71788719692847, 336.26118197919845, 340.815058870799,
    345.37940706226686, 349.95411804077025, 354.53908551944079,
    359.1342053695754 };

  static const real_T NODES[15]{ -0.99145537112081261, -0.94910791234275849,
    -0.8648644233597691, -0.74153118559939435, -0.58608723546769115,
    -0.40584515137739718, -0.20778495500789851, 0.0, 0.20778495500789851,
    0.40584515137739718, 0.58608723546769115, 0.74153118559939435,
    0.8648644233597691, 0.94910791234275849, 0.99145537112081261 };

  static const real_T dv5[15]{ 0.022935322010529221, 0.063092092629978544,
    0.1047900103222502, 0.14065325971552589, 0.16900472663926791,
    0.19035057806478539, 0.20443294007529891, 0.20948214108472779,
    0.20443294007529891, 0.19035057806478539, 0.16900472663926791,
    0.14065325971552589, 0.1047900103222502, 0.063092092629978544,
    0.022935322010529221 };

  static const real_T dv6[15]{ 0.022935322010529221, -0.066392873538891159,
    0.1047900103222502, -0.13905213177375081, 0.16900472663926791,
    -0.19147947244033353, 0.20443294007529891, -0.20847704258874161,
    0.20443294007529891, -0.19147947244033353, 0.16900472663926791,
    -0.13905213177375081, 0.1047900103222502, -0.066392873538891159,
    0.022935322010529221 };

  static const real_T p1[8]{ 4.9452353592967269, 201.8112620856775,
    2290.8383738313464, 11319.672059033808, 28557.246356716354,
    38484.962284437934, 26377.487876241954, 7225.8139797002877 };

  static const real_T p2[8]{ 4.974607845568932, 542.4138599891071,
    15506.938649783649, 184793.29044456323, 1.0882047694688288E+6,
    3.33815296798703E+6, 5.1066616789273527E+6, 3.0741090548505397E+6 };

  static const real_T p4[8]{ 14745.0216605994, 2.4268133694867045E+6,
    1.2147555740450932E+8, 2.6634324496309772E+9, 2.9403789566345539E+10,
    1.7026657377653989E+11, 4.926125793377431E+11, 5.6062518562239514E+11 };

  static const real_T q1[8]{ 67.482125503037778, 1113.3323938571993,
    7738.7570569353984, 27639.870744033407, 54993.102062261576,
    61611.221800660023, 36351.2759150194, 8785.5363024310136 };

  static const real_T q2[8]{ 183.03283993705926, 7765.0493214450062,
    133190.38279660742, 1.1367058213219696E+6, 5.2679641174379466E+6,
    1.3467014543111017E+7, 1.7827365303532742E+7, 9.5330955918443538E+6 };

  static const real_T q4[8]{ 2690.5301758708993, 639388.56543000927,
    4.1355999302413881E+7, 1.120872109616148E+9, 1.4886137286788137E+10,
    1.0168035862724382E+11, 3.4174763455073773E+11, 4.4631581874197131E+11 };

  static const real_T c[7]{ -0.001910444077728, 0.00084171387781295,
    -0.00059523799130430121, 0.0007936507935003503, -0.0027777777777776816,
    0.083333333333333329, 0.0057083835261 };

  static const int32_T iv[2]{ 1, 7 };

  static const int32_T iv1[2]{ 1, 2 };

  static const int32_T iv10[2]{ 1, 7 };

  static const int32_T iv13[2]{ 1, 7 };

  static const int32_T iv2[2]{ 1, 7 };

  static const int32_T iv3[2]{ 1, 5 };

  static const char_T cpu_cv[128]{ '\x00', '\x01', '\x02', '\x03', '\x04',
    '\x05', '\x06', '\a', '\b', '\t', '\n', '\v', '\f', '\r', '\x0e', '\x0f',
    '\x10', '\x11', '\x12', '\x13', '\x14', '\x15', '\x16', '\x17', '\x18',
    '\x19', '\x1a', '\x1b', '\x1c', '\x1d', '\x1e', '\x1f', ' ', '!', '\"', '#',
    '$', '%', '&', '\'', '(', ')', '*', '+', ',', '-', '.', '/', '0', '1', '2',
    '3', '4', '5', '6', '7', '8', '9', ':', ';', '<', '=', '>', '?', '@', 'a',
    'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p',
    'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '[', '\\', ']', '^', '_',
    '`', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
    'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '{', '|', '}',
    '~', '\x7f' };

  static const char_T b[10]{ 'r', 'e', 'f', 'l', 'e', 'c', 't', 'i', 'o', 'n' };

  static const char_T cv1[10]{ 'r', 'e', 'f', 'l', 'e', 'c', 't', 'i', 'o', 'n'
  };

  static const char_T rfmt[7]{ '%', '2', '3', '.', '1', '5', 'e' };

  static const char_T u[7]{ 's', 'p', 'r', 'i', 'n', 't', 'f' };

  static const char_T b_formatSpec[5]{ '%', '2', '.', '2', 'f' };

  static const char_T c_b[5]{ 'M', 'o', 'r', 's', 'e' };

  static const char_T cv2[5]{ 'M', 'o', 'r', 's', 'e' };

  static const char_T cv3[5]{ 'm', 'o', 'r', 's', 'e' };

  static const char_T d_b[5]{ 'm', 'o', 'r', 's', 'e' };

  static const char_T formatSpec[2]{ '%', 'f' };

  static const int8_T A[4]{ 1, 1, 0, 0 };

  dim3 block;
  dim3 grid;
  emxArray_char_T *d_tmpStr;
  emxArray_char_T *tmpStr;
  emxArray_creal_T gpu_cfspos;
  emxArray_creal_T gpu_cfsposdft;
  emxArray_creal_T gpu_xposdft;
  emxArray_creal_T *cpu_cfspos;
  emxArray_creal_T *cpu_cfsposdft;
  emxArray_creal_T *cpu_xposdft;
  emxArray_int32_T b_gpu_rows;
  emxArray_int32_T gpu_IPIV;
  emxArray_int32_T gpu_iv14;
  emxArray_int32_T gpu_iv15;
  emxArray_int32_T gpu_iv9;
  emxArray_int32_T gpu_jpvt;
  emxArray_int32_T gpu_omega_tmp1;
  emxArray_int32_T gpu_rows;
  emxArray_int32_T j_gpu_y;
  emxArray_int32_T k_gpu_y;
  emxArray_int32_T *b_cpu_rows;
  emxArray_int32_T *cpu_IPIV;
  emxArray_int32_T *cpu_iv14;
  emxArray_int32_T *cpu_iv15;
  emxArray_int32_T *cpu_iv9;
  emxArray_int32_T *cpu_jpvt;
  emxArray_int32_T *cpu_omega_tmp1;
  emxArray_int32_T *cpu_rows;
  emxArray_int32_T *m_cpu_y;
  emxArray_int32_T *n_cpu_y;
  emxArray_ptrdiff_t *jpvt_t;
  emxArray_real_T b_gpu_a;
  emxArray_real_T b_gpu_c;
  emxArray_real_T b_gpu_expanded;
  emxArray_real_T b_gpu_h;
  emxArray_real_T b_gpu_somega;
  emxArray_real_T b_gpu_w;
  emxArray_real_T b_gpu_x;
  emxArray_real_T b_gpu_y;
  emxArray_real_T c_gpu_c;
  emxArray_real_T c_gpu_w;
  emxArray_real_T c_gpu_x;
  emxArray_real_T c_gpu_y;
  emxArray_real_T d_gpu_c;
  emxArray_real_T d_gpu_w;
  emxArray_real_T d_gpu_x;
  emxArray_real_T e_gpu_x;
  emxArray_real_T e_gpu_y;
  emxArray_real_T f_gpu_y;
  emxArray_real_T gpu_G;
  emxArray_real_T gpu_a;
  emxArray_real_T gpu_abscfssq;
  emxArray_real_T gpu_absomega;
  emxArray_real_T gpu_abswt2;
  emxArray_real_T gpu_abswt2S;
  emxArray_real_T gpu_b;
  emxArray_real_T gpu_b0;
  emxArray_real_T gpu_c;
  emxArray_real_T gpu_daughter;
  emxArray_real_T gpu_dv22;
  emxArray_real_T gpu_dv23;
  emxArray_real_T gpu_dv24;
  emxArray_real_T gpu_expanded;
  emxArray_real_T gpu_expnt;
  emxArray_real_T gpu_f;
  emxArray_real_T gpu_fb_Omega;
  emxArray_real_T gpu_fb_Scales;
  emxArray_real_T gpu_freqs;
  emxArray_real_T gpu_h;
  emxArray_real_T gpu_h1;
  emxArray_real_T gpu_k;
  emxArray_real_T gpu_m;
  emxArray_real_T gpu_omega_tmp2;
  emxArray_real_T gpu_opts_filter;
  emxArray_real_T gpu_powscales;
  emxArray_real_T gpu_savgpTMP;
  emxArray_real_T gpu_sinc1A;
  emxArray_real_T gpu_sinc2A;
  emxArray_real_T gpu_sinc3A;
  emxArray_real_T gpu_sinc4A;
  emxArray_real_T gpu_somega;
  emxArray_real_T gpu_tau;
  emxArray_real_T gpu_w;
  emxArray_real_T gpu_x;
  emxArray_real_T gpu_xCh;
  emxArray_real_T gpu_xv;
  emxArray_real_T gpu_y;
  emxArray_real_T gpu_yCol;
  emxArray_real_T gpu_z;
  emxArray_real_T h_gpu_y;
  emxArray_real_T i_gpu_y;
  emxArray_real_T l_gpu_y;
  emxArray_real_T m_gpu_y;
  emxArray_real_T n_gpu_y;
  emxArray_real_T o_gpu_y;
  emxArray_real_T p_gpu_y;
  emxArray_real_T *b_cpu_a;
  emxArray_real_T *b_cpu_c;
  emxArray_real_T *b_cpu_expanded;
  emxArray_real_T *b_cpu_h;
  emxArray_real_T *b_cpu_somega;
  emxArray_real_T *b_cpu_w;
  emxArray_real_T *b_cpu_x;
  emxArray_real_T *b_cpu_y;
  emxArray_real_T *c_cpu_c;
  emxArray_real_T *c_cpu_w;
  emxArray_real_T *c_cpu_x;
  emxArray_real_T *c_cpu_y;
  emxArray_real_T *cpu_G;
  emxArray_real_T *cpu_a;
  emxArray_real_T *cpu_abscfssq;
  emxArray_real_T *cpu_absomega;
  emxArray_real_T *cpu_abswt2;
  emxArray_real_T *cpu_abswt2S;
  emxArray_real_T *cpu_b;
  emxArray_real_T *cpu_b0;
  emxArray_real_T *cpu_c;
  emxArray_real_T *cpu_daughter;
  emxArray_real_T *cpu_dv22;
  emxArray_real_T *cpu_dv23;
  emxArray_real_T *cpu_dv24;
  emxArray_real_T *cpu_expanded;
  emxArray_real_T *cpu_expnt;
  emxArray_real_T *cpu_f;
  emxArray_real_T *cpu_fb_Omega;
  emxArray_real_T *cpu_fb_Scales;
  emxArray_real_T *cpu_h;
  emxArray_real_T *cpu_h1;
  emxArray_real_T *cpu_k;
  emxArray_real_T *cpu_m;
  emxArray_real_T *cpu_omega_tmp2;
  emxArray_real_T *cpu_opts_filter;
  emxArray_real_T *cpu_powscales;
  emxArray_real_T *cpu_savgpTMP;
  emxArray_real_T *cpu_sinc1A;
  emxArray_real_T *cpu_sinc2A;
  emxArray_real_T *cpu_sinc3A;
  emxArray_real_T *cpu_sinc4A;
  emxArray_real_T *cpu_somega;
  emxArray_real_T *cpu_tau;
  emxArray_real_T *cpu_w;
  emxArray_real_T *cpu_xCh;
  emxArray_real_T *cpu_xv;
  emxArray_real_T *cpu_y;
  emxArray_real_T *cpu_yCol;
  emxArray_real_T *cpu_z;
  emxArray_real_T *d_cpu_c;
  emxArray_real_T *d_cpu_w;
  emxArray_real_T *d_cpu_x;
  emxArray_real_T *d_cpu_y;
  emxArray_real_T *e_cpu_x;
  emxArray_real_T *e_cpu_y;
  emxArray_real_T *f_cpu_y;
  emxArray_real_T *h_cpu_y;
  emxArray_real_T *i_cpu_y;
  emxArray_real_T *k_cpu_y;
  emxArray_real_T *l_cpu_y;
  emxArray_real_T *o_cpu_y;
  emxArray_real_T *p_cpu_y;
  emxArray_uint32_T d_gpu_y;
  emxArray_uint32_T g_gpu_y;
  emxArray_uint32_T *g_cpu_y;
  emxArray_uint32_T *j_cpu_y;
  const mxArray *b_tmpStr;
  const mxArray *b_y;
  const mxArray *c_tmpStr;
  const mxArray *c_y;
  const mxArray *d_y;
  const mxArray *e_y;
  const mxArray *f_y;
  const mxArray *g_y;
  const mxArray *h_y;
  const mxArray *i_y;
  const mxArray *j_y;
  const mxArray *m;
  const mxArray *m1;
  const mxArray *m10;
  const mxArray *m13;
  const mxArray *m14;
  const mxArray *m2;
  const mxArray *m3;
  const mxArray *m4;
  const mxArray *m5;
  const mxArray *m9;
  const mxArray *y;
  creal_T *gpu_dc1;
  creal_T *gpu_dc6;
  real_T cpu_dv11_data[9735];
  real_T cpu_fx_data[9735];
  real_T (*b_gpu_a_data)[9735];
  real_T (*b_gpu_fx_data)[9735];
  real_T (*b_gpu_x_data)[9735];
  real_T (*b_gpu_y_data)[9735];
  real_T (*c_gpu_fx_data)[9735];
  real_T (*d_gpu_fx_data)[9735];
  real_T (*e_gpu_fx_data)[9735];
  real_T (*gpu_a_data)[9735];
  real_T (*gpu_dv10_data)[9735];
  real_T (*gpu_dv11_data)[9735];
  real_T (*gpu_dv15_data)[9735];
  real_T (*gpu_dv4_data)[9735];
  real_T (*gpu_fx_data)[9735];
  real_T (*gpu_x_data)[9735];
  real_T (*gpu_xt_data)[9735];
  real_T (*gpu_y_data)[9735];
  real_T cpu_subs[1298];
  real_T (*gpu_subs)[1298];
  real_T cpu_interval[650];
  real_T (*gpu_interval)[650];
  real_T errsub[649];
  real_T qsub[649];
  real_T NyquistRange[2];
  real_T fb_FrequencyLimits[2];
  real_T a;
  real_T b_c;
  real_T b_r;
  real_T cpu_r;
  real_T d;
  real_T delta;
  real_T err_ok;
  real_T fb_VoicesPerOctave;
  real_T fc;
  real_T intDsq;
  real_T intFsq;
  real_T omegac;
  real_T q_ok;
  real_T r;
  real_T s;
  real_T tau;
  real_T *gpu_r;
  int32_T a_size[2];
  int32_T b_a_size[2];
  int32_T b_xt_size[2];
  int32_T dv11_size[2];
  int32_T dv13_size[2];
  int32_T dv4_size[2];
  int32_T dv7_size[2];
  int32_T fx_size[2];
  int32_T origSiz[2];
  int32_T xt_size[2];
  int32_T (*gpu_csz)[2];
  int32_T (*gpu_lshift)[2];
  int32_T b_eint;
  int32_T b_nx;
  int32_T bcoef;
  int32_T cpu_nrefine;
  int32_T csz_idx_0;
  int32_T eint;
  int32_T exitg1;
  int32_T exponent;
  int32_T fb_SignalPad;
  int32_T ix;
  int32_T k;
  int32_T lidx;
  int32_T n;
  int32_T nG;
  int32_T nsubs;
  int32_T nx;
  int32_T x_size_idx_1;
  int32_T *gpu_nrefine;
  uint32_T xSize[2];
  uint32_T N;
  char_T unusedExpr[23];
  char_T cpu_wav[5];
  char_T cpu_wname[5];
  char_T wavname[5];
  char_T (*gpu_wav)[5];
  char_T (*gpu_wname)[5];
  int8_T n_idx_0;
  boolean_T b_b[2];
  boolean_T G_needsGpuEnsureCapacity;
  boolean_T abswt2S_outdatedOnCpu;
  boolean_T b_fx_data_outdatedOnCpu;
  boolean_T b_y_needsGpuEnsureCapacity;
  boolean_T c_fb_Scales_needsGpuEnsureCapac;
  boolean_T c_omega_tmp1_needsGpuEnsureCapa;
  boolean_T c_y_needsGpuEnsureCapacity;
  boolean_T d_y_needsGpuEnsureCapacity;
  boolean_T daughter_needsGpuEnsureCapacity;
  boolean_T daughter_outdatedOnGpu;
  boolean_T doDownsample;
  boolean_T e_y_needsGpuEnsureCapacity;
  boolean_T exitg2;
  boolean_T fb_Omega_outdatedOnCpu;
  boolean_T fb_Scales_outdatedOnCpu;
  boolean_T first_iteration;
  boolean_T fx_data_outdatedOnCpu;
  boolean_T guard1;
  boolean_T h_needsGpuEnsureCapacity;
  boolean_T h_outdatedOnGpu;
  boolean_T interval_outdatedOnGpu;
  boolean_T subs_outdatedOnCpu;
  boolean_T validLaunchParams;
  boolean_T wav_outdatedOnCpu;
  boolean_T x_outdatedOnGpu;
  boolean_T y_needsGpuEnsureCapacity;
  if (!gpuConstsCopied_ec_cwtAvg) {
    gpuConstsCopied_ec_cwtAvg = true;
    checkCudaError(cudaMemcpy(*global_gpu_cv, cpu_cv, sizeof(char_T [128]),
      cudaMemcpyHostToDevice), __FILE__, __LINE__);
    checkCudaError(cudaMemcpy(*global_gpu_table100, cpu_table100, sizeof(real_T
      [100]), cudaMemcpyHostToDevice), __FILE__, __LINE__);
  }

  checkCudaError(mwCudaMalloc(&gpu_lshift, 8UL), __FILE__, __LINE__);
  checkCudaError(mwCudaMalloc(&gpu_csz, 8UL), __FILE__, __LINE__);
  checkCudaError(mwCudaMalloc(&gpu_fx_data, 77880UL), __FILE__, __LINE__);
  gpuEmxReset_real_T(&c_gpu_w);
  gpuEmxReset_real_T(&b_gpu_w);
  gpuEmxReset_real_T(&gpu_b0);
  gpuEmxReset_real_T(&i_gpu_y);
  gpuEmxReset_real_T(&h_gpu_y);
  gpuEmxReset_int32_T(&b_gpu_rows);
  gpuEmxReset_int32_T(&gpu_rows);
  gpuEmxReset_int32_T(&gpu_iv15);
  gpuEmxReset_int32_T(&gpu_iv14);
  gpuEmxReset_int32_T(&j_gpu_y);
  gpuEmxReset_int32_T(&k_gpu_y);
  gpuEmxReset_real_T(&gpu_expanded);
  gpuEmxReset_real_T(&b_gpu_expanded);
  gpuEmxReset_real_T(&b_gpu_c);
  gpuEmxReset_real_T(&gpu_w);
  gpuEmxReset_real_T(&m_gpu_y);
  gpuEmxReset_int32_T(&gpu_IPIV);
  gpuEmxReset_real_T(&l_gpu_y);
  gpuEmxReset_real_T(&d_gpu_x);
  gpuEmxReset_real_T(&gpu_tau);
  gpuEmxReset_real_T(&gpu_dv24);
  gpuEmxReset_int32_T(&gpu_jpvt);
  gpuEmxReset_real_T(&e_gpu_x);
  gpuEmxReset_real_T(&gpu_yCol);
  gpuEmxReset_real_T(&gpu_dv23);
  gpuEmxReset_real_T(&b_gpu_a);
  gpuEmxReset_real_T(&gpu_b);
  gpuEmxReset_int32_T(&gpu_iv9);
  gpuEmxReset_real_T(&gpu_sinc4A);
  gpuEmxReset_uint32_T(&g_gpu_y);
  gpuEmxReset_real_T(&b_gpu_h);
  gpuEmxReset_real_T(&gpu_sinc3A);
  gpuEmxReset_real_T(&gpu_sinc2A);
  gpuEmxReset_real_T(&gpu_sinc1A);
  gpuEmxReset_real_T(&gpu_G);
  gpuEmxReset_real_T(&gpu_k);
  gpuEmxReset_real_T(&gpu_m);
  gpuEmxReset_real_T(&gpu_h);
  gpuEmxReset_real_T(&gpu_h1);
  gpuEmxReset_real_T(&gpu_dv22);
  gpuEmxReset_real_T(&gpu_opts_filter);
  gpuEmxReset_real_T(&gpu_xCh);
  gpuEmxReset_real_T(&c_gpu_c);
  gpuEmxReset_real_T(&f_gpu_y);
  gpuEmxReset_real_T(&gpu_abswt2S);
  gpuEmxReset_real_T(&gpu_abswt2);
  gpuEmxReset_real_T(&e_gpu_y);
  gpuEmxReset_real_T(&d_gpu_c);
  gpuEmxReset_real_T(&gpu_c);
  gpuEmxReset_real_T(&gpu_z);
  gpuEmxReset_uint32_T(&d_gpu_y);
  gpuEmxReset_real_T(&gpu_a);
  gpuEmxReset_real_T(&gpu_abscfssq);
  gpuEmxReset_real_T(&c_gpu_y);
  gpuEmxReset_creal_T(&gpu_cfspos);
  gpuEmxReset_creal_T(&gpu_cfsposdft);
  gpuEmxReset_real_T(&c_gpu_x);
  gpuEmxReset_creal_T(&gpu_xposdft);
  gpuEmxReset_real_T(&gpu_xv);
  gpuEmxReset_real_T(&gpu_savgpTMP);
  checkCudaError(mwCudaMalloc(&b_gpu_fx_data, 77880UL), __FILE__, __LINE__);
  checkCudaError(mwCudaMalloc(&gpu_dv11_data, 77880UL), __FILE__, __LINE__);
  checkCudaError(mwCudaMalloc(&gpu_dv15_data, 77880UL), __FILE__, __LINE__);
  gpuEmxReset_real_T(&n_gpu_y);
  gpuEmxReset_real_T(&gpu_x);
  checkCudaError(mwCudaMalloc(&b_gpu_a_data, 77880UL), __FILE__, __LINE__);
  gpuEmxReset_real_T(&gpu_powscales);
  checkCudaError(mwCudaMalloc(&c_gpu_fx_data, 77880UL), __FILE__, __LINE__);
  gpuEmxReset_real_T(&gpu_expnt);
  gpuEmxReset_real_T(&gpu_absomega);
  gpuEmxReset_real_T(&d_gpu_w);
  gpuEmxReset_real_T(&gpu_somega);
  gpuEmxReset_real_T(&b_gpu_somega);
  gpuEmxReset_real_T(&gpu_f);
  gpuEmxReset_real_T(&gpu_daughter);
  checkCudaError(mwCudaMalloc(&d_gpu_fx_data, 77880UL), __FILE__, __LINE__);
  checkCudaError(mwCudaMalloc(&gpu_dv4_data, 77880UL), __FILE__, __LINE__);
  checkCudaError(mwCudaMalloc(&gpu_dv10_data, 77880UL), __FILE__, __LINE__);
  gpuEmxReset_real_T(&p_gpu_y);
  checkCudaError(mwCudaMalloc(&gpu_a_data, 77880UL), __FILE__, __LINE__);
  gpuEmxReset_real_T(&o_gpu_y);
  checkCudaError(mwCudaMalloc(&e_gpu_fx_data, 77880UL), __FILE__, __LINE__);
  checkCudaError(mwCudaMalloc(&b_gpu_y_data, 77880UL), __FILE__, __LINE__);
  gpuEmxReset_real_T(&b_gpu_y);
  checkCudaError(mwCudaMalloc(&gpu_y_data, 77880UL), __FILE__, __LINE__);
  gpuEmxReset_real_T(&gpu_y);
  checkCudaError(mwCudaMalloc(&gpu_xt_data, 77880UL), __FILE__, __LINE__);
  checkCudaError(mwCudaMalloc(&b_gpu_x_data, 77880UL), __FILE__, __LINE__);
  gpuEmxReset_real_T(&gpu_fb_Scales);
  checkCudaError(mwCudaMalloc(&gpu_x_data, 77880UL), __FILE__, __LINE__);
  checkCudaError(mwCudaMalloc(&gpu_subs, 10384UL), __FILE__, __LINE__);
  gpuEmxReset_real_T(&gpu_fb_Omega);
  checkCudaError(mwCudaMalloc(&gpu_interval, 5200UL), __FILE__, __LINE__);
  gpuEmxReset_real_T(&gpu_omega_tmp2);
  checkCudaError(mwCudaMalloc(&gpu_wname, 5UL), __FILE__, __LINE__);
  gpuEmxReset_int32_T(&gpu_omega_tmp1);
  checkCudaError(mwCudaMalloc(&gpu_wav, 5UL), __FILE__, __LINE__);
  checkCudaError(mwCudaMalloc(&gpu_r, 8UL), __FILE__, __LINE__);
  checkCudaError(mwCudaMalloc(&gpu_nrefine, 4UL), __FILE__, __LINE__);
  checkCudaError(mwCudaMalloc(&gpu_dc1, 16UL), __FILE__, __LINE__);
  checkCudaError(mwCudaMalloc(&gpu_dc6, 16UL), __FILE__, __LINE__);
  gpuEmxReset_real_T(&gpu_freqs);
  gpuEmxReset_real_T(&b_gpu_x);
  h_outdatedOnGpu = false;
  abswt2S_outdatedOnCpu = false;
  b_fx_data_outdatedOnCpu = false;
  fx_data_outdatedOnCpu = false;
  x_outdatedOnGpu = true;
  e_y_needsGpuEnsureCapacity = true;
  d_y_needsGpuEnsureCapacity = true;
  G_needsGpuEnsureCapacity = true;
  h_needsGpuEnsureCapacity = true;
  c_y_needsGpuEnsureCapacity = true;
  b_y_needsGpuEnsureCapacity = true;
  y_needsGpuEnsureCapacity = true;
  c_omega_tmp1_needsGpuEnsureCapa = true;
  checkCudaError(cudaMemcpy(gpu_dc1, &cpu_dc1, 16UL, cudaMemcpyHostToDevice),
                 __FILE__, __LINE__);
  checkCudaError(cudaMemcpy(gpu_dc6, &cpu_dc6, 16UL, cudaMemcpyHostToDevice),
                 __FILE__, __LINE__);
  ec_cwtAvg_kernel1<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_dc1, gpu_dc6);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);

  //  CWT scale spectrum - CUDA binary wrapper (double-precision, FP64)
  //  CWT uses morse wavelets, as they account for unequal variance-covariance across freqs.
  //  L1-norm is applied to mitigate 1/f decay of neuronal field potentials.
  //  Log-transform & robust z-scoring converts absolute valued CWT outputs into normal distribution.
  //
  //  Kevin Tan, 2022 (kevmtan.github.io)
  //  Input validation
  // 'ec_cwtAvg:11' x (:,:){mustBeFloat}
  //  Input data
  // 'ec_cwtAvg:12' fs (1,1){mustBeFloat} = 1000
  //  Sampling rate
  // 'ec_cwtAvg:13' fLims (1,2){mustBeFloat} = [60 200]
  //  Frequency limits
  // 'ec_cwtAvg:14' fOctave (1,1){mustBeFloat} = 32
  //  Voices per octave
  // 'ec_cwtAvg:15' ds (1,2){mustBeFloat} = [1 1]
  //  Frequency limits
  // 'ec_cwtAvg:17' coder.gpu.kernelfun;
  // 'ec_cwtAvg:18' fOctave = round(fOctave);
  // 'ec_cwtAvg:19' nFrames = height(x);
  // 'ec_cwtAvg:20' nChs = width(x);
  // 'ec_cwtAvg:21' doDownsample = ds(2)>ds(1);
  doDownsample = (ds[1] > ds[0]);

  //  Prep CWT
  // 'ec_cwtAvg:24' fb = cwtfilterbank(Wavelet="Morse",SignalLength=nFrames,...
  // 'ec_cwtAvg:25'     SamplingFrequency=fs,FrequencyLimits=fLims,VoicesPerOctave=fOctave);
  b_nx = 50;
  fb_VoicesPerOctave = std::round(fOctave);
  for (bcoef = 0; bcoef < 2; bcoef++) {
    fb_FrequencyLimits[bcoef] = fLims[bcoef];
  }

  first_iteration = false;
  lidx = 0;
  do {
    exitg1 = 0;
    if (lidx + 1 < 11) {
      if (cpu_cv[static_cast<int32_T>(b[lidx])] != cpu_cv[static_cast<int32_T>
          (cv1[lidx])]) {
        exitg1 = 1;
      } else {
        lidx++;
      }
    } else {
      first_iteration = true;
      exitg1 = 1;
    }
  } while (exitg1 == 0);

  if (first_iteration) {
    if (cpu_x->size[0] <= 100000) {
      fb_SignalPad = static_cast<int32_T>(std::floor(static_cast<real_T>
        (cpu_x->size[0]) / 2.0));
    } else {
      delta = std::frexp(static_cast<real_T>(cpu_x->size[0]), &cpu_nrefine);
      if (delta == 0.5) {
        cpu_r = static_cast<real_T>(cpu_nrefine) - 1.0;
      } else {
        cpu_r = std::log(delta) / 0.69314718055994529 + static_cast<real_T>
          (cpu_nrefine);
      }

      cpu_r = std::ceil(cpu_r);
      fb_SignalPad = static_cast<int32_T>(cpu_r);
    }
  } else {
    fb_SignalPad = 0;
  }

  for (bcoef = 0; bcoef < 2; bcoef++) {
    b_b[bcoef] = std::isnan(fLims[bcoef]);
  }

  first_iteration = true;
  k = 0;
  exitg2 = false;
  while ((!exitg2) && (k < 2)) {
    if (!b_b[k]) {
      first_iteration = false;
      exitg2 = true;
    } else {
      k++;
    }
  }

  if (!first_iteration) {
    real_T freqrange[2];
    real_T cf;
    for (bcoef = 0; bcoef < 2; bcoef++) {
      freqrange[bcoef] = fLims[bcoef];
    }

    NyquistRange[1] = fs / 2.0;
    emxInit_char_T(&tmpStr, 2, &u_emlrtRTEI, true);
    if ((fLims[1] <= 0.0) || (fLims[0] >= NyquistRange[1])) {
      b_tmpStr = nullptr;
      y = nullptr;
      m = emlrtCreateCharArray(2, &iv[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m, &u[0]);
      emlrtAssign(&y, m);
      b_y = nullptr;
      m1 = emlrtCreateCharArray(2, &iv1[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 2, m1, &formatSpec[0]);
      emlrtAssign(&b_y, m1);
      c_y = nullptr;
      m2 = emlrtCreateDoubleScalar(NyquistRange[1]);
      emlrtAssign(&c_y, m2);
      emlrtAssign(&b_tmpStr, feval(y, b_y, c_y, &emlrtMCI));
      emlrt_marshallIn(length(emlrtAlias(b_tmpStr), &b_emlrtMCI),
                       "<output of length>");
      emlrt_marshallIn(emlrtAlias(b_tmpStr), "tmpStr", tmpStr);
      emlrtDestroyArray(&b_tmpStr);
    }

    emxFree_char_T(&tmpStr);
    omegac = 3.1415926535897931;
    ec_cwtAvg_kernel2<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*global_gpu_cv,
      *gpu_wname, *gpu_wav, c_b[0], c_b[1], c_b[2], c_b[3], c_b[4]);
    wav_outdatedOnCpu = true;
    checkCudaError(cudaMemcpy(cpu_wname, *gpu_wname, 5UL, cudaMemcpyDeviceToHost),
                   __FILE__, __LINE__);
    if (cpu_wname[0] == 'm') {
      cf = 1.8820720577620569;
      r = 0.0057083835261;
      cpu_r = 0.0057083835261;
      b_r = 0.0057083835261;
      for (nG = 0; nG < 6; nG++) {
        fc = c[nG];
        r = r * 0.005353955978584176 + fc;
        cpu_r = cpu_r * 0.005353955978584176 + fc;
        b_r = b_r * 0.005353955978584176 + fc;
      }

      r /= 13.666666666666666;
      cpu_r /= 13.666666666666666;
      b_r /= 13.666666666666666;
      b_r = std::sqrt((std::exp((cpu_table100[12] + 7.7183093240718676) - (((r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703)) + std::
                       exp((cpu_table100[14] + 2.5377749931802178) - (((cpu_r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703))) - std::
                      exp((cpu_table100[13] + 5.8211893391859881) - (((b_r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703)));
      if (std::isinf(b_r) || std::isnan(b_r)) {
        ec_cwtAvg_kernel3<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_interval);
        ec_cwtAvg_kernel4<<<dim3(6U, 1U, 1U), dim3(128U, 1U, 1U)>>>
          (*gpu_interval);
        interval_outdatedOnGpu = false;
        intDsq = 0.0;
        cpu_nrefine = 1;
        checkCudaError(cudaMemcpy(cpu_interval, *gpu_interval, 5200UL,
          cudaMemcpyDeviceToHost), __FILE__, __LINE__);
        nG = static_cast<int32_T>(cpu_interval[1]) - static_cast<int32_T>
          (cpu_interval[0]);
        if (nG > 0) {
          n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::abs
            (cpu_interval[1] - cpu_interval[0])) * 10 - 1);
          nsubs = n_idx_0 + 1;
          if (n_idx_0 + 2 > 2) {
            cpu_nrefine = n_idx_0;
            cpu_interval[n_idx_0 + 1] = cpu_interval[1];
            interval_outdatedOnGpu = true;
            delta = (cpu_interval[1] - cpu_interval[0]) / (static_cast<real_T>
              (n_idx_0) + 1.0);
            for (lidx = 0; lidx < cpu_nrefine; lidx++) {
              cpu_interval[n_idx_0 - lidx] = cpu_interval[0] +
                static_cast<real_T>(n_idx_0 - lidx) * delta;
            }
          }

          cpu_nrefine = n_idx_0 + 1;
        } else {
          nsubs = 1;
        }

        lidx = 0;
        for (ix = 0; ix < cpu_nrefine; ix++) {
          if (std::abs(cpu_interval[ix + 1] - cpu_interval[lidx]) > 0.0) {
            lidx++;
            cpu_interval[lidx] = cpu_interval[ix + 1];
            interval_outdatedOnGpu = true;
          } else {
            nsubs--;
          }
        }

        if (nsubs + 1 < 2) {
          if (interval_outdatedOnGpu) {
            checkCudaError(cudaMemcpy(*gpu_interval, cpu_interval, 5200UL,
              cudaMemcpyHostToDevice), __FILE__, __LINE__);
          }

          ec_cwtAvg_kernel5<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(cpu_nrefine,
            *gpu_interval);
          interval_outdatedOnGpu = false;
          nsubs = 1;
        }

        if (nG <= 0) {
          intDsq = rtNaN;
        } else {
          mwGetLaunchParameters1D(computeNumIters(nsubs - 1), &grid, &block,
            2147483647U);
          if (interval_outdatedOnGpu) {
            checkCudaError(cudaMemcpy(*gpu_interval, cpu_interval, 5200UL,
              cudaMemcpyHostToDevice), __FILE__, __LINE__);
          }

          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel191<<<grid, block>>>(*gpu_interval, nsubs - 1,
              *gpu_subs);
          }

          subs_outdatedOnCpu = true;
          q_ok = 0.0;
          err_ok = 0.0;
          first_iteration = true;
          do {
            exitg1 = 0;
            interval_outdatedOnGpu = false;
            nG = 15 * nsubs;
            ix = -1;
            for (k = 0; k < nsubs; k++) {
              if (subs_outdatedOnCpu) {
                checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                  cudaMemcpyDeviceToHost), __FILE__, __LINE__);
              }

              fc = cpu_subs[k << 1];
              subs_outdatedOnCpu = false;
              b_r = cpu_subs[(k << 1) + 1];
              cpu_r = (fc + b_r) / 2.0;
              delta = (b_r - fc) / 2.0;
              for (lidx = 0; lidx < 15; lidx++) {
                SD->f0.cpu_x_data[(ix + lidx) + 1] = NODES[lidx] * delta + cpu_r;
                interval_outdatedOnGpu = true;
              }

              ix += 15;
            }

            xt_size[0] = 1;
            xt_size[1] = nG;
            mwGetLaunchParameters1D(computeNumIters(nG - 1), &grid, &block,
              2147483647U);
            if (interval_outdatedOnGpu) {
              checkCudaError(cudaMemcpy(*gpu_x_data, SD->f0.cpu_x_data, 77880UL,
                cudaMemcpyHostToDevice), __FILE__, __LINE__);
            }

            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwtAvg_kernel192<<<grid, block>>>(*gpu_x_data, nG - 1,
                *gpu_xt_data, *b_gpu_x_data);
            }

            guard1 = false;
            if (!first_iteration) {
              checkCudaError(cudaMemcpy(SD->f0.cpu_x_data, *b_gpu_x_data,
                77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
              cpu_r = std::abs(SD->f0.cpu_x_data[0]);
              k = 0;
              exitg2 = false;
              while ((!exitg2) && (k <= nG - 2)) {
                fc = cpu_r;
                cpu_r = std::abs(SD->f0.cpu_x_data[k + 1]);
                if (std::abs(SD->f0.cpu_x_data[k + 1] - SD->f0.cpu_x_data[k]) <=
                    2.2204460492503131E-14 * std::fmax(fc, cpu_r)) {
                  first_iteration = true;
                  exitg2 = true;
                } else {
                  k++;
                }
              }

              if (first_iteration) {
                mwGetLaunchParameters1D(computeNumIters(static_cast<int16_T>(nG)
                  - 1), &grid, &block, 2147483647U);
                validLaunchParams = mwValidateLaunchParameters(grid, block);
                if (validLaunchParams) {
                  ec_cwtAvg_kernel193<<<grid, block>>>(static_cast<int16_T>(nG)
                    - 1, *e_gpu_fx_data);
                }

                exitg1 = 1;
              } else {
                guard1 = true;
              }
            } else {
              guard1 = true;
            }

            if (guard1) {
              first_iteration = false;
              mwGetLaunchParameters1D(computeNumIters(nG - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel194<<<grid, block>>>(*b_gpu_x_data, nG - 1,
                  *gpu_y_data);
              }

              mwGetLaunchParameters1D(computeNumIters(nG - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel195<<<grid, block>>>(*b_gpu_x_data, nG - 1,
                  *b_gpu_y_data);
              }

              a_size[1] = nG;
              mwGetLaunchParameters1D(computeNumIters(nG - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel196<<<grid, block>>>(*b_gpu_y_data, *gpu_y_data,
                  nG - 1, *gpu_a_data);
              }

              dv4_size[0] = 1;
              dv4_size[1] = a_size[1];
              mwGetLaunchParameters1D(computeNumIters(a_size[1] - 1), &grid,
                &block, 2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel197<<<grid, block>>>(*gpu_a_data, a_size[1] - 1,
                  *gpu_dv4_data);
              }

              mwGetLaunchParameters1D(computeNumIters(nG - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel198<<<grid, block>>>(*b_gpu_x_data, nG - 1,
                  *gpu_y_data);
              }

              dv7_size[0] = 1;
              dv7_size[1] = nG;
              mwGetLaunchParameters1D(computeNumIters(nG - 1), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel199<<<grid, block>>>(*gpu_y_data, nG - 1,
                  *b_gpu_y_data);
              }

              if (a_size[1] == nG) {
                fx_size[0] = 1;
                fx_size[1] = a_size[1];
                mwGetLaunchParameters1D(computeNumIters(a_size[1] - 1), &grid,
                  &block, 2147483647U);
                validLaunchParams = mwValidateLaunchParameters(grid, block);
                if (validLaunchParams) {
                  ec_cwtAvg_kernel200<<<grid, block>>>(*gpu_xt_data,
                    *b_gpu_y_data, *gpu_dv4_data, a_size[1] - 1, *e_gpu_fx_data);
                }

                fx_data_outdatedOnCpu = true;
              } else {
                if (fx_data_outdatedOnCpu) {
                  checkCudaError(cudaMemcpy(SD->f0.cpu_fx_data, *e_gpu_fx_data,
                    77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                }

                checkCudaError(cudaMemcpy(SD->f0.cpu_dv4_data, *gpu_dv4_data,
                  77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                checkCudaError(cudaMemcpy(SD->f0.cpu_x_data, *b_gpu_y_data,
                  77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                checkCudaError(cudaMemcpy(SD->f0.cpu_xt_data, *gpu_xt_data,
                  77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                binary_expand_op_7(SD->f0.cpu_fx_data, fx_size,
                                   SD->f0.cpu_dv4_data, dv4_size,
                                   SD->f0.cpu_x_data, dv7_size,
                                   SD->f0.cpu_xt_data, xt_size);
                fx_data_outdatedOnCpu = false;
              }

              cpu_r = 0.0;
              ix = -1;
              for (k = 0; k < nsubs; k++) {
                fc = 0.0;
                b_r = 0.0;
                for (lidx = 0; lidx < 15; lidx++) {
                  if (fx_data_outdatedOnCpu) {
                    checkCudaError(cudaMemcpy(SD->f0.cpu_fx_data, *e_gpu_fx_data,
                      77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                  }

                  fc += dv5[lidx] * SD->f0.cpu_fx_data[(ix + lidx) + 1];
                  fx_data_outdatedOnCpu = false;
                  b_r += dv6[lidx] * SD->f0.cpu_fx_data[(ix + lidx) + 1];
                }

                ix += 15;
                if (subs_outdatedOnCpu) {
                  checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                    cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                }

                subs_outdatedOnCpu = false;
                delta = (cpu_subs[(k << 1) + 1] - cpu_subs[k << 1]) / 2.0;
                fc *= delta;
                qsub[k] = fc;
                cpu_r += fc;
                errsub[k] = b_r * delta;
              }

              intDsq = cpu_r + q_ok;
              delta = std::fmax(1.0E-10, 1.0E-6 * std::abs(intDsq));
              tau = 2.0 * delta;
              cpu_r = 0.0;
              cpu_nrefine = 0;
              for (k = 0; k < nsubs; k++) {
                fc = errsub[k];
                b_r = std::abs(fc);
                if (subs_outdatedOnCpu) {
                  checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                    cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                }

                subs_outdatedOnCpu = false;
                if (b_r <= tau * ((cpu_subs[(k << 1) + 1] - cpu_subs[k << 1]) /
                                  2.0)) {
                  err_ok += fc;
                  q_ok += qsub[k];
                } else {
                  cpu_r += b_r;
                  cpu_nrefine++;
                  cpu_subs[(cpu_nrefine - 1) << 1] = cpu_subs[k << 1];
                  cpu_subs[((cpu_nrefine - 1) << 1) + 1] = cpu_subs[(k << 1) + 1];
                }
              }

              cpu_r += std::abs(err_ok);
              if ((!std::isinf(intDsq)) && (!std::isnan(intDsq)) && ((!std::
                    isinf(cpu_r)) && (!std::isnan(cpu_r))) && (cpu_nrefine != 0)
                  && (!(cpu_r <= delta))) {
                nsubs = cpu_nrefine << 1;
                if (nsubs > 650) {
                  exitg1 = 1;
                } else {
                  for (k = 0; k < cpu_nrefine; k++) {
                    if (subs_outdatedOnCpu) {
                      checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                        cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                    }

                    cpu_subs[((((cpu_nrefine - k) << 1) - 1) << 1) + 1] =
                      cpu_subs[(((cpu_nrefine - k) - 1) << 1) + 1];
                    cpu_subs[(((cpu_nrefine - k) << 1) - 1) << 1] = (cpu_subs
                      [((cpu_nrefine - k) - 1) << 1] + cpu_subs[(((cpu_nrefine -
                      k) - 1) << 1) + 1]) / 2.0;
                    cpu_subs[((((cpu_nrefine - k) << 1) - 2) << 1) + 1] =
                      cpu_subs[(((cpu_nrefine - k) << 1) - 1) << 1];
                    cpu_subs[(((cpu_nrefine - k) << 1) - 2) << 1] = cpu_subs
                      [((cpu_nrefine - k) - 1) << 1];
                    subs_outdatedOnCpu = false;
                  }
                }
              } else {
                exitg1 = 1;
              }
            }
          } while (exitg1 == 0);
        }

        ec_cwtAvg_kernel6<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_interval);
        ec_cwtAvg_kernel7<<<dim3(6U, 1U, 1U), dim3(128U, 1U, 1U)>>>
          (*gpu_interval);
        interval_outdatedOnGpu = false;
        intFsq = 0.0;
        cpu_nrefine = 1;
        checkCudaError(cudaMemcpy(cpu_interval, *gpu_interval, 5200UL,
          cudaMemcpyDeviceToHost), __FILE__, __LINE__);
        nG = static_cast<int32_T>(cpu_interval[1]) - static_cast<int32_T>
          (cpu_interval[0]);
        if (nG > 0) {
          n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::abs
            (cpu_interval[1] - cpu_interval[0])) * 10 - 1);
          nsubs = n_idx_0 + 1;
          if (n_idx_0 + 2 > 2) {
            cpu_nrefine = n_idx_0;
            cpu_interval[n_idx_0 + 1] = cpu_interval[1];
            interval_outdatedOnGpu = true;
            delta = (cpu_interval[1] - cpu_interval[0]) / (static_cast<real_T>
              (n_idx_0) + 1.0);
            for (lidx = 0; lidx < cpu_nrefine; lidx++) {
              cpu_interval[n_idx_0 - lidx] = cpu_interval[0] +
                static_cast<real_T>(n_idx_0 - lidx) * delta;
            }
          }

          cpu_nrefine = n_idx_0 + 1;
        } else {
          nsubs = 1;
        }

        lidx = 0;
        for (ix = 0; ix < cpu_nrefine; ix++) {
          if (std::abs(cpu_interval[ix + 1] - cpu_interval[lidx]) > 0.0) {
            lidx++;
            cpu_interval[lidx] = cpu_interval[ix + 1];
            interval_outdatedOnGpu = true;
          } else {
            nsubs--;
          }
        }

        if (nsubs + 1 < 2) {
          if (interval_outdatedOnGpu) {
            checkCudaError(cudaMemcpy(*gpu_interval, cpu_interval, 5200UL,
              cudaMemcpyHostToDevice), __FILE__, __LINE__);
          }

          ec_cwtAvg_kernel8<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(cpu_nrefine,
            *gpu_interval);
          interval_outdatedOnGpu = false;
          nsubs = 1;
        }

        if (nG <= 0) {
          intFsq = rtNaN;
        } else {
          mwGetLaunchParameters1D(computeNumIters(nsubs - 1), &grid, &block,
            2147483647U);
          if (interval_outdatedOnGpu) {
            checkCudaError(cudaMemcpy(*gpu_interval, cpu_interval, 5200UL,
              cudaMemcpyHostToDevice), __FILE__, __LINE__);
          }

          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel184<<<grid, block>>>(*gpu_interval, nsubs - 1,
              *gpu_subs);
          }

          subs_outdatedOnCpu = true;
          q_ok = 0.0;
          err_ok = 0.0;
          first_iteration = true;
          do {
            exitg1 = 0;
            interval_outdatedOnGpu = false;
            x_size_idx_1 = 15 * nsubs;
            ix = -1;
            for (k = 0; k < nsubs; k++) {
              if (subs_outdatedOnCpu) {
                checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                  cudaMemcpyDeviceToHost), __FILE__, __LINE__);
              }

              fc = cpu_subs[k << 1];
              subs_outdatedOnCpu = false;
              b_r = cpu_subs[(k << 1) + 1];
              cpu_r = (fc + b_r) / 2.0;
              delta = (b_r - fc) / 2.0;
              for (lidx = 0; lidx < 15; lidx++) {
                SD->f0.cpu_x_data[(ix + lidx) + 1] = NODES[lidx] * delta + cpu_r;
                interval_outdatedOnGpu = true;
              }

              ix += 15;
            }

            mwGetLaunchParameters1D(computeNumIters(x_size_idx_1 - 1), &grid,
              &block, 2147483647U);
            if (interval_outdatedOnGpu) {
              checkCudaError(cudaMemcpy(*gpu_x_data, SD->f0.cpu_x_data, 77880UL,
                cudaMemcpyHostToDevice), __FILE__, __LINE__);
            }

            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwtAvg_kernel185<<<grid, block>>>(*gpu_x_data, x_size_idx_1 - 1,
                *gpu_xt_data, *b_gpu_x_data);
            }

            guard1 = false;
            if (!first_iteration) {
              checkCudaError(cudaMemcpy(SD->f0.cpu_x_data, *b_gpu_x_data,
                77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
              cpu_r = std::abs(SD->f0.cpu_x_data[0]);
              k = 0;
              exitg2 = false;
              while ((!exitg2) && (k <= x_size_idx_1 - 2)) {
                fc = cpu_r;
                cpu_r = std::abs(SD->f0.cpu_x_data[k + 1]);
                if (std::abs(SD->f0.cpu_x_data[k + 1] - SD->f0.cpu_x_data[k]) <=
                    2.2204460492503131E-14 * std::fmax(fc, cpu_r)) {
                  first_iteration = true;
                  exitg2 = true;
                } else {
                  k++;
                }
              }

              if (first_iteration) {
                mwGetLaunchParameters1D(computeNumIters(static_cast<int16_T>
                  (x_size_idx_1) - 1), &grid, &block, 2147483647U);
                validLaunchParams = mwValidateLaunchParameters(grid, block);
                if (validLaunchParams) {
                  ec_cwtAvg_kernel186<<<grid, block>>>(static_cast<int16_T>
                    (x_size_idx_1) - 1, *d_gpu_fx_data);
                }

                exitg1 = 1;
              } else {
                guard1 = true;
              }
            } else {
              guard1 = true;
            }

            if (guard1) {
              first_iteration = false;
              mwGetLaunchParameters1D(computeNumIters(x_size_idx_1 - 1), &grid,
                &block, 2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel187<<<grid, block>>>(*b_gpu_x_data, x_size_idx_1
                  - 1, *gpu_dv10_data);
              }

              mwGetLaunchParameters1D(computeNumIters(x_size_idx_1 - 1), &grid,
                &block, 2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel188<<<grid, block>>>(*b_gpu_x_data, x_size_idx_1
                  - 1, *gpu_y_data);
              }

              mwGetLaunchParameters1D(computeNumIters(x_size_idx_1 - 1), &grid,
                &block, 2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel189<<<grid, block>>>(*gpu_y_data, x_size_idx_1 -
                  1, *b_gpu_y_data);
              }

              mwGetLaunchParameters1D(computeNumIters(x_size_idx_1 - 1), &grid,
                &block, 2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel190<<<grid, block>>>(*gpu_xt_data, *b_gpu_y_data,
                  *gpu_dv10_data, x_size_idx_1 - 1, *d_gpu_fx_data);
              }

              fx_data_outdatedOnCpu = true;
              cpu_r = 0.0;
              ix = -1;
              for (k = 0; k < nsubs; k++) {
                fc = 0.0;
                b_r = 0.0;
                for (lidx = 0; lidx < 15; lidx++) {
                  if (fx_data_outdatedOnCpu) {
                    checkCudaError(cudaMemcpy(SD->f0.cpu_fx_data, *d_gpu_fx_data,
                      77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                  }

                  fc += dv5[lidx] * SD->f0.cpu_fx_data[(ix + lidx) + 1];
                  fx_data_outdatedOnCpu = false;
                  b_r += dv6[lidx] * SD->f0.cpu_fx_data[(ix + lidx) + 1];
                }

                ix += 15;
                if (subs_outdatedOnCpu) {
                  checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                    cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                }

                subs_outdatedOnCpu = false;
                delta = (cpu_subs[(k << 1) + 1] - cpu_subs[k << 1]) / 2.0;
                fc *= delta;
                qsub[k] = fc;
                cpu_r += fc;
                errsub[k] = b_r * delta;
              }

              intFsq = cpu_r + q_ok;
              delta = std::fmax(1.0E-10, 1.0E-6 * std::abs(intFsq));
              tau = 2.0 * delta;
              cpu_r = 0.0;
              cpu_nrefine = 0;
              for (k = 0; k < nsubs; k++) {
                fc = errsub[k];
                b_r = std::abs(fc);
                if (subs_outdatedOnCpu) {
                  checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                    cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                }

                subs_outdatedOnCpu = false;
                if (b_r <= tau * ((cpu_subs[(k << 1) + 1] - cpu_subs[k << 1]) /
                                  2.0)) {
                  err_ok += fc;
                  q_ok += qsub[k];
                } else {
                  cpu_r += b_r;
                  cpu_nrefine++;
                  cpu_subs[(cpu_nrefine - 1) << 1] = cpu_subs[k << 1];
                  cpu_subs[((cpu_nrefine - 1) << 1) + 1] = cpu_subs[(k << 1) + 1];
                }
              }

              cpu_r += std::abs(err_ok);
              if ((!std::isinf(intFsq)) && (!std::isnan(intFsq)) && ((!std::
                    isinf(cpu_r)) && (!std::isnan(cpu_r))) && (cpu_nrefine != 0)
                  && (!(cpu_r <= delta))) {
                nsubs = cpu_nrefine << 1;
                if (nsubs > 650) {
                  exitg1 = 1;
                } else {
                  for (k = 0; k < cpu_nrefine; k++) {
                    if (subs_outdatedOnCpu) {
                      checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                        cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                    }

                    cpu_subs[((((cpu_nrefine - k) << 1) - 1) << 1) + 1] =
                      cpu_subs[(((cpu_nrefine - k) - 1) << 1) + 1];
                    cpu_subs[(((cpu_nrefine - k) << 1) - 1) << 1] = (cpu_subs
                      [((cpu_nrefine - k) - 1) << 1] + cpu_subs[(((cpu_nrefine -
                      k) - 1) << 1) + 1]) / 2.0;
                    cpu_subs[((((cpu_nrefine - k) << 1) - 2) << 1) + 1] =
                      cpu_subs[(((cpu_nrefine - k) << 1) - 1) << 1];
                    cpu_subs[(((cpu_nrefine - k) << 1) - 2) << 1] = cpu_subs
                      [((cpu_nrefine - k) - 1) << 1];
                    subs_outdatedOnCpu = false;
                  }
                }
              } else {
                exitg1 = 1;
              }
            }
          } while (exitg1 == 0);
        }

        b_r = std::sqrt(3.5421952306087032 * (intDsq / intFsq));
      }
    } else if (cpu_wname[0] == 'a') {
      cf = 6.0;
      b_r = 1.4142135623730951;
    } else {
      cf = 5.0;
      b_r = 5.847705;
    }

    b_r = static_cast<real_T>(cpu_x->size[0]) / (b_r * 2.0);
    first_iteration = false;
    lidx = 0;
    do {
      exitg1 = 0;
      if (lidx + 1 < 6) {
        if (wav_outdatedOnCpu) {
          checkCudaError(cudaMemcpy(cpu_wav, *gpu_wav, 5UL,
            cudaMemcpyDeviceToHost), __FILE__, __LINE__);
        }

        wav_outdatedOnCpu = false;
        if (cv3[lidx] != cpu_wav[lidx]) {
          exitg1 = 1;
        } else {
          lidx++;
        }
      } else {
        first_iteration = true;
        exitg1 = 1;
      }
    } while (exitg1 == 0);

    if (first_iteration) {
      bcoef = 0;
    } else {
      bcoef = -1;
    }

    if (bcoef == 0) {
      if (1.0 - 0.0050536085896138528 * rt_powd_snf(cf, 20.0) * std::exp
          (-rt_powd_snf(cf, 3.0)) >= 0.0) {
        if (1.0 - 0.0050536085896138528 * rt_powd_snf(cf, 20.0) * std::exp
            (-rt_powd_snf(cf, 3.0)) == 1.0) {
          omegac = 9.0856029641606977;
        } else {
          omegac = cf;
        }
      } else {
        a = cf;
        omegac = 9.0856029641606977;
        cpu_r = 1.0 - 0.0050536085896138528 * rt_powd_snf(cf, 20.0) * std::exp
          (-rt_powd_snf(cf, 3.0));
        intDsq = 1.0;
        if (cpu_r == 0.0) {
          omegac = cf;
        } else {
          fc = 1.0;
          b_c = 9.0856029641606977;
          tau = 0.0;
          d = 0.0;
          exitg2 = false;
          while ((!exitg2) && ((intDsq != 0.0) && (a != omegac))) {
            if ((intDsq > 0.0) == (fc > 0.0)) {
              b_c = a;
              fc = cpu_r;
              d = omegac - a;
              tau = d;
            }

            if (std::abs(fc) < std::abs(intDsq)) {
              a = omegac;
              omegac = b_c;
              b_c = a;
              cpu_r = intDsq;
              intDsq = fc;
              fc = cpu_r;
            }

            q_ok = 0.5 * (b_c - omegac);
            err_ok = 4.4408920985006262E-16 * std::fmax(std::abs(omegac), 1.0);
            if ((std::abs(q_ok) <= err_ok) || (intDsq == 0.0)) {
              exitg2 = true;
            } else {
              if ((std::abs(tau) < err_ok) || (std::abs(cpu_r) <= std::abs
                   (intDsq))) {
                d = q_ok;
                tau = q_ok;
              } else {
                s = intDsq / cpu_r;
                if (a == b_c) {
                  cpu_r = 2.0 * q_ok * s;
                  delta = 1.0 - s;
                } else {
                  delta = cpu_r / fc;
                  r = intDsq / fc;
                  cpu_r = s * (2.0 * q_ok * delta * (delta - r) - (omegac - a) *
                               (r - 1.0));
                  delta = (delta - 1.0) * (r - 1.0) * (s - 1.0);
                }

                if (cpu_r > 0.0) {
                  delta = -delta;
                } else {
                  cpu_r = -cpu_r;
                }

                if ((2.0 * cpu_r < 3.0 * q_ok * delta - std::abs(err_ok * delta))
                    && (cpu_r < std::abs(0.5 * tau * delta))) {
                  tau = d;
                  d = cpu_r / delta;
                } else {
                  d = q_ok;
                  tau = q_ok;
                }
              }

              a = omegac;
              cpu_r = intDsq;
              if (std::abs(d) > err_ok) {
                omegac += d;
              } else if (omegac > b_c) {
                omegac -= err_ok;
              } else {
                omegac += err_ok;
              }

              intDsq = 1.0 - 0.0050536085896138528 * rt_powd_snf(omegac, 20.0) *
                std::exp(-rt_powd_snf(omegac, 3.0));
            }
          }
        }
      }
    }

    cpu_r = omegac / 3.1415926535897931;
    if (b_r < cpu_r * rt_powd_snf(2.0, 1.0 / fb_VoicesPerOctave)) {
      b_r = cpu_r * rt_powd_snf(2.0, 1.0 / fb_VoicesPerOctave);
    }

    cpu_r = 1.0 / (b_r * (6.2831853071795862 / cf)) * fs;
    if (fLims[0] < cpu_r) {
      fb_FrequencyLimits[0] = cpu_r;
      freqrange[0] = cpu_r;
    }

    if (fLims[1] > fs / 2.0) {
      fb_FrequencyLimits[1] = fs / 2.0;
      freqrange[1] = fb_FrequencyLimits[1];
    }

    if (freqrange[1] == 0.0) {
      b_r = rtMinusInf;
    } else if (freqrange[1] < 0.0) {
      b_r = rtNaN;
    } else if ((!std::isinf(freqrange[1])) && (!std::isnan(freqrange[1]))) {
      delta = std::frexp(freqrange[1], &eint);
      if (delta == 0.5) {
        b_r = static_cast<real_T>(eint) - 1.0;
      } else if ((eint == 1) && (delta < 0.75)) {
        b_r = std::log(2.0 * delta) / 0.69314718055994529;
      } else {
        b_r = std::log(delta) / 0.69314718055994529 + static_cast<real_T>(eint);
      }
    } else {
      b_r = freqrange[1];
    }

    if (freqrange[0] == 0.0) {
      cpu_r = rtMinusInf;
    } else if (freqrange[0] < 0.0) {
      cpu_r = rtNaN;
    } else if ((!std::isinf(freqrange[0])) && (!std::isnan(freqrange[0]))) {
      delta = std::frexp(freqrange[0], &nx);
      if (delta == 0.5) {
        cpu_r = static_cast<real_T>(nx) - 1.0;
      } else if ((nx == 1) && (delta < 0.75)) {
        cpu_r = std::log(2.0 * delta) / 0.69314718055994529;
      } else {
        cpu_r = std::log(delta) / 0.69314718055994529 + static_cast<real_T>(nx);
      }
    } else {
      cpu_r = freqrange[0];
    }

    if (!(b_r - cpu_r >= 1.0 / fb_VoicesPerOctave)) {
      c_tmpStr = nullptr;
      d_y = nullptr;
      m3 = emlrtCreateCharArray(2, &iv2[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m3, &u[0]);
      emlrtAssign(&d_y, m3);
      e_y = nullptr;
      m4 = emlrtCreateCharArray(2, &iv3[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 5, m4, &b_formatSpec[0]);
      emlrtAssign(&e_y, m4);
      f_y = nullptr;
      m5 = emlrtCreateDoubleScalar(1.0 / fb_VoicesPerOctave);
      emlrtAssign(&f_y, m5);
      emlrtAssign(&c_tmpStr, feval(d_y, e_y, f_y, &emlrtMCI));
      emlrt_marshallIn(length(emlrtAlias(c_tmpStr), &b_emlrtMCI),
                       "<output of length>");
      emxInit_char_T(&d_tmpStr, 2, &u_emlrtRTEI, true);
      emlrt_marshallIn(emlrtAlias(c_tmpStr), "tmpStr", d_tmpStr);
      emxFree_char_T(&d_tmpStr);
      emlrtDestroyArray(&c_tmpStr);
    }
  }

  first_iteration = false;
  lidx = 0;
  do {
    exitg1 = 0;
    if (lidx + 1 < 6) {
      if (cpu_cv[static_cast<int32_T>(c_b[lidx])] != cpu_cv[static_cast<int32_T>
          (cv2[lidx])]) {
        exitg1 = 1;
      } else {
        lidx++;
      }
    } else {
      first_iteration = true;
      exitg1 = 1;
    }
  } while (exitg1 == 0);

  if (!first_iteration) {
    b_nx = 10;
  }

  N = static_cast<uint32_T>(cpu_x->size[0]) + static_cast<uint32_T>(fb_SignalPad
    << 1);
  cpu_nrefine = static_cast<int32_T>(std::trunc(static_cast<real_T>(N) / 2.0));
  emxInit_int32_T(&cpu_omega_tmp1, 2, &emlrtRTEI, true);
  if (cpu_nrefine < 1) {
    cpu_omega_tmp1->size[0] = 1;
    cpu_omega_tmp1->size[1] = 0;
  } else {
    eint = cpu_omega_tmp1->size[0] * cpu_omega_tmp1->size[1];
    cpu_omega_tmp1->size[0] = 1;
    cpu_omega_tmp1->size[1] = cpu_nrefine;
    emxEnsureCapacity_int32_T(cpu_omega_tmp1, eint, &emlrtRTEI);
    mwGetLaunchParameters1D(computeNumIters(cpu_nrefine - 1), &grid, &block,
      2147483647U);
    gpuEmxEnsureCapacity_int32_T(cpu_omega_tmp1, &gpu_omega_tmp1, true);
    c_omega_tmp1_needsGpuEnsureCapa = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel183<<<grid, block>>>(cpu_nrefine - 1, gpu_omega_tmp1);
    }
  }

  emxInit_real_T(&cpu_omega_tmp2, 2, &b_emlrtRTEI, true);
  eint = cpu_omega_tmp2->size[0] * cpu_omega_tmp2->size[1];
  cpu_omega_tmp2->size[0] = 1;
  cpu_omega_tmp2->size[1] = cpu_omega_tmp1->size[1];
  emxEnsureCapacity_real_T(cpu_omega_tmp2, eint, &b_emlrtRTEI);
  bcoef = cpu_omega_tmp1->size[1] - 1;
  mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block, 2147483647U);
  if (c_omega_tmp1_needsGpuEnsureCapa) {
    gpuEmxEnsureCapacity_int32_T(cpu_omega_tmp1, &gpu_omega_tmp1, true);
  }

  gpuEmxEnsureCapacity_real_T(cpu_omega_tmp2, &gpu_omega_tmp2, true);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    ec_cwtAvg_kernel9<<<grid, block>>>(6.2831853071795862 / static_cast<real_T>
      (N), gpu_omega_tmp1, bcoef, gpu_omega_tmp2);
  }

  emxFree_int32_T(&cpu_omega_tmp1);
  cpu_nrefine = static_cast<int32_T>(std::trunc((static_cast<real_T>(N) - 1.0) /
    2.0));
  if (cpu_nrefine < 1) {
    nG = 0;
    cpu_nrefine = 1;
    lidx = -1;
  } else {
    nG = cpu_nrefine - 1;
    cpu_nrefine = -1;
    lidx = 0;
  }

  emxInit_real_T(&cpu_fb_Omega, 2, &f_emlrtRTEI, true);
  eint = cpu_fb_Omega->size[0] * cpu_fb_Omega->size[1];
  cpu_fb_Omega->size[0] = 1;
  cpu_fb_Omega->size[1] = (cpu_omega_tmp2->size[1] + div_s32(lidx - nG,
    cpu_nrefine)) + 2;
  emxEnsureCapacity_real_T(cpu_fb_Omega, eint, &c_emlrtRTEI);
  gpuEmxEnsureCapacity_real_T(cpu_fb_Omega, &gpu_fb_Omega, true);
  ec_cwtAvg_kernel10<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_fb_Omega);
  nsubs = cpu_omega_tmp2->size[1];
  mwGetLaunchParameters1D(computeNumIters(nsubs - 1), &grid, &block, 2147483647U);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    ec_cwtAvg_kernel11<<<grid, block>>>(gpu_omega_tmp2, nsubs - 1, gpu_fb_Omega);
  }

  nsubs = div_s32(lidx - nG, cpu_nrefine);
  mwGetLaunchParameters1D(computeNumIters(nsubs), &grid, &block, 2147483647U);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    ec_cwtAvg_kernel12<<<grid, block>>>(cpu_nrefine, nG, gpu_omega_tmp2, nsubs,
      gpu_fb_Omega, cpu_omega_tmp2->size[1U]);
  }

  fb_Omega_outdatedOnCpu = true;
  emxFree_real_T(&cpu_omega_tmp2);
  for (bcoef = 0; bcoef < 2; bcoef++) {
    b_b[bcoef] = std::isnan(fb_FrequencyLimits[bcoef]);
  }

  first_iteration = true;
  k = 0;
  exitg2 = false;
  while ((!exitg2) && (k < 2)) {
    if (!b_b[k]) {
      first_iteration = false;
      exitg2 = true;
    } else {
      k++;
    }
  }

  emxInit_real_T(&cpu_fb_Scales, 2, &f_emlrtRTEI, true);
  if (!first_iteration) {
    for (bcoef = 0; bcoef < 2; bcoef++) {
      NyquistRange[bcoef] = fb_FrequencyLimits[bcoef] / fs * 2.0 *
        3.1415926535897931;
    }

    for (k = 0; k < 5; k++) {
      cpu_wname[k] = cpu_cv[static_cast<int32_T>(c_b[k])];
    }

    if (cpu_wname[0] == 'm') {
      cpu_r = 1.8820720577620569;
    } else {
      lidx = 1;
      if (cpu_wname[0] == 'a') {
        lidx = 2;
      }

      if (lidx > 1) {
        cpu_r = 6.0;
      } else {
        cpu_r = 5.0;
      }
    }

    b_r = cpu_r / NyquistRange[1];
    cpu_r = cpu_r / NyquistRange[0] / b_r;
    if (cpu_r == 0.0) {
      cpu_r = rtMinusInf;
    } else if (cpu_r < 0.0) {
      cpu_r = rtNaN;
    } else if ((!std::isinf(cpu_r)) && (!std::isnan(cpu_r))) {
      cpu_r = std::frexp(cpu_r, &b_eint);
      if (cpu_r == 0.5) {
        cpu_r = static_cast<real_T>(b_eint) - 1.0;
      } else if ((b_eint == 1) && (cpu_r < 0.75)) {
        cpu_r = std::log(2.0 * cpu_r) / 0.69314718055994529;
      } else {
        cpu_r = std::log(cpu_r) / 0.69314718055994529 + static_cast<real_T>
          (b_eint);
      }
    }

    emxInit_real_T(&cpu_y, 2, &bd_emlrtRTEI, true);
    cpu_r *= fb_VoicesPerOctave;
    if (std::isnan(cpu_r)) {
      eint = cpu_y->size[0] * cpu_y->size[1];
      cpu_y->size[0] = 1;
      cpu_y->size[1] = 1;
      emxEnsureCapacity_real_T(cpu_y, eint, &d_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(cpu_y, &gpu_y, true);
      y_needsGpuEnsureCapacity = false;
      ec_cwtAvg_kernel13<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_y);
    } else if (cpu_r < 0.0) {
      cpu_y->size[0] = 1;
      cpu_y->size[1] = 0;
    } else {
      eint = cpu_y->size[0] * cpu_y->size[1];
      cpu_y->size[0] = 1;
      cpu_y->size[1] = static_cast<int32_T>(cpu_r) + 1;
      emxEnsureCapacity_real_T(cpu_y, eint, &d_emlrtRTEI);
      mwGetLaunchParameters1D(computeNumIters(static_cast<int32_T>(cpu_r)),
        &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(cpu_y, &gpu_y, true);
      y_needsGpuEnsureCapacity = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel154<<<grid, block>>>(static_cast<int32_T>(cpu_r), gpu_y);
      }
    }

    emxInit_real_T(&b_cpu_y, 2, &cd_emlrtRTEI, true);
    eint = b_cpu_y->size[0] * b_cpu_y->size[1];
    b_cpu_y->size[0] = 1;
    b_cpu_y->size[1] = cpu_y->size[1];
    emxEnsureCapacity_real_T(b_cpu_y, eint, &e_emlrtRTEI);
    cpu_nrefine = cpu_y->size[1];
    mwGetLaunchParameters1D(computeNumIters(cpu_nrefine - 1), &grid, &block,
      2147483647U);
    if (y_needsGpuEnsureCapacity) {
      gpuEmxEnsureCapacity_real_T(cpu_y, &gpu_y, true);
    }

    gpuEmxEnsureCapacity_real_T(b_cpu_y, &b_gpu_y, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel14<<<grid, block>>>(gpu_y, rt_powd_snf(2.0, 1.0 /
        fb_VoicesPerOctave), cpu_nrefine - 1, b_gpu_y);
    }

    emxFree_real_T(&cpu_y);
    eint = cpu_fb_Scales->size[0] * cpu_fb_Scales->size[1];
    cpu_fb_Scales->size[0] = 1;
    cpu_fb_Scales->size[1] = b_cpu_y->size[1];
    emxEnsureCapacity_real_T(cpu_fb_Scales, eint, &f_emlrtRTEI);
    bcoef = b_cpu_y->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real_T(cpu_fb_Scales, &gpu_fb_Scales, true);
    c_fb_Scales_needsGpuEnsureCapac = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel15<<<grid, block>>>(b_gpu_y, b_r, bcoef, gpu_fb_Scales);
    }

    fb_Scales_outdatedOnCpu = true;
    emxFree_real_T(&b_cpu_y);
  } else {
    omegac = 3.1415926535897931;
    ec_cwtAvg_kernel155<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*global_gpu_cv,
      *gpu_wav, *gpu_wname, c_b[0], c_b[1], c_b[2], c_b[3], c_b[4]);
    wav_outdatedOnCpu = true;
    checkCudaError(cudaMemcpy(cpu_wav, *gpu_wav, 5UL, cudaMemcpyDeviceToHost),
                   __FILE__, __LINE__);
    if (cpu_wav[0] == 'm') {
      a = 1.8820720577620569;
      r = 0.0057083835261;
      cpu_r = 0.0057083835261;
      b_r = 0.0057083835261;
      for (nG = 0; nG < 6; nG++) {
        fc = c[nG];
        r = r * 0.005353955978584176 + fc;
        cpu_r = cpu_r * 0.005353955978584176 + fc;
        b_r = b_r * 0.005353955978584176 + fc;
      }

      r /= 13.666666666666666;
      cpu_r /= 13.666666666666666;
      b_r /= 13.666666666666666;
      b_r = std::sqrt((std::exp((cpu_table100[12] + 7.7183093240718676) - (((r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703)) + std::
                       exp((cpu_table100[14] + 2.5377749931802178) - (((cpu_r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703))) - std::
                      exp((cpu_table100[13] + 5.8211893391859881) - (((b_r +
        0.91893853320467278) - 1.307479889018099) + 22.071116966494703)));
      if (std::isinf(b_r) || std::isnan(b_r)) {
        ec_cwtAvg_kernel156<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
          (*gpu_interval);
        ec_cwtAvg_kernel157<<<dim3(6U, 1U, 1U), dim3(128U, 1U, 1U)>>>
          (*gpu_interval);
        interval_outdatedOnGpu = false;
        intDsq = 0.0;
        cpu_nrefine = 1;
        checkCudaError(cudaMemcpy(cpu_interval, *gpu_interval, 5200UL,
          cudaMemcpyDeviceToHost), __FILE__, __LINE__);
        nG = static_cast<int32_T>(cpu_interval[1]) - static_cast<int32_T>
          (cpu_interval[0]);
        if (nG > 0) {
          n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::abs
            (cpu_interval[1] - cpu_interval[0])) * 10 - 1);
          nsubs = n_idx_0 + 1;
          if (n_idx_0 + 2 > 2) {
            cpu_nrefine = n_idx_0;
            cpu_interval[n_idx_0 + 1] = cpu_interval[1];
            interval_outdatedOnGpu = true;
            delta = (cpu_interval[1] - cpu_interval[0]) / (static_cast<real_T>
              (n_idx_0) + 1.0);
            for (lidx = 0; lidx < cpu_nrefine; lidx++) {
              cpu_interval[n_idx_0 - lidx] = cpu_interval[0] +
                static_cast<real_T>(n_idx_0 - lidx) * delta;
            }
          }

          cpu_nrefine = n_idx_0 + 1;
        } else {
          nsubs = 1;
        }

        lidx = 0;
        for (ix = 0; ix < cpu_nrefine; ix++) {
          if (std::abs(cpu_interval[ix + 1] - cpu_interval[lidx]) > 0.0) {
            lidx++;
            cpu_interval[lidx] = cpu_interval[ix + 1];
            interval_outdatedOnGpu = true;
          } else {
            nsubs--;
          }
        }

        if (nsubs + 1 < 2) {
          if (interval_outdatedOnGpu) {
            checkCudaError(cudaMemcpy(*gpu_interval, cpu_interval, 5200UL,
              cudaMemcpyHostToDevice), __FILE__, __LINE__);
          }

          ec_cwtAvg_kernel158<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
            (cpu_nrefine, *gpu_interval);
          interval_outdatedOnGpu = false;
          nsubs = 1;
        }

        if (nG <= 0) {
          intDsq = rtNaN;
        } else {
          mwGetLaunchParameters1D(computeNumIters(nsubs - 1), &grid, &block,
            2147483647U);
          if (interval_outdatedOnGpu) {
            checkCudaError(cudaMemcpy(*gpu_interval, cpu_interval, 5200UL,
              cudaMemcpyHostToDevice), __FILE__, __LINE__);
          }

          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel173<<<grid, block>>>(*gpu_interval, nsubs - 1,
              *gpu_subs);
          }

          subs_outdatedOnCpu = true;
          q_ok = 0.0;
          err_ok = 0.0;
          do {
            exitg1 = 0;
            interval_outdatedOnGpu = false;
            x_size_idx_1 = 15 * nsubs;
            ix = -1;
            for (k = 0; k < nsubs; k++) {
              if (subs_outdatedOnCpu) {
                checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                  cudaMemcpyDeviceToHost), __FILE__, __LINE__);
              }

              fc = cpu_subs[k << 1];
              subs_outdatedOnCpu = false;
              b_r = cpu_subs[(k << 1) + 1];
              cpu_r = (fc + b_r) / 2.0;
              delta = (b_r - fc) / 2.0;
              for (lidx = 0; lidx < 15; lidx++) {
                SD->f0.cpu_x_data[(ix + lidx) + 1] = NODES[lidx] * delta + cpu_r;
                interval_outdatedOnGpu = true;
              }

              ix += 15;
            }

            b_xt_size[0] = 1;
            b_xt_size[1] = x_size_idx_1;
            mwGetLaunchParameters1D(computeNumIters(x_size_idx_1 - 1), &grid,
              &block, 2147483647U);
            if (interval_outdatedOnGpu) {
              checkCudaError(cudaMemcpy(*gpu_x_data, SD->f0.cpu_x_data, 77880UL,
                cudaMemcpyHostToDevice), __FILE__, __LINE__);
            }

            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwtAvg_kernel174<<<grid, block>>>(*gpu_x_data, x_size_idx_1 - 1,
                *gpu_xt_data, *b_gpu_x_data);
            }

            guard1 = false;
            if (!first_iteration) {
              checkCudaError(cudaMemcpy(SD->f0.cpu_x_data, *b_gpu_x_data,
                77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
              cpu_r = std::abs(SD->f0.cpu_x_data[0]);
              k = 0;
              exitg2 = false;
              while ((!exitg2) && (k <= x_size_idx_1 - 2)) {
                fc = cpu_r;
                cpu_r = std::abs(SD->f0.cpu_x_data[k + 1]);
                if (std::abs(SD->f0.cpu_x_data[k + 1] - SD->f0.cpu_x_data[k]) <=
                    2.2204460492503131E-14 * std::fmax(fc, cpu_r)) {
                  first_iteration = true;
                  exitg2 = true;
                } else {
                  k++;
                }
              }

              if (first_iteration) {
                mwGetLaunchParameters1D(computeNumIters(static_cast<int16_T>
                  (x_size_idx_1) - 1), &grid, &block, 2147483647U);
                validLaunchParams = mwValidateLaunchParameters(grid, block);
                if (validLaunchParams) {
                  ec_cwtAvg_kernel175<<<grid, block>>>(static_cast<int16_T>
                    (x_size_idx_1) - 1, *c_gpu_fx_data);
                }

                exitg1 = 1;
              } else {
                guard1 = true;
              }
            } else {
              guard1 = true;
            }

            if (guard1) {
              first_iteration = false;
              mwGetLaunchParameters1D(computeNumIters(x_size_idx_1 - 1), &grid,
                &block, 2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel176<<<grid, block>>>(*b_gpu_x_data, x_size_idx_1
                  - 1, *gpu_y_data);
              }

              mwGetLaunchParameters1D(computeNumIters(x_size_idx_1 - 1), &grid,
                &block, 2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel177<<<grid, block>>>(*b_gpu_x_data, x_size_idx_1
                  - 1, *b_gpu_y_data);
              }

              b_a_size[1] = x_size_idx_1;
              mwGetLaunchParameters1D(computeNumIters(x_size_idx_1 - 1), &grid,
                &block, 2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel178<<<grid, block>>>(*b_gpu_y_data, *gpu_y_data,
                  x_size_idx_1 - 1, *b_gpu_a_data);
              }

              dv11_size[0] = 1;
              dv11_size[1] = b_a_size[1];
              mwGetLaunchParameters1D(computeNumIters(b_a_size[1] - 1), &grid,
                &block, 2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel179<<<grid, block>>>(*b_gpu_a_data, b_a_size[1]
                  - 1, *gpu_dv11_data);
              }

              mwGetLaunchParameters1D(computeNumIters(x_size_idx_1 - 1), &grid,
                &block, 2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel180<<<grid, block>>>(*b_gpu_x_data, x_size_idx_1
                  - 1, *gpu_y_data);
              }

              dv13_size[0] = 1;
              dv13_size[1] = x_size_idx_1;
              mwGetLaunchParameters1D(computeNumIters(x_size_idx_1 - 1), &grid,
                &block, 2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel181<<<grid, block>>>(*gpu_y_data, x_size_idx_1 -
                  1, *b_gpu_y_data);
              }

              if (b_a_size[1] == x_size_idx_1) {
                fx_size[0] = 1;
                fx_size[1] = b_a_size[1];
                mwGetLaunchParameters1D(computeNumIters(b_a_size[1] - 1), &grid,
                  &block, 2147483647U);
                validLaunchParams = mwValidateLaunchParameters(grid, block);
                if (validLaunchParams) {
                  ec_cwtAvg_kernel182<<<grid, block>>>(*gpu_xt_data,
                    *b_gpu_y_data, *gpu_dv11_data, b_a_size[1] - 1,
                    *c_gpu_fx_data);
                }

                b_fx_data_outdatedOnCpu = true;
              } else {
                if (b_fx_data_outdatedOnCpu) {
                  checkCudaError(cudaMemcpy(cpu_fx_data, *c_gpu_fx_data, 77880UL,
                    cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                }

                checkCudaError(cudaMemcpy(cpu_dv11_data, *gpu_dv11_data, 77880UL,
                  cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                checkCudaError(cudaMemcpy(SD->f0.cpu_x_data, *b_gpu_y_data,
                  77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                checkCudaError(cudaMemcpy(SD->f0.cpu_xt_data, *gpu_xt_data,
                  77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                binary_expand_op_7(cpu_fx_data, fx_size, cpu_dv11_data,
                                   dv11_size, SD->f0.cpu_x_data, dv13_size,
                                   SD->f0.cpu_xt_data, b_xt_size);
                b_fx_data_outdatedOnCpu = false;
              }

              cpu_r = 0.0;
              ix = -1;
              for (k = 0; k < nsubs; k++) {
                fc = 0.0;
                b_r = 0.0;
                for (lidx = 0; lidx < 15; lidx++) {
                  if (b_fx_data_outdatedOnCpu) {
                    checkCudaError(cudaMemcpy(cpu_fx_data, *c_gpu_fx_data,
                      77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                  }

                  fc += dv5[lidx] * cpu_fx_data[(ix + lidx) + 1];
                  b_fx_data_outdatedOnCpu = false;
                  b_r += dv6[lidx] * cpu_fx_data[(ix + lidx) + 1];
                }

                ix += 15;
                if (subs_outdatedOnCpu) {
                  checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                    cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                }

                subs_outdatedOnCpu = false;
                delta = (cpu_subs[(k << 1) + 1] - cpu_subs[k << 1]) / 2.0;
                fc *= delta;
                qsub[k] = fc;
                cpu_r += fc;
                errsub[k] = b_r * delta;
              }

              intDsq = cpu_r + q_ok;
              delta = std::fmax(1.0E-10, 1.0E-6 * std::abs(intDsq));
              tau = 2.0 * delta;
              cpu_r = 0.0;
              cpu_nrefine = 0;
              for (k = 0; k < nsubs; k++) {
                fc = errsub[k];
                b_r = std::abs(fc);
                if (subs_outdatedOnCpu) {
                  checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                    cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                }

                subs_outdatedOnCpu = false;
                if (b_r <= tau * ((cpu_subs[(k << 1) + 1] - cpu_subs[k << 1]) /
                                  2.0)) {
                  err_ok += fc;
                  q_ok += qsub[k];
                } else {
                  cpu_r += b_r;
                  cpu_nrefine++;
                  cpu_subs[(cpu_nrefine - 1) << 1] = cpu_subs[k << 1];
                  cpu_subs[((cpu_nrefine - 1) << 1) + 1] = cpu_subs[(k << 1) + 1];
                }
              }

              cpu_r += std::abs(err_ok);
              if ((!std::isinf(intDsq)) && (!std::isnan(intDsq)) && ((!std::
                    isinf(cpu_r)) && (!std::isnan(cpu_r))) && (cpu_nrefine != 0)
                  && (!(cpu_r <= delta))) {
                nsubs = cpu_nrefine << 1;
                if (nsubs > 650) {
                  exitg1 = 1;
                } else {
                  for (k = 0; k < cpu_nrefine; k++) {
                    if (subs_outdatedOnCpu) {
                      checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                        cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                    }

                    cpu_subs[((((cpu_nrefine - k) << 1) - 1) << 1) + 1] =
                      cpu_subs[(((cpu_nrefine - k) - 1) << 1) + 1];
                    cpu_subs[(((cpu_nrefine - k) << 1) - 1) << 1] = (cpu_subs
                      [((cpu_nrefine - k) - 1) << 1] + cpu_subs[(((cpu_nrefine -
                      k) - 1) << 1) + 1]) / 2.0;
                    cpu_subs[((((cpu_nrefine - k) << 1) - 2) << 1) + 1] =
                      cpu_subs[(((cpu_nrefine - k) << 1) - 1) << 1];
                    cpu_subs[(((cpu_nrefine - k) << 1) - 2) << 1] = cpu_subs
                      [((cpu_nrefine - k) - 1) << 1];
                    subs_outdatedOnCpu = false;
                  }
                }
              } else {
                exitg1 = 1;
              }
            }
          } while (exitg1 == 0);
        }

        ec_cwtAvg_kernel159<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
          (*gpu_interval);
        ec_cwtAvg_kernel160<<<dim3(6U, 1U, 1U), dim3(128U, 1U, 1U)>>>
          (*gpu_interval);
        interval_outdatedOnGpu = false;
        intFsq = 0.0;
        cpu_nrefine = 1;
        checkCudaError(cudaMemcpy(cpu_interval, *gpu_interval, 5200UL,
          cudaMemcpyDeviceToHost), __FILE__, __LINE__);
        nG = static_cast<int32_T>(cpu_interval[1]) - static_cast<int32_T>
          (cpu_interval[0]);
        if (nG > 0) {
          n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::abs
            (cpu_interval[1] - cpu_interval[0])) * 10 - 1);
          nsubs = n_idx_0 + 1;
          if (n_idx_0 + 2 > 2) {
            cpu_nrefine = n_idx_0;
            cpu_interval[n_idx_0 + 1] = cpu_interval[1];
            interval_outdatedOnGpu = true;
            delta = (cpu_interval[1] - cpu_interval[0]) / (static_cast<real_T>
              (n_idx_0) + 1.0);
            for (lidx = 0; lidx < cpu_nrefine; lidx++) {
              cpu_interval[n_idx_0 - lidx] = cpu_interval[0] +
                static_cast<real_T>(n_idx_0 - lidx) * delta;
            }
          }

          cpu_nrefine = n_idx_0 + 1;
        } else {
          nsubs = 1;
        }

        lidx = 0;
        for (ix = 0; ix < cpu_nrefine; ix++) {
          if (std::abs(cpu_interval[ix + 1] - cpu_interval[lidx]) > 0.0) {
            lidx++;
            cpu_interval[lidx] = cpu_interval[ix + 1];
            interval_outdatedOnGpu = true;
          } else {
            nsubs--;
          }
        }

        if (nsubs + 1 < 2) {
          if (interval_outdatedOnGpu) {
            checkCudaError(cudaMemcpy(*gpu_interval, cpu_interval, 5200UL,
              cudaMemcpyHostToDevice), __FILE__, __LINE__);
          }

          ec_cwtAvg_kernel161<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
            (cpu_nrefine, *gpu_interval);
          interval_outdatedOnGpu = false;
          nsubs = 1;
        }

        if (nG <= 0) {
          intFsq = rtNaN;
        } else {
          mwGetLaunchParameters1D(computeNumIters(nsubs - 1), &grid, &block,
            2147483647U);
          if (interval_outdatedOnGpu) {
            checkCudaError(cudaMemcpy(*gpu_interval, cpu_interval, 5200UL,
              cudaMemcpyHostToDevice), __FILE__, __LINE__);
          }

          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel166<<<grid, block>>>(*gpu_interval, nsubs - 1,
              *gpu_subs);
          }

          subs_outdatedOnCpu = true;
          q_ok = 0.0;
          err_ok = 0.0;
          first_iteration = true;
          do {
            exitg1 = 0;
            interval_outdatedOnGpu = false;
            x_size_idx_1 = 15 * nsubs;
            ix = -1;
            for (k = 0; k < nsubs; k++) {
              if (subs_outdatedOnCpu) {
                checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                  cudaMemcpyDeviceToHost), __FILE__, __LINE__);
              }

              fc = cpu_subs[k << 1];
              subs_outdatedOnCpu = false;
              b_r = cpu_subs[(k << 1) + 1];
              cpu_r = (fc + b_r) / 2.0;
              delta = (b_r - fc) / 2.0;
              for (lidx = 0; lidx < 15; lidx++) {
                SD->f0.cpu_x_data[(ix + lidx) + 1] = NODES[lidx] * delta + cpu_r;
                interval_outdatedOnGpu = true;
              }

              ix += 15;
            }

            mwGetLaunchParameters1D(computeNumIters(x_size_idx_1 - 1), &grid,
              &block, 2147483647U);
            if (interval_outdatedOnGpu) {
              checkCudaError(cudaMemcpy(*gpu_x_data, SD->f0.cpu_x_data, 77880UL,
                cudaMemcpyHostToDevice), __FILE__, __LINE__);
            }

            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwtAvg_kernel167<<<grid, block>>>(*gpu_x_data, x_size_idx_1 - 1,
                *gpu_xt_data, *b_gpu_x_data);
            }

            guard1 = false;
            if (!first_iteration) {
              checkCudaError(cudaMemcpy(SD->f0.cpu_x_data, *b_gpu_x_data,
                77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
              cpu_r = std::abs(SD->f0.cpu_x_data[0]);
              k = 0;
              exitg2 = false;
              while ((!exitg2) && (k <= x_size_idx_1 - 2)) {
                fc = cpu_r;
                cpu_r = std::abs(SD->f0.cpu_x_data[k + 1]);
                if (std::abs(SD->f0.cpu_x_data[k + 1] - SD->f0.cpu_x_data[k]) <=
                    2.2204460492503131E-14 * std::fmax(fc, cpu_r)) {
                  first_iteration = true;
                  exitg2 = true;
                } else {
                  k++;
                }
              }

              if (first_iteration) {
                mwGetLaunchParameters1D(computeNumIters(static_cast<int16_T>
                  (x_size_idx_1) - 1), &grid, &block, 2147483647U);
                validLaunchParams = mwValidateLaunchParameters(grid, block);
                if (validLaunchParams) {
                  ec_cwtAvg_kernel168<<<grid, block>>>(static_cast<int16_T>
                    (x_size_idx_1) - 1, *b_gpu_fx_data);
                }

                exitg1 = 1;
              } else {
                guard1 = true;
              }
            } else {
              guard1 = true;
            }

            if (guard1) {
              first_iteration = false;
              mwGetLaunchParameters1D(computeNumIters(x_size_idx_1 - 1), &grid,
                &block, 2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel169<<<grid, block>>>(*b_gpu_x_data, x_size_idx_1
                  - 1, *gpu_dv15_data);
              }

              mwGetLaunchParameters1D(computeNumIters(x_size_idx_1 - 1), &grid,
                &block, 2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel170<<<grid, block>>>(*b_gpu_x_data, x_size_idx_1
                  - 1, *gpu_y_data);
              }

              mwGetLaunchParameters1D(computeNumIters(x_size_idx_1 - 1), &grid,
                &block, 2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel171<<<grid, block>>>(*gpu_y_data, x_size_idx_1 -
                  1, *b_gpu_y_data);
              }

              mwGetLaunchParameters1D(computeNumIters(x_size_idx_1 - 1), &grid,
                &block, 2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel172<<<grid, block>>>(*gpu_xt_data, *b_gpu_y_data,
                  *gpu_dv15_data, x_size_idx_1 - 1, *b_gpu_fx_data);
              }

              b_fx_data_outdatedOnCpu = true;
              cpu_r = 0.0;
              ix = -1;
              for (k = 0; k < nsubs; k++) {
                fc = 0.0;
                b_r = 0.0;
                for (lidx = 0; lidx < 15; lidx++) {
                  if (b_fx_data_outdatedOnCpu) {
                    checkCudaError(cudaMemcpy(SD->f0.cpu_fx_data, *b_gpu_fx_data,
                      77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                  }

                  fc += dv5[lidx] * SD->f0.cpu_fx_data[(ix + lidx) + 1];
                  b_fx_data_outdatedOnCpu = false;
                  b_r += dv6[lidx] * SD->f0.cpu_fx_data[(ix + lidx) + 1];
                }

                ix += 15;
                if (subs_outdatedOnCpu) {
                  checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                    cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                }

                subs_outdatedOnCpu = false;
                delta = (cpu_subs[(k << 1) + 1] - cpu_subs[k << 1]) / 2.0;
                fc *= delta;
                qsub[k] = fc;
                cpu_r += fc;
                errsub[k] = b_r * delta;
              }

              intFsq = cpu_r + q_ok;
              delta = std::fmax(1.0E-10, 1.0E-6 * std::abs(intFsq));
              tau = 2.0 * delta;
              cpu_r = 0.0;
              cpu_nrefine = 0;
              for (k = 0; k < nsubs; k++) {
                fc = errsub[k];
                b_r = std::abs(fc);
                if (subs_outdatedOnCpu) {
                  checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                    cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                }

                subs_outdatedOnCpu = false;
                if (b_r <= tau * ((cpu_subs[(k << 1) + 1] - cpu_subs[k << 1]) /
                                  2.0)) {
                  err_ok += fc;
                  q_ok += qsub[k];
                } else {
                  cpu_r += b_r;
                  cpu_nrefine++;
                  cpu_subs[(cpu_nrefine - 1) << 1] = cpu_subs[k << 1];
                  cpu_subs[((cpu_nrefine - 1) << 1) + 1] = cpu_subs[(k << 1) + 1];
                }
              }

              cpu_r += std::abs(err_ok);
              if ((!std::isinf(intFsq)) && (!std::isnan(intFsq)) && ((!std::
                    isinf(cpu_r)) && (!std::isnan(cpu_r))) && (cpu_nrefine != 0)
                  && (!(cpu_r <= delta))) {
                nsubs = cpu_nrefine << 1;
                if (nsubs > 650) {
                  exitg1 = 1;
                } else {
                  for (k = 0; k < cpu_nrefine; k++) {
                    if (subs_outdatedOnCpu) {
                      checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                        cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                    }

                    cpu_subs[((((cpu_nrefine - k) << 1) - 1) << 1) + 1] =
                      cpu_subs[(((cpu_nrefine - k) - 1) << 1) + 1];
                    cpu_subs[(((cpu_nrefine - k) << 1) - 1) << 1] = (cpu_subs
                      [((cpu_nrefine - k) - 1) << 1] + cpu_subs[(((cpu_nrefine -
                      k) - 1) << 1) + 1]) / 2.0;
                    cpu_subs[((((cpu_nrefine - k) << 1) - 2) << 1) + 1] =
                      cpu_subs[(((cpu_nrefine - k) << 1) - 1) << 1];
                    cpu_subs[(((cpu_nrefine - k) << 1) - 2) << 1] = cpu_subs
                      [((cpu_nrefine - k) - 1) << 1];
                    subs_outdatedOnCpu = false;
                  }
                }
              } else {
                exitg1 = 1;
              }
            }
          } while (exitg1 == 0);
        }

        b_r = std::sqrt(3.5421952306087032 * (intDsq / intFsq));
      }
    } else if (cpu_wav[0] == 'a') {
      a = 6.0;
      b_r = 1.4142135623730951;
    } else {
      a = 5.0;
      b_r = 5.847705;
    }

    intFsq = static_cast<real_T>(cpu_x->size[0]) / (b_r * 2.0);
    first_iteration = false;
    lidx = 0;
    do {
      exitg1 = 0;
      if (lidx + 1 < 6) {
        if (wav_outdatedOnCpu) {
          checkCudaError(cudaMemcpy(cpu_wname, *gpu_wname, 5UL,
            cudaMemcpyDeviceToHost), __FILE__, __LINE__);
        }

        wav_outdatedOnCpu = false;
        if (cv3[lidx] != cpu_wname[lidx]) {
          exitg1 = 1;
        } else {
          lidx++;
        }
      } else {
        first_iteration = true;
        exitg1 = 1;
      }
    } while (exitg1 == 0);

    if (first_iteration) {
      bcoef = 0;
    } else {
      bcoef = -1;
    }

    if (bcoef == 0) {
      b_r = 2.0 * (static_cast<real_T>(b_nx) / 100.0);
      if (b_r - 0.0050536085896138528 * rt_powd_snf(a, 20.0) * std::exp
          (-rt_powd_snf(a, 3.0)) >= 0.0) {
        if (b_r == b_r - 0.0050536085896138528 * rt_powd_snf(a, 20.0) * std::exp
            (-rt_powd_snf(a, 3.0))) {
          omegac = 9.0856029641606977;
        } else {
          omegac = a;
        }
      } else {
        omegac = 9.0856029641606977;
        cpu_r = b_r - 0.0050536085896138528 * rt_powd_snf(a, 20.0) * std::exp
          (-rt_powd_snf(a, 3.0));
        intDsq = b_r;
        if (cpu_r == 0.0) {
          omegac = a;
        } else {
          fc = b_r;
          b_c = 9.0856029641606977;
          tau = 0.0;
          d = 0.0;
          exitg2 = false;
          while ((!exitg2) && ((intDsq != 0.0) && (a != omegac))) {
            if ((intDsq > 0.0) == (fc > 0.0)) {
              b_c = a;
              fc = cpu_r;
              d = omegac - a;
              tau = d;
            }

            if (std::abs(fc) < std::abs(intDsq)) {
              a = omegac;
              omegac = b_c;
              b_c = a;
              cpu_r = intDsq;
              intDsq = fc;
              fc = cpu_r;
            }

            q_ok = 0.5 * (b_c - omegac);
            err_ok = 4.4408920985006262E-16 * std::fmax(std::abs(omegac), 1.0);
            if ((std::abs(q_ok) <= err_ok) || (intDsq == 0.0)) {
              exitg2 = true;
            } else {
              if ((std::abs(tau) < err_ok) || (std::abs(cpu_r) <= std::abs
                   (intDsq))) {
                d = q_ok;
                tau = q_ok;
              } else {
                s = intDsq / cpu_r;
                if (a == b_c) {
                  cpu_r = 2.0 * q_ok * s;
                  delta = 1.0 - s;
                } else {
                  delta = cpu_r / fc;
                  r = intDsq / fc;
                  cpu_r = s * (2.0 * q_ok * delta * (delta - r) - (omegac - a) *
                               (r - 1.0));
                  delta = (delta - 1.0) * (r - 1.0) * (s - 1.0);
                }

                if (cpu_r > 0.0) {
                  delta = -delta;
                } else {
                  cpu_r = -cpu_r;
                }

                if ((2.0 * cpu_r < 3.0 * q_ok * delta - std::abs(err_ok * delta))
                    && (cpu_r < std::abs(0.5 * tau * delta))) {
                  tau = d;
                  d = cpu_r / delta;
                } else {
                  d = q_ok;
                  tau = q_ok;
                }
              }

              a = omegac;
              cpu_r = intDsq;
              if (std::abs(d) > err_ok) {
                omegac += d;
              } else if (omegac > b_c) {
                omegac -= err_ok;
              } else {
                omegac += err_ok;
              }

              intDsq = b_r - 0.0050536085896138528 * rt_powd_snf(omegac, 20.0) *
                std::exp(-rt_powd_snf(omegac, 3.0));
            }
          }
        }
      }
    }

    b_r = omegac / 3.1415926535897931;
    if (intFsq < b_r * rt_powd_snf(2.0, 1.0 / fb_VoicesPerOctave)) {
      intFsq = b_r * rt_powd_snf(2.0, 1.0 / fb_VoicesPerOctave);
    }

    fc = intFsq / b_r;
    if (fc == 0.0) {
      fc = rtMinusInf;
    } else if (fc < 0.0) {
      fc = rtNaN;
    } else if ((!std::isinf(fc)) && (!std::isnan(fc))) {
      fc = std::frexp(fc, &b_eint);
      if (fc == 0.5) {
        fc = static_cast<real_T>(b_eint) - 1.0;
      } else if ((b_eint == 1) && (fc < 0.75)) {
        fc = std::log(2.0 * fc) / 0.69314718055994529;
      } else {
        fc = std::log(fc) / 0.69314718055994529 + static_cast<real_T>(b_eint);
      }
    }

    emxInit_real_T(&c_cpu_y, 2, &hd_emlrtRTEI, true);
    cpu_r = std::fmax(fc, 1.0 / fb_VoicesPerOctave) * fb_VoicesPerOctave;
    if (std::isnan(cpu_r)) {
      eint = c_cpu_y->size[0] * c_cpu_y->size[1];
      c_cpu_y->size[0] = 1;
      c_cpu_y->size[1] = 1;
      emxEnsureCapacity_real_T(c_cpu_y, eint, &d_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(c_cpu_y, &o_gpu_y, true);
      b_y_needsGpuEnsureCapacity = false;
      ec_cwtAvg_kernel162<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(o_gpu_y);
    } else if (cpu_r < 0.0) {
      c_cpu_y->size[0] = 1;
      c_cpu_y->size[1] = 0;
    } else {
      eint = c_cpu_y->size[0] * c_cpu_y->size[1];
      c_cpu_y->size[0] = 1;
      c_cpu_y->size[1] = static_cast<int32_T>(cpu_r) + 1;
      emxEnsureCapacity_real_T(c_cpu_y, eint, &d_emlrtRTEI);
      mwGetLaunchParameters1D(computeNumIters(static_cast<int32_T>(cpu_r)),
        &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(c_cpu_y, &o_gpu_y, true);
      b_y_needsGpuEnsureCapacity = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel165<<<grid, block>>>(static_cast<int32_T>(cpu_r),
          o_gpu_y);
      }
    }

    emxInit_real_T(&d_cpu_y, 2, &jd_emlrtRTEI, true);
    eint = d_cpu_y->size[0] * d_cpu_y->size[1];
    d_cpu_y->size[0] = 1;
    d_cpu_y->size[1] = c_cpu_y->size[1];
    emxEnsureCapacity_real_T(d_cpu_y, eint, &e_emlrtRTEI);
    cpu_nrefine = c_cpu_y->size[1];
    mwGetLaunchParameters1D(computeNumIters(cpu_nrefine - 1), &grid, &block,
      2147483647U);
    if (b_y_needsGpuEnsureCapacity) {
      gpuEmxEnsureCapacity_real_T(c_cpu_y, &o_gpu_y, true);
    }

    gpuEmxEnsureCapacity_real_T(d_cpu_y, &p_gpu_y, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel163<<<grid, block>>>(o_gpu_y, rt_powd_snf(2.0, 1.0 /
        fb_VoicesPerOctave), cpu_nrefine - 1, p_gpu_y);
    }

    emxFree_real_T(&c_cpu_y);
    eint = cpu_fb_Scales->size[0] * cpu_fb_Scales->size[1];
    cpu_fb_Scales->size[0] = 1;
    cpu_fb_Scales->size[1] = d_cpu_y->size[1];
    emxEnsureCapacity_real_T(cpu_fb_Scales, eint, &f_emlrtRTEI);
    bcoef = d_cpu_y->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real_T(cpu_fb_Scales, &gpu_fb_Scales, true);
    c_fb_Scales_needsGpuEnsureCapac = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel164<<<grid, block>>>(p_gpu_y, b_r, bcoef, gpu_fb_Scales);
    }

    fb_Scales_outdatedOnCpu = true;
    emxFree_real_T(&d_cpu_y);
  }

  first_iteration = false;
  lidx = 0;
  do {
    exitg1 = 0;
    if (lidx + 1 < 6) {
      if (cpu_cv[static_cast<int32_T>(c_b[lidx])] != cpu_cv[static_cast<int32_T>
          (cv2[lidx])]) {
        exitg1 = 1;
      } else {
        lidx++;
      }
    } else {
      first_iteration = true;
      exitg1 = 1;
    }
  } while (exitg1 == 0);

  emxInit_real_T(&cpu_daughter, 2, &p_emlrtRTEI, true);
  emxInit_real_T(&cpu_f, 2, &kd_emlrtRTEI, true);
  if (first_iteration) {
    emxInit_real_T(&b_cpu_somega, 2, &ed_emlrtRTEI, true);
    if (cpu_fb_Scales->size[1] == 1) {
      c_omega_tmp1_needsGpuEnsureCapa = false;
      fx_data_outdatedOnCpu = false;
      eint = b_cpu_somega->size[0] * b_cpu_somega->size[1];
      b_cpu_somega->size[0] = 1;
      if (cpu_fb_Omega->size[1] == 1) {
        b_cpu_somega->size[1] = 1;
      } else {
        b_cpu_somega->size[1] = cpu_fb_Omega->size[1];
      }

      emxEnsureCapacity_real_T(b_cpu_somega, eint, &h_emlrtRTEI);
      wav_outdatedOnCpu = true;
      ix = (cpu_fb_Omega->size[1] != 1);
      cpu_nrefine = b_cpu_somega->size[1] - 1;
      for (k = 0; k <= cpu_nrefine; k++) {
        if (fb_Scales_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_fb_Scales, &gpu_fb_Scales);
        }

        fb_Scales_outdatedOnCpu = false;
        if (fb_Omega_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_fb_Omega, &gpu_fb_Omega);
        }

        fb_Omega_outdatedOnCpu = false;
        b_cpu_somega->data[k] = cpu_fb_Scales->data[0] * cpu_fb_Omega->data[ix *
          k];
        fx_data_outdatedOnCpu = true;
        c_fb_Scales_needsGpuEnsureCapac = true;
      }
    } else {
      eint = b_cpu_somega->size[0] * b_cpu_somega->size[1];
      b_cpu_somega->size[0] = cpu_fb_Scales->size[1];
      b_cpu_somega->size[1] = cpu_fb_Omega->size[1];
      emxEnsureCapacity_real_T(b_cpu_somega, eint, &i_emlrtRTEI);
      nsubs = cpu_fb_Omega->size[1];
      bcoef = cpu_fb_Scales->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(nsubs - 1, bcoef), &grid, &block,
        2147483647U);
      gpuEmxEnsureCapacity_real_T(b_cpu_somega, &gpu_somega, true);
      wav_outdatedOnCpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel145<<<grid, block>>>(gpu_fb_Omega, gpu_fb_Scales, bcoef,
          nsubs - 1, gpu_somega, b_cpu_somega->size[0U]);
      }

      fx_data_outdatedOnCpu = false;
      c_omega_tmp1_needsGpuEnsureCapa = true;
    }

    cpu_nrefine = b_cpu_somega->size[0] * b_cpu_somega->size[1];
    for (bcoef = 0; bcoef < 2; bcoef++) {
      xSize[bcoef] = static_cast<uint32_T>(b_cpu_somega->size[bcoef]);
    }

    emxInit_real_T(&cpu_absomega, 2, &gd_emlrtRTEI, true);
    eint = cpu_absomega->size[0] * cpu_absomega->size[1];
    cpu_absomega->size[0] = static_cast<int32_T>(xSize[0]);
    cpu_absomega->size[1] = static_cast<int32_T>(xSize[1]);
    emxEnsureCapacity_real_T(cpu_absomega, eint, &k_emlrtRTEI);
    mwGetLaunchParameters1D(computeNumIters(cpu_nrefine - 1), &grid, &block,
      2147483647U);
    if (wav_outdatedOnCpu) {
      gpuEmxEnsureCapacity_real_T(b_cpu_somega, &gpu_somega,
        !fx_data_outdatedOnCpu);
    }

    gpuEmxEnsureCapacity_real_T(cpu_absomega, &gpu_absomega, true);
    if (fx_data_outdatedOnCpu) {
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_somega, b_cpu_somega);
    }

    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel16<<<grid, block>>>(gpu_somega, cpu_nrefine - 1,
        gpu_absomega);
    }

    emxInit_real_T(&cpu_powscales, 2, &m_emlrtRTEI, true);
    eint = cpu_powscales->size[0] * cpu_powscales->size[1];
    cpu_powscales->size[0] = cpu_absomega->size[0];
    cpu_powscales->size[1] = cpu_absomega->size[1];
    emxEnsureCapacity_real_T(cpu_powscales, eint, &m_emlrtRTEI);
    bcoef = cpu_absomega->size[0] * cpu_absomega->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real_T(cpu_powscales, &gpu_powscales, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel17<<<grid, block>>>(gpu_absomega, bcoef, gpu_powscales);
    }

    cpu_nrefine = cpu_absomega->size[0] * cpu_absomega->size[1];
    mwGetLaunchParameters1D(computeNumIters(cpu_nrefine - 1), &grid, &block,
      2147483647U);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel18<<<grid, block>>>(cpu_nrefine - 1, gpu_absomega);
    }

    emxInit_real_T(&b_cpu_x, 2, &n_emlrtRTEI, true);
    if ((cpu_absomega->size[0] == cpu_powscales->size[0]) && (cpu_absomega->
         size[1] == cpu_powscales->size[1])) {
      eint = b_cpu_x->size[0] * b_cpu_x->size[1];
      b_cpu_x->size[0] = cpu_absomega->size[0];
      b_cpu_x->size[1] = cpu_absomega->size[1];
      emxEnsureCapacity_real_T(b_cpu_x, eint, &n_emlrtRTEI);
      bcoef = cpu_absomega->size[0] * cpu_absomega->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(b_cpu_x, &gpu_x, true);
      interval_outdatedOnGpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel19<<<grid, block>>>(gpu_powscales, gpu_absomega, bcoef,
          gpu_x);
      }

      fx_data_outdatedOnCpu = false;
    } else {
      gpuEmxMemcpyGpuToCpu_real_T(cpu_absomega, &gpu_absomega);
      gpuEmxMemcpyGpuToCpu_real_T(cpu_powscales, &gpu_powscales);
      binary_expand_op_5(b_cpu_x, cpu_absomega, cpu_powscales);
      fx_data_outdatedOnCpu = true;
      interval_outdatedOnGpu = true;
    }

    emxFree_real_T(&cpu_powscales);
    emxFree_real_T(&cpu_absomega);
    cpu_nrefine = b_cpu_x->size[0] * b_cpu_x->size[1];
    mwGetLaunchParameters1D(computeNumIters(cpu_nrefine - 1), &grid, &block,
      2147483647U);
    if (interval_outdatedOnGpu) {
      gpuEmxEnsureCapacity_real_T(b_cpu_x, &gpu_x, !fx_data_outdatedOnCpu);
    }

    if (fx_data_outdatedOnCpu) {
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, b_cpu_x);
    }

    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel20<<<grid, block>>>(cpu_nrefine - 1, gpu_x);
    }

    if ((b_cpu_x->size[0] == b_cpu_somega->size[0]) && (b_cpu_x->size[1] ==
         b_cpu_somega->size[1])) {
      eint = cpu_daughter->size[0] * cpu_daughter->size[1];
      cpu_daughter->size[0] = b_cpu_x->size[0];
      cpu_daughter->size[1] = b_cpu_x->size[1];
      emxEnsureCapacity_real_T(cpu_daughter, eint, &o_emlrtRTEI);
      bcoef = b_cpu_x->size[0] * b_cpu_x->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(cpu_daughter, &gpu_daughter, true);
      daughter_needsGpuEnsureCapacity = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel21<<<grid, block>>>(gpu_somega, gpu_x, bcoef,
          gpu_daughter);
      }

      daughter_outdatedOnGpu = false;
    } else {
      gpuEmxMemcpyGpuToCpu_real_T(b_cpu_x, &gpu_x);
      if (c_omega_tmp1_needsGpuEnsureCapa) {
        gpuEmxMemcpyGpuToCpu_real_T(b_cpu_somega, &gpu_somega);
      }

      binary_expand_op_4(cpu_daughter, b_cpu_x, b_cpu_somega);
      daughter_outdatedOnGpu = true;
      daughter_needsGpuEnsureCapacity = true;
    }

    emxFree_real_T(&b_cpu_x);
    emxFree_real_T(&b_cpu_somega);
    eint = cpu_f->size[0] * cpu_f->size[1];
    cpu_f->size[0] = 1;
    cpu_f->size[1] = cpu_fb_Scales->size[1];
    emxEnsureCapacity_real_T(cpu_f, eint, &q_emlrtRTEI);
    bcoef = cpu_fb_Scales->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block, 2147483647U);
    if (c_fb_Scales_needsGpuEnsureCapac) {
      gpuEmxEnsureCapacity_real_T(cpu_fb_Scales, &gpu_fb_Scales, true);
    }

    c_fb_Scales_needsGpuEnsureCapac = false;
    gpuEmxEnsureCapacity_real_T(cpu_f, &gpu_f, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel22<<<grid, block>>>(gpu_fb_Scales, bcoef, gpu_f);
    }
  } else {
    emxInit_real_T(&cpu_somega, 2, &dd_emlrtRTEI, true);
    if (cpu_fb_Scales->size[1] == 1) {
      fx_data_outdatedOnCpu = false;
      eint = cpu_somega->size[0] * cpu_somega->size[1];
      cpu_somega->size[0] = 1;
      if (cpu_fb_Omega->size[1] == 1) {
        cpu_somega->size[1] = 1;
      } else {
        cpu_somega->size[1] = cpu_fb_Omega->size[1];
      }

      emxEnsureCapacity_real_T(cpu_somega, eint, &h_emlrtRTEI);
      wav_outdatedOnCpu = true;
      ix = (cpu_fb_Omega->size[1] != 1);
      cpu_nrefine = cpu_somega->size[1] - 1;
      for (k = 0; k <= cpu_nrefine; k++) {
        if (fb_Scales_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_fb_Scales, &gpu_fb_Scales);
        }

        fb_Scales_outdatedOnCpu = false;
        if (fb_Omega_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_fb_Omega, &gpu_fb_Omega);
        }

        fb_Omega_outdatedOnCpu = false;
        cpu_somega->data[k] = cpu_fb_Scales->data[0] * cpu_fb_Omega->data[ix * k];
        fx_data_outdatedOnCpu = true;
        c_fb_Scales_needsGpuEnsureCapac = true;
      }
    } else {
      eint = cpu_somega->size[0] * cpu_somega->size[1];
      cpu_somega->size[0] = cpu_fb_Scales->size[1];
      cpu_somega->size[1] = cpu_fb_Omega->size[1];
      emxEnsureCapacity_real_T(cpu_somega, eint, &g_emlrtRTEI);
      nsubs = cpu_fb_Omega->size[1];
      bcoef = cpu_fb_Scales->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(nsubs - 1, bcoef), &grid, &block,
        2147483647U);
      gpuEmxEnsureCapacity_real_T(cpu_somega, &b_gpu_somega, true);
      wav_outdatedOnCpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel153<<<grid, block>>>(gpu_fb_Omega, gpu_fb_Scales, bcoef,
          nsubs - 1, b_gpu_somega, cpu_somega->size[0U]);
      }

      fx_data_outdatedOnCpu = false;
    }

    emxInit_real_T(&cpu_w, 2, &j_emlrtRTEI, true);
    eint = cpu_w->size[0] * cpu_w->size[1];
    cpu_w->size[0] = cpu_somega->size[0];
    cpu_w->size[1] = cpu_somega->size[1];
    emxEnsureCapacity_real_T(cpu_w, eint, &j_emlrtRTEI);
    bcoef = cpu_somega->size[0] * cpu_somega->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block, 2147483647U);
    if (wav_outdatedOnCpu) {
      gpuEmxEnsureCapacity_real_T(cpu_somega, &b_gpu_somega,
        !fx_data_outdatedOnCpu);
    }

    gpuEmxEnsureCapacity_real_T(cpu_w, &d_gpu_w, true);
    if (fx_data_outdatedOnCpu) {
      gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_somega, cpu_somega);
    }

    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel146<<<grid, block>>>(b_gpu_somega, bcoef, d_gpu_w);
    }

    emxFree_real_T(&cpu_somega);
    emxInit_real_T(&cpu_expnt, 2, &fd_emlrtRTEI, true);
    eint = cpu_expnt->size[0] * cpu_expnt->size[1];
    cpu_expnt->size[0] = cpu_w->size[0];
    cpu_expnt->size[1] = cpu_w->size[1];
    emxEnsureCapacity_real_T(cpu_expnt, eint, &l_emlrtRTEI);
    bcoef = cpu_w->size[0] * cpu_w->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real_T(cpu_expnt, &gpu_expnt, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel147<<<grid, block>>>(d_gpu_w, bcoef, gpu_expnt);
    }

    cpu_nrefine = cpu_expnt->size[0] * cpu_expnt->size[1];
    mwGetLaunchParameters1D(computeNumIters(cpu_nrefine - 1), &grid, &block,
      2147483647U);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel148<<<grid, block>>>(cpu_nrefine - 1, gpu_expnt);
    }

    cpu_nrefine = cpu_w->size[0] * cpu_w->size[1];
    for (bcoef = 0; bcoef < 2; bcoef++) {
      xSize[bcoef] = static_cast<uint32_T>(cpu_w->size[bcoef]);
    }

    emxInit_real_T(&e_cpu_y, 2, &id_emlrtRTEI, true);
    eint = e_cpu_y->size[0] * e_cpu_y->size[1];
    e_cpu_y->size[0] = static_cast<int32_T>(xSize[0]);
    e_cpu_y->size[1] = static_cast<int32_T>(xSize[1]);
    emxEnsureCapacity_real_T(e_cpu_y, eint, &k_emlrtRTEI);
    mwGetLaunchParameters1D(computeNumIters(cpu_nrefine - 1), &grid, &block,
      2147483647U);
    gpuEmxEnsureCapacity_real_T(e_cpu_y, &n_gpu_y, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel149<<<grid, block>>>(d_gpu_w, cpu_nrefine - 1, n_gpu_y);
    }

    emxFree_real_T(&cpu_w);
    if ((cpu_expnt->size[0] == e_cpu_y->size[0]) && (cpu_expnt->size[1] ==
         e_cpu_y->size[1])) {
      eint = cpu_daughter->size[0] * cpu_daughter->size[1];
      cpu_daughter->size[0] = cpu_expnt->size[0];
      cpu_daughter->size[1] = cpu_expnt->size[1];
      emxEnsureCapacity_real_T(cpu_daughter, eint, &p_emlrtRTEI);
      bcoef = cpu_expnt->size[0] * cpu_expnt->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(cpu_daughter, &gpu_daughter, true);
      daughter_needsGpuEnsureCapacity = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel150<<<grid, block>>>(n_gpu_y, gpu_expnt, bcoef,
          gpu_daughter);
      }

      daughter_outdatedOnGpu = false;
    } else {
      gpuEmxMemcpyGpuToCpu_real_T(cpu_expnt, &gpu_expnt);
      gpuEmxMemcpyGpuToCpu_real_T(e_cpu_y, &n_gpu_y);
      binary_expand_op_6(cpu_daughter, cpu_expnt, e_cpu_y);
      daughter_outdatedOnGpu = true;
      daughter_needsGpuEnsureCapacity = true;
    }

    emxFree_real_T(&e_cpu_y);
    emxFree_real_T(&cpu_expnt);
    cpu_nrefine = cpu_daughter->size[0] * cpu_daughter->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(cpu_nrefine), &grid, &block,
      2147483647U);
    if (daughter_needsGpuEnsureCapacity) {
      gpuEmxEnsureCapacity_real_T(cpu_daughter, &gpu_daughter,
        !daughter_outdatedOnGpu);
    }

    daughter_needsGpuEnsureCapacity = false;
    if (daughter_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_daughter, cpu_daughter);
    }

    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel151<<<grid, block>>>(cpu_nrefine, gpu_daughter);
    }

    daughter_outdatedOnGpu = false;
    eint = cpu_f->size[0] * cpu_f->size[1];
    cpu_f->size[0] = 1;
    cpu_f->size[1] = cpu_fb_Scales->size[1];
    emxEnsureCapacity_real_T(cpu_f, eint, &s_emlrtRTEI);
    bcoef = cpu_fb_Scales->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block, 2147483647U);
    if (c_fb_Scales_needsGpuEnsureCapac) {
      gpuEmxEnsureCapacity_real_T(cpu_fb_Scales, &gpu_fb_Scales, true);
    }

    c_fb_Scales_needsGpuEnsureCapac = false;
    gpuEmxEnsureCapacity_real_T(cpu_f, &gpu_f, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel152<<<grid, block>>>(gpu_fb_Scales, bcoef, gpu_f);
    }
  }

  emxFree_real_T(&cpu_fb_Omega);
  eint = cpu_f->size[0] * cpu_f->size[1];
  cpu_f->size[0] = 1;
  emxEnsureCapacity_real_T(cpu_f, eint, &r_emlrtRTEI);
  eint = cpu_f->size[1] - 1;
  mwGetLaunchParameters1D(computeNumIters(eint), &grid, &block, 2147483647U);
  gpuEmxEnsureCapacity_real_T(cpu_f, &gpu_f, true);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    ec_cwtAvg_kernel23<<<grid, block>>>(fs, eint, gpu_f);
  }

  // 'ec_cwtAvg:26' freqs = centerFrequencies(fb);
  eint = cpu_freqs->size[0];
  cpu_freqs->size[0] = cpu_f->size[1];
  emxEnsureCapacity_real_T(cpu_freqs, eint, &t_emlrtRTEI);
  bcoef = cpu_f->size[1] - 1;
  mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block, 2147483647U);
  gpuEmxEnsureCapacity_real_T(cpu_freqs, &gpu_freqs, true);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    ec_cwtAvg_kernel24<<<grid, block>>>(gpu_f, bcoef, gpu_freqs);
  }

  emxFree_real_T(&cpu_f);

  //  Preallocate
  // 'ec_cwtAvg:29' tmp = cell(1,nChs);
  eint = y_size[0] * y_size[1];
  y_size[0] = 1;
  y_size[1] = cpu_x->size[1];
  emxEnsureCapacity_cell_wrap_0(y_data, y_size, eint, &u_emlrtRTEI);

  // 'ec_cwtAvg:30' y = coder.nullcopy(tmp);
  //  y = coder.nullcopy(x); % Preallocate output
  //  CWT average power (L1-norm & variance-norm usng weighted integrals)
  // 'ec_cwtAvg:34' for ch = 1:nChs
  x_size_idx_1 = cpu_x->size[1];
  emxInit_real_T(&cpu_savgpTMP, 2, &ld_emlrtRTEI, true);
  if (cpu_x->size[1] - 1 >= 0) {
    n = cpu_x->size[0] - 1;
    csz_idx_0 = cpu_daughter->size[0];
  }

  emxInit_real_T(&cpu_xv, 2, &v_emlrtRTEI, true);
  emxInit_creal_T(&cpu_xposdft, 2, &w_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_x, 2, &y_emlrtRTEI, true);
  emxInit_creal_T(&cpu_cfsposdft, 2, &md_emlrtRTEI, true);
  emxInit_creal_T(&cpu_cfspos, 2, &bb_emlrtRTEI, true);
  emxInit_real_T(&f_cpu_y, 2, &nd_emlrtRTEI, true);
  emxInit_real_T(&cpu_abscfssq, 2, &od_emlrtRTEI, true);
  emxInit_real_T(&cpu_a, 2, &db_emlrtRTEI, true);
  emxInit_uint32_T(&g_cpu_y, 2, &pd_emlrtRTEI, true);
  emxInit_real_T(&cpu_z, 1, &qd_emlrtRTEI, true);
  emxInit_real_T(&cpu_c, 1, &gb_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_c, 1, &gb_emlrtRTEI, true);
  emxInit_real_T(&h_cpu_y, 2, &rd_emlrtRTEI, true);
  emxInit_real_T(&cpu_abswt2, 2, &sd_emlrtRTEI, true);
  emxInit_real_T(&cpu_abswt2S, 2, &hb_emlrtRTEI, true);
  emxInit_real_T(&i_cpu_y, 2, &ib_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_c, 1, &gb_emlrtRTEI, true);
  emxInit_real_T(&cpu_xCh, 1, &kb_emlrtRTEI, true);
  emxInit_real_T(&cpu_opts_filter, 1, &sb_emlrtRTEI, true);
  emxInit_real_T(&cpu_dv22, 1, &td_emlrtRTEI, true);
  emxInit_real_T(&cpu_h1, 1, &qb_emlrtRTEI, true);
  emxInit_real_T(&cpu_h, 2, &u_emlrtRTEI, true);
  emxInit_real_T(&cpu_m, 2, &pb_emlrtRTEI, true);
  emxInit_real_T(&cpu_k, 1, &rb_emlrtRTEI, true);
  emxInit_real_T(&cpu_G, 2, &ud_emlrtRTEI, true);
  emxInit_real_T(&cpu_sinc1A, 2, &vd_emlrtRTEI, true);
  emxInit_real_T(&cpu_sinc2A, 2, &wd_emlrtRTEI, true);
  emxInit_real_T(&cpu_sinc3A, 2, &xd_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_h, 1, &xb_emlrtRTEI, true);
  emxInit_uint32_T(&j_cpu_y, 2, &yd_emlrtRTEI, true);
  emxInit_real_T(&cpu_sinc4A, 2, &ae_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv9, 2, &be_emlrtRTEI, true);
  emxInit_real_T(&cpu_b, 1, &ac_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_a, 1, &u_emlrtRTEI, true);
  emxInit_real_T(&cpu_dv23, 1, &ce_emlrtRTEI, true);
  emxInit_real_T(&cpu_yCol, 1, &de_emlrtRTEI, true);
  emxInit_real_T(&d_cpu_x, 1, &ee_emlrtRTEI, true);
  emxInit_int32_T(&cpu_jpvt, 2, &u_emlrtRTEI, true);
  emxInit_real_T(&cpu_dv24, 1, &ce_emlrtRTEI, true);
  emxInit_real_T(&cpu_tau, 1, &u_emlrtRTEI, true);
  emxInit_real_T(&e_cpu_x, 2, &sc_emlrtRTEI, true);
  emxInit_real_T(&k_cpu_y, 1, &fe_emlrtRTEI, true);
  emxInit_ptrdiff_t(&jpvt_t, 1, &oc_emlrtRTEI, true);
  emxInit_int32_T(&cpu_IPIV, 1, &ge_emlrtRTEI, true);
  emxInit_real_T(&l_cpu_y, 1, &he_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_w, 2, &sc_emlrtRTEI, true);
  emxInit_real_T(&d_cpu_c, 1, &ie_emlrtRTEI, true);
  emxInit_real_T(&cpu_expanded, 2, &vc_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_expanded, 2, &vc_emlrtRTEI, true);
  emxInit_int32_T(&m_cpu_y, 2, &vc_emlrtRTEI, true);
  emxInit_int32_T(&n_cpu_y, 2, &vc_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv14, 1, &vc_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv15, 1, &vc_emlrtRTEI, true);
  emxInit_int32_T(&cpu_rows, 2, &vc_emlrtRTEI, true);
  emxInit_int32_T(&b_cpu_rows, 2, &vc_emlrtRTEI, true);
  emxInit_real_T(&o_cpu_y, 2, &sc_emlrtRTEI, true);
  emxInit_real_T(&p_cpu_y, 2, &je_emlrtRTEI, true);
  emxInit_real_T(&cpu_b0, 1, &dc_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_w, 2, &xc_emlrtRTEI, true);
  emxInit_real_T(&d_cpu_w, 2, &xc_emlrtRTEI, true);
  for (b_nx = 0; b_nx < x_size_idx_1; b_nx++) {
    uint32_T defaultSL_idx_1;
    boolean_T xCh_outdatedOnCpu;

    // 'ec_cwtAvg:35' xCh = scaleSpectrum(fb,x(:,ch),SpectrumType="density")';
    defaultSL_idx_1 = static_cast<uint32_T>(cpu_fb_Scales->size[1]);
    if (cpu_x->size[0] == 1) {
      fc = cpu_x->data[cpu_x->size[0] * b_nx];
      if ((!std::isinf(fc)) && (!std::isnan(fc))) {
        s = 0.0;
      } else {
        s = rtNaN;
      }
    } else {
      cpu_r = cpu_x->data[cpu_x->size[0] * b_nx];
      for (k = 0; k < n; k++) {
        cpu_r += cpu_x->data[(k + cpu_x->size[0] * b_nx) + 1];
      }

      cpu_r /= static_cast<real_T>(cpu_x->size[0]);
      b_r = 0.0;
      for (k = 0; k <= n; k++) {
        delta = cpu_x->data[k + cpu_x->size[0] * b_nx] - cpu_r;
        b_r += delta * delta;
      }

      s = b_r / static_cast<real_T>(cpu_x->size[0]);
    }

    eint = cpu_xv->size[0] * cpu_xv->size[1];
    cpu_xv->size[0] = 1;
    cpu_xv->size[1] = cpu_x->size[0];
    emxEnsureCapacity_real_T(cpu_xv, eint, &v_emlrtRTEI);
    bcoef = cpu_x->size[0] - 1;
    mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real_T(cpu_x, &b_gpu_x, !x_outdatedOnGpu);
    gpuEmxEnsureCapacity_real_T(cpu_xv, &gpu_xv, true);
    wav_outdatedOnCpu = false;
    if (x_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_x, cpu_x);
    }

    x_outdatedOnGpu = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel25<<<grid, block>>>(b_nx, b_gpu_x, bcoef, gpu_xv,
        cpu_x->size[0U]);
    }

    fx_data_outdatedOnCpu = false;
    if (fb_SignalPad > 0) {
      ix = cpu_x->size[0] - fb_SignalPad;
      if (ix + 1 > cpu_x->size[0]) {
        lidx = 0;
        nx = 1;
        ix = -1;
      } else {
        lidx = cpu_x->size[0] - 1;
        nx = -1;
      }

      eint = c_cpu_x->size[0] * c_cpu_x->size[1];
      c_cpu_x->size[0] = 1;
      c_cpu_x->size[1] = fb_SignalPad;
      emxEnsureCapacity_real_T(c_cpu_x, eint, &y_emlrtRTEI);
      mwGetLaunchParameters1D(computeNumIters(fb_SignalPad - 1), &grid, &block,
        2147483647U);
      gpuEmxEnsureCapacity_real_T(c_cpu_x, &c_gpu_x, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel26<<<grid, block>>>(b_nx, b_gpu_x, fb_SignalPad - 1,
          c_gpu_x, cpu_x->size[0U]);
      }

      cpu_nrefine = fb_SignalPad >> 1;
      mwGetLaunchParameters1D(computeNumIters(cpu_nrefine - 1), &grid, &block,
        2147483647U);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel27<<<grid, block>>>(fb_SignalPad, cpu_nrefine - 1,
          c_gpu_x);
      }

      eint = cpu_xv->size[0] * cpu_xv->size[1];
      cpu_xv->size[0] = 1;
      cpu_xv->size[1] = ((cpu_x->size[0] + c_cpu_x->size[1]) + div_s32(ix - lidx,
        nx)) + 1;
      emxEnsureCapacity_real_T(cpu_xv, eint, &ab_emlrtRTEI);
      nsubs = c_cpu_x->size[1];
      mwGetLaunchParameters1D(computeNumIters(nsubs - 1), &grid, &block,
        2147483647U);
      gpuEmxEnsureCapacity_real_T(cpu_xv, &gpu_xv, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel28<<<grid, block>>>(c_gpu_x, nsubs - 1, gpu_xv);
      }

      c_omega_tmp1_needsGpuEnsureCapa = true;
      nsubs = cpu_x->size[0];
      for (eint = 0; eint < nsubs; eint++) {
        if (c_omega_tmp1_needsGpuEnsureCapa) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_xv, &gpu_xv);
        }

        cpu_xv->data[eint + c_cpu_x->size[1]] = cpu_x->data[eint + cpu_x->size[0]
          * b_nx];
        c_omega_tmp1_needsGpuEnsureCapa = false;
        fx_data_outdatedOnCpu = true;
        wav_outdatedOnCpu = true;
      }

      nsubs = div_s32(ix - lidx, nx);
      for (eint = 0; eint <= nsubs; eint++) {
        if (c_omega_tmp1_needsGpuEnsureCapa) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_xv, &gpu_xv);
        }

        cpu_xv->data[(eint + cpu_x->size[0]) + c_cpu_x->size[1]] = cpu_x->data
          [(lidx + nx * eint) + cpu_x->size[0] * b_nx];
        c_omega_tmp1_needsGpuEnsureCapa = false;
        fx_data_outdatedOnCpu = true;
        wav_outdatedOnCpu = true;
      }
    }

    if (cpu_xv->size[1] - (static_cast<int32_T>(static_cast<uint32_T>
          (cpu_xv->size[1]) >> 1) << 1) == 1) {
      cufftHandle fftPlanHandle;
      eint = cpu_xposdft->size[0] * cpu_xposdft->size[1];
      cpu_xposdft->size[0] = 1;
      cpu_xposdft->size[1] = cpu_xv->size[1];
      emxEnsureCapacity_creal_T(cpu_xposdft, eint, &w_emlrtRTEI);
      bcoef = cpu_xv->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block, 2147483647U);
      if (wav_outdatedOnCpu) {
        gpuEmxEnsureCapacity_real_T(cpu_xv, &gpu_xv, !fx_data_outdatedOnCpu);
      }

      gpuEmxEnsureCapacity_creal_T(cpu_xposdft, &gpu_xposdft, true);
      if (fx_data_outdatedOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_xv, cpu_xv);
      }

      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel29<<<grid, block>>>(gpu_xv, bcoef, gpu_xposdft);
      }

      cpu_nrefine = cpu_xposdft->size[1];
      fftPlanHandle = acquireCUFFTPlan(1, &cpu_nrefine, &cpu_nrefine, 1, 1,
        CUFFT_Z2Z, 1);
      cufftExecZ2Z(fftPlanHandle, (cufftDoubleComplex *)&gpu_xposdft.data[0],
                   (cufftDoubleComplex *)&gpu_xposdft.data[0], CUFFT_FORWARD);
    } else {
      cufftHandle b_fftPlanHandle;
      cpu_nrefine = cpu_xv->size[1];
      for (bcoef = 0; bcoef < 2; bcoef++) {
        xSize[bcoef] = static_cast<uint32_T>(cpu_xv->size[bcoef]);
      }

      eint = cpu_xposdft->size[0] * cpu_xposdft->size[1];
      cpu_xposdft->size[0] = 1;
      cpu_xposdft->size[1] = static_cast<int32_T>(xSize[1]);
      emxEnsureCapacity_creal_T(cpu_xposdft, eint, &x_emlrtRTEI);
      b_fftPlanHandle = acquireCUFFTPlan(1, &cpu_nrefine, &cpu_nrefine, 1, 1,
        CUFFT_D2Z, 1);
      if (wav_outdatedOnCpu) {
        gpuEmxEnsureCapacity_real_T(cpu_xv, &gpu_xv, !fx_data_outdatedOnCpu);
      }

      gpuEmxEnsureCapacity_creal_T(cpu_xposdft, &gpu_xposdft, true);
      if (fx_data_outdatedOnCpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_xv, cpu_xv);
      }

      cufftExecD2Z(b_fftPlanHandle, (cufftDoubleReal *)&gpu_xv.data[0],
                   (cufftDoubleComplex *)&gpu_xposdft.data[0]);
      cpu_nrefine = static_cast<int32_T>(static_cast<real_T>(static_cast<int32_T>
        (xSize[1]) + 1) / 2.0);
      mwGetLaunchParameters1D(computeNumIters(cpu_nrefine - 2), &grid, &block,
        2147483647U);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel144<<<grid, block>>>(cpu_nrefine - 2, gpu_xposdft,
          xSize[1]);
      }
    }

    nG = cpu_daughter->size[1];
    lidx = cpu_xposdft->size[1];
    if (nG <= lidx) {
      lidx = nG;
    }

    if (cpu_daughter->size[1] == 1) {
      eint = cpu_xposdft->size[1];
    } else if (cpu_xposdft->size[1] == cpu_daughter->size[1]) {
      eint = cpu_xposdft->size[1];
    } else {
      eint = lidx;
    }

    nx = cpu_cfsposdft->size[0] * cpu_cfsposdft->size[1];
    cpu_cfsposdft->size[0] = csz_idx_0;
    nG = cpu_daughter->size[1];
    lidx = cpu_xposdft->size[1];
    if (nG <= lidx) {
      lidx = nG;
    }

    if (cpu_daughter->size[1] == 1) {
      cpu_cfsposdft->size[1] = cpu_xposdft->size[1];
    } else if (cpu_xposdft->size[1] == cpu_daughter->size[1]) {
      cpu_cfsposdft->size[1] = cpu_xposdft->size[1];
    } else {
      cpu_cfsposdft->size[1] = lidx;
    }

    emxEnsureCapacity_creal_T(cpu_cfsposdft, nx, &h_emlrtRTEI);
    wav_outdatedOnCpu = true;
    if ((csz_idx_0 != 0) && (eint != 0)) {
      ix = (cpu_daughter->size[1] != 1);
      nsubs = cpu_cfsposdft->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(eint - 1, nsubs), &grid, &block,
        2147483647U);
      if (daughter_needsGpuEnsureCapacity) {
        gpuEmxEnsureCapacity_real_T(cpu_daughter, &gpu_daughter,
          !daughter_outdatedOnGpu);
      }

      daughter_needsGpuEnsureCapacity = false;
      gpuEmxEnsureCapacity_creal_T(cpu_cfsposdft, &gpu_cfsposdft, true);
      wav_outdatedOnCpu = false;
      if (daughter_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_daughter, cpu_daughter);
      }

      daughter_outdatedOnGpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel30<<<grid, block>>>(gpu_xposdft, gpu_daughter, ix, nsubs,
          eint - 1, gpu_cfsposdft, cpu_daughter->size[0U], cpu_cfsposdft->size
          [0U]);
      }
    }

    if ((cpu_cfsposdft->size[0] == 0) || (cpu_cfsposdft->size[1] == 0)) {
      for (bcoef = 0; bcoef < 2; bcoef++) {
        xSize[bcoef] = static_cast<uint32_T>(cpu_cfsposdft->size[bcoef]);
      }

      xSize[1] = static_cast<uint32_T>(cpu_cfsposdft->size[1]);
      eint = cpu_cfspos->size[0] * cpu_cfspos->size[1];
      cpu_cfspos->size[0] = static_cast<int32_T>(xSize[0]);
      cpu_cfspos->size[1] = cpu_cfsposdft->size[1];
      emxEnsureCapacity_creal_T(cpu_cfspos, eint, &bb_emlrtRTEI);
      bcoef = static_cast<int32_T>(xSize[0]) * static_cast<int32_T>(xSize[1]) -
        1;
      mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_creal_T(cpu_cfspos, &gpu_cfspos, true);
      fx_data_outdatedOnCpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel31<<<grid, block>>>(bcoef, gpu_cfspos);
      }

      c_omega_tmp1_needsGpuEnsureCapa = false;
      wav_outdatedOnCpu = true;
    } else {
      cufftHandle c_fftPlanHandle;
      cpu_nrefine = cpu_cfsposdft->size[1];
      c_fftPlanHandle = acquireCUFFTPlan(1, &cpu_nrefine, &cpu_nrefine,
        cpu_cfsposdft->size[0], 1, CUFFT_Z2Z, cpu_cfsposdft->size[0]);
      if (wav_outdatedOnCpu) {
        gpuEmxEnsureCapacity_creal_T(cpu_cfsposdft, &gpu_cfsposdft, true);
      }

      cufftExecZ2Z(c_fftPlanHandle, (cufftDoubleComplex *)&gpu_cfsposdft.data[0],
                   (cufftDoubleComplex *)&gpu_cfsposdft.data[0], CUFFT_INVERSE);
      eint = cpu_cfspos->size[0] * cpu_cfspos->size[1];
      cpu_cfspos->size[0] = cpu_cfsposdft->size[0];
      cpu_cfspos->size[1] = cpu_cfsposdft->size[1];
      emxEnsureCapacity_creal_T(cpu_cfspos, eint, &bb_emlrtRTEI);
      bcoef = cpu_cfsposdft->size[1];
      nsubs = cpu_cfsposdft->size[0] * cpu_cfsposdft->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(nsubs), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_creal_T(cpu_cfspos, &gpu_cfspos, true);
      fx_data_outdatedOnCpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel143<<<grid, block>>>(static_cast<real_T>(bcoef),
          gpu_cfsposdft, nsubs, gpu_cfspos);
      }

      c_omega_tmp1_needsGpuEnsureCapa = false;
      wav_outdatedOnCpu = true;
    }

    if (fb_SignalPad > 0) {
      N = static_cast<uint32_T>(fb_SignalPad) + static_cast<uint32_T>
        (cpu_x->size[0]);
      if (static_cast<uint32_T>(fb_SignalPad + 1) > N) {
        cpu_nrefine = 0;
        lidx = 0;
      } else {
        cpu_nrefine = fb_SignalPad;
        lidx = static_cast<int32_T>(N);
      }

      ix = cpu_cfspos->size[0];
      nsubs = lidx - cpu_nrefine;
      for (eint = 0; eint < nsubs; eint++) {
        for (nx = 0; nx < ix; nx++) {
          if (wav_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_creal_T(cpu_cfspos, &gpu_cfspos);
          }

          cpu_cfspos->data[nx + ix * eint] = cpu_cfspos->data[nx +
            cpu_cfspos->size[0] * (cpu_nrefine + eint)];
          wav_outdatedOnCpu = false;
          c_omega_tmp1_needsGpuEnsureCapa = true;
        }
      }

      eint = cpu_cfspos->size[0] * cpu_cfspos->size[1];
      cpu_cfspos->size[1] = lidx - cpu_nrefine;
      emxEnsureCapacity_creal_T(cpu_cfspos, eint, &cb_emlrtRTEI);
      fx_data_outdatedOnCpu = true;
    }

    cpu_nrefine = 0;
    first_iteration = false;
    lidx = 0;
    do {
      exitg1 = 0;
      if (lidx + 1 < 6) {
        if (cpu_cv[static_cast<int32_T>(c_b[lidx])] != cpu_cv
            [static_cast<int32_T>(cv3[lidx])]) {
          exitg1 = 1;
        } else {
          lidx++;
        }
      } else {
        first_iteration = true;
        exitg1 = 1;
      }
    } while (exitg1 == 0);

    if (first_iteration) {
      cpu_nrefine = 1;
      for (bcoef = 0; bcoef < 5; bcoef++) {
        cpu_wav[bcoef] = d_b[bcoef];
      }
    } else {
      for (bcoef = 0; bcoef < 5; bcoef++) {
        cpu_wav[bcoef] = ' ';
      }
    }

    if (cpu_nrefine != 0) {
      for (bcoef = 0; bcoef < 5; bcoef++) {
        wavname[bcoef] = cpu_wav[bcoef];
      }
    }

    first_iteration = false;
    lidx = 0;
    do {
      exitg1 = 0;
      if (lidx + 1 < 6) {
        if (cpu_cv[static_cast<int32_T>(wavname[lidx])] != cpu_cv
            [static_cast<int32_T>(cv3[lidx])]) {
          exitg1 = 1;
        } else {
          lidx++;
        }
      } else {
        first_iteration = true;
        exitg1 = 1;
      }
    } while (exitg1 == 0);

    if (first_iteration) {
      cpu_r = 0.0057083835261;
      for (nG = 0; nG < 6; nG++) {
        cpu_r = cpu_r / 177.7777777777778 + c[nG];
      }

      cpu_r = (cpu_r / 13.333333333333334 - 13.333333333333334) +
        0.91893853320467278;
      cpu_r += 33.241761956554775;
      b_c = 8.2480004101996545E-10 * std::exp(cpu_r);
    } else {
      ec_cwtAvg_kernel131<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_interval);
      ec_cwtAvg_kernel132<<<dim3(6U, 1U, 1U), dim3(128U, 1U, 1U)>>>
        (*gpu_interval);
      interval_outdatedOnGpu = false;
      b_c = 0.0;
      cpu_nrefine = 1;
      checkCudaError(cudaMemcpy(cpu_interval, *gpu_interval, 5200UL,
        cudaMemcpyDeviceToHost), __FILE__, __LINE__);
      nG = static_cast<int32_T>(cpu_interval[1]) - static_cast<int32_T>
        (cpu_interval[0]);
      if (nG > 0) {
        cpu_r = 10.0 / static_cast<real_T>(nG);
        n_idx_0 = static_cast<int8_T>(static_cast<int32_T>(std::ceil(std::abs
          (cpu_interval[1] - cpu_interval[0]) * cpu_r)) - 1);
        nsubs = static_cast<int32_T>(std::ceil(std::abs(cpu_interval[1] -
          cpu_interval[0]) * cpu_r));
        if (nsubs + 1 > 2) {
          cpu_nrefine = n_idx_0;
          cpu_interval[nsubs] = cpu_interval[1];
          interval_outdatedOnGpu = true;
          delta = (cpu_interval[1] - cpu_interval[0]) / (static_cast<real_T>
            (n_idx_0) + 1.0);
          for (lidx = 0; lidx < cpu_nrefine; lidx++) {
            cpu_interval[(nsubs - lidx) - 1] = cpu_interval[0] + static_cast<
              real_T>(n_idx_0 - lidx) * delta;
          }
        }

        cpu_nrefine = nsubs;
      } else {
        nsubs = 1;
      }

      lidx = 0;
      for (ix = 0; ix < cpu_nrefine; ix++) {
        if (std::abs(cpu_interval[ix + 1] - cpu_interval[lidx]) > 0.0) {
          lidx++;
          cpu_interval[lidx] = cpu_interval[ix + 1];
          interval_outdatedOnGpu = true;
        } else {
          nsubs--;
        }
      }

      if (nsubs + 1 < 2) {
        if (interval_outdatedOnGpu) {
          checkCudaError(cudaMemcpy(*gpu_interval, cpu_interval, 5200UL,
            cudaMemcpyHostToDevice), __FILE__, __LINE__);
        }

        ec_cwtAvg_kernel133<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(cpu_nrefine,
          *gpu_interval);
        interval_outdatedOnGpu = false;
        nsubs = 1;
      }

      if (nG <= 0) {
        b_c = 0.47999999999999976;
      } else {
        mwGetLaunchParameters1D(computeNumIters(nsubs - 1), &grid, &block,
          2147483647U);
        if (interval_outdatedOnGpu) {
          checkCudaError(cudaMemcpy(*gpu_interval, cpu_interval, 5200UL,
            cudaMemcpyHostToDevice), __FILE__, __LINE__);
        }

        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_cwtAvg_kernel134<<<grid, block>>>(*gpu_interval, nsubs - 1,
            *gpu_subs);
        }

        subs_outdatedOnCpu = true;
        q_ok = 0.0;
        err_ok = 0.0;
        first_iteration = true;
        do {
          exitg1 = 0;
          interval_outdatedOnGpu = false;
          bcoef = 15 * nsubs;
          ix = -1;
          for (k = 0; k < nsubs; k++) {
            if (subs_outdatedOnCpu) {
              checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                cudaMemcpyDeviceToHost), __FILE__, __LINE__);
            }

            fc = cpu_subs[k << 1];
            subs_outdatedOnCpu = false;
            b_r = cpu_subs[(k << 1) + 1];
            cpu_r = (fc + b_r) / 2.0;
            delta = (b_r - fc) / 2.0;
            for (lidx = 0; lidx < 15; lidx++) {
              SD->f0.cpu_x_data[(ix + lidx) + 1] = NODES[lidx] * delta + cpu_r;
              interval_outdatedOnGpu = true;
            }

            ix += 15;
          }

          mwGetLaunchParameters1D(computeNumIters(bcoef - 1), &grid, &block,
            2147483647U);
          if (interval_outdatedOnGpu) {
            checkCudaError(cudaMemcpy(*gpu_x_data, SD->f0.cpu_x_data, 77880UL,
              cudaMemcpyHostToDevice), __FILE__, __LINE__);
          }

          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel135<<<grid, block>>>(*gpu_x_data, bcoef - 1,
              *gpu_xt_data, *b_gpu_x_data);
          }

          guard1 = false;
          if (!first_iteration) {
            checkCudaError(cudaMemcpy(SD->f0.cpu_x_data, *b_gpu_x_data, 77880UL,
              cudaMemcpyDeviceToHost), __FILE__, __LINE__);
            cpu_r = std::abs(SD->f0.cpu_x_data[0]);
            k = 0;
            exitg2 = false;
            while ((!exitg2) && (k <= bcoef - 2)) {
              fc = cpu_r;
              cpu_r = std::abs(SD->f0.cpu_x_data[k + 1]);
              if (std::abs(SD->f0.cpu_x_data[k + 1] - SD->f0.cpu_x_data[k]) <=
                  2.2204460492503131E-14 * std::fmax(fc, cpu_r)) {
                first_iteration = true;
                exitg2 = true;
              } else {
                k++;
              }
            }

            if (first_iteration) {
              mwGetLaunchParameters1D(computeNumIters(static_cast<int16_T>(bcoef)
                - 1), &grid, &block, 2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel136<<<grid, block>>>(static_cast<int16_T>(bcoef)
                  - 1, *gpu_fx_data);
              }

              exitg1 = 1;
            } else {
              guard1 = true;
            }
          } else {
            guard1 = true;
          }

          if (guard1) {
            first_iteration = false;
            mwGetLaunchParameters1D(computeNumIters(bcoef - 1), &grid, &block,
              2147483647U);
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwtAvg_kernel137<<<grid, block>>>(*b_gpu_x_data, bcoef - 1,
                *gpu_a_data);
            }

            mwGetLaunchParameters1D(computeNumIters(bcoef - 1), &grid, &block,
              2147483647U);
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwtAvg_kernel138<<<grid, block>>>(*gpu_a_data, bcoef - 1,
                *gpu_y_data);
            }

            mwGetLaunchParameters1D(computeNumIters(bcoef - 1), &grid, &block,
              2147483647U);
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwtAvg_kernel139<<<grid, block>>>(*gpu_y_data, bcoef - 1,
                *gpu_x_data);
            }

            mwGetLaunchParameters1D(computeNumIters(bcoef - 1), &grid, &block,
              2147483647U);
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwtAvg_kernel140<<<grid, block>>>(*gpu_x_data, bcoef - 1,
                *b_gpu_y_data);
            }

            mwGetLaunchParameters1D(computeNumIters(bcoef - 1), &grid, &block,
              2147483647U);
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwtAvg_kernel141<<<grid, block>>>(*b_gpu_y_data, bcoef - 1,
                *gpu_y_data);
            }

            mwGetLaunchParameters1D(computeNumIters(bcoef - 1), &grid, &block,
              2147483647U);
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwtAvg_kernel142<<<grid, block>>>(*gpu_xt_data, *b_gpu_x_data, *
                gpu_y_data, bcoef - 1, *gpu_fx_data);
            }

            b_fx_data_outdatedOnCpu = true;
            cpu_r = 0.0;
            ix = -1;
            for (k = 0; k < nsubs; k++) {
              fc = 0.0;
              b_r = 0.0;
              for (lidx = 0; lidx < 15; lidx++) {
                if (b_fx_data_outdatedOnCpu) {
                  checkCudaError(cudaMemcpy(SD->f0.cpu_fx_data, *gpu_fx_data,
                    77880UL, cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                }

                fc += dv5[lidx] * SD->f0.cpu_fx_data[(ix + lidx) + 1];
                b_fx_data_outdatedOnCpu = false;
                b_r += dv6[lidx] * SD->f0.cpu_fx_data[(ix + lidx) + 1];
              }

              ix += 15;
              if (subs_outdatedOnCpu) {
                checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                  cudaMemcpyDeviceToHost), __FILE__, __LINE__);
              }

              subs_outdatedOnCpu = false;
              delta = (cpu_subs[(k << 1) + 1] - cpu_subs[k << 1]) / 2.0;
              fc *= delta;
              qsub[k] = fc;
              cpu_r += fc;
              errsub[k] = b_r * delta;
            }

            b_c = cpu_r + q_ok;
            delta = std::fmax(1.0E-10, 1.0E-6 * std::abs(b_c));
            tau = 2.0 * delta / static_cast<real_T>(nG);
            cpu_r = 0.0;
            cpu_nrefine = 0;
            for (k = 0; k < nsubs; k++) {
              fc = errsub[k];
              b_r = std::abs(fc);
              if (subs_outdatedOnCpu) {
                checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                  cudaMemcpyDeviceToHost), __FILE__, __LINE__);
              }

              subs_outdatedOnCpu = false;
              if (b_r <= tau * ((cpu_subs[(k << 1) + 1] - cpu_subs[k << 1]) /
                                2.0)) {
                err_ok += fc;
                q_ok += qsub[k];
              } else {
                cpu_r += b_r;
                cpu_nrefine++;
                cpu_subs[(cpu_nrefine - 1) << 1] = cpu_subs[k << 1];
                cpu_subs[((cpu_nrefine - 1) << 1) + 1] = cpu_subs[(k << 1) + 1];
              }
            }

            cpu_r += std::abs(err_ok);
            if ((!std::isinf(b_c)) && (!std::isnan(b_c)) && ((!std::isinf(cpu_r))
                 && (!std::isnan(cpu_r))) && (cpu_nrefine != 0) && (!(cpu_r <=
                  delta))) {
              nsubs = cpu_nrefine << 1;
              if (nsubs > 650) {
                exitg1 = 1;
              } else {
                for (k = 0; k < cpu_nrefine; k++) {
                  if (subs_outdatedOnCpu) {
                    checkCudaError(cudaMemcpy(cpu_subs, *gpu_subs, 10384UL,
                      cudaMemcpyDeviceToHost), __FILE__, __LINE__);
                  }

                  cpu_subs[((((cpu_nrefine - k) << 1) - 1) << 1) + 1] =
                    cpu_subs[(((cpu_nrefine - k) - 1) << 1) + 1];
                  cpu_subs[(((cpu_nrefine - k) << 1) - 1) << 1] = (cpu_subs
                    [((cpu_nrefine - k) - 1) << 1] + cpu_subs[(((cpu_nrefine - k)
                    - 1) << 1) + 1]) / 2.0;
                  cpu_subs[((((cpu_nrefine - k) << 1) - 2) << 1) + 1] =
                    cpu_subs[(((cpu_nrefine - k) << 1) - 1) << 1];
                  cpu_subs[(((cpu_nrefine - k) << 1) - 2) << 1] = cpu_subs
                    [((cpu_nrefine - k) - 1) << 1];
                  subs_outdatedOnCpu = false;
                }
              }
            } else {
              exitg1 = 1;
            }
          }
        } while (exitg1 == 0);
      }
    }

    cpu_nrefine = cpu_cfspos->size[0] * cpu_cfspos->size[1];
    for (bcoef = 0; bcoef < 2; bcoef++) {
      xSize[bcoef] = static_cast<uint32_T>(cpu_cfspos->size[bcoef]);
    }

    eint = f_cpu_y->size[0] * f_cpu_y->size[1];
    f_cpu_y->size[0] = static_cast<int32_T>(xSize[0]);
    f_cpu_y->size[1] = static_cast<int32_T>(xSize[1]);
    emxEnsureCapacity_real_T(f_cpu_y, eint, &k_emlrtRTEI);
    mwGetLaunchParameters1D(computeNumIters(cpu_nrefine - 1), &grid, &block,
      2147483647U);
    if (fx_data_outdatedOnCpu) {
      gpuEmxEnsureCapacity_creal_T(cpu_cfspos, &gpu_cfspos,
        !c_omega_tmp1_needsGpuEnsureCapa);
    }

    gpuEmxEnsureCapacity_real_T(f_cpu_y, &c_gpu_y, true);
    if (c_omega_tmp1_needsGpuEnsureCapa) {
      gpuEmxMemcpyCpuToGpu_creal_T(&gpu_cfspos, cpu_cfspos);
    }

    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel32<<<grid, block>>>(gpu_cfspos, cpu_nrefine - 1, c_gpu_y);
    }

    for (bcoef = 0; bcoef < 2; bcoef++) {
      xSize[bcoef] = static_cast<uint32_T>(f_cpu_y->size[bcoef]);
    }

    eint = cpu_abscfssq->size[0] * cpu_abscfssq->size[1];
    cpu_abscfssq->size[0] = static_cast<int32_T>(xSize[0]);
    cpu_abscfssq->size[1] = static_cast<int32_T>(xSize[1]);
    emxEnsureCapacity_real_T(cpu_abscfssq, eint, &e_emlrtRTEI);
    cpu_nrefine = static_cast<int32_T>(xSize[0]) * static_cast<int32_T>(xSize[1]);
    mwGetLaunchParameters1D(computeNumIters(cpu_nrefine - 1), &grid, &block,
      2147483647U);
    gpuEmxEnsureCapacity_real_T(cpu_abscfssq, &gpu_abscfssq, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel33<<<grid, block>>>(c_gpu_y, cpu_nrefine - 1, gpu_abscfssq);
    }

    eint = cpu_a->size[0] * cpu_a->size[1];
    cpu_a->size[0] = cpu_abscfssq->size[0];
    cpu_a->size[1] = cpu_abscfssq->size[1];
    emxEnsureCapacity_real_T(cpu_a, eint, &db_emlrtRTEI);
    bcoef = cpu_abscfssq->size[0] * cpu_abscfssq->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real_T(cpu_a, &gpu_a, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel34<<<grid, block>>>(gpu_abscfssq, bcoef, gpu_a);
    }

    nG = cpu_fb_Scales->size[1];
    lidx = cpu_abscfssq->size[0];
    if (nG <= lidx) {
      lidx = nG;
    }

    if (cpu_fb_Scales->size[1] == 1) {
      eint = cpu_abscfssq->size[0];
    } else if (cpu_abscfssq->size[0] == 1) {
      eint = cpu_fb_Scales->size[1];
    } else if (cpu_abscfssq->size[0] == cpu_fb_Scales->size[1]) {
      eint = cpu_abscfssq->size[0];
    } else {
      eint = lidx;
    }

    nx = cpu_abscfssq->size[1];
    cpu_nrefine = cpu_abscfssq->size[0] * cpu_abscfssq->size[1];
    cpu_abscfssq->size[0] = eint;
    cpu_abscfssq->size[1] = nx;
    emxEnsureCapacity_real_T(cpu_abscfssq, cpu_nrefine, &h_emlrtRTEI);
    wav_outdatedOnCpu = true;
    if ((eint != 0) && (nx != 0)) {
      lidx = (cpu_a->size[1] != 1);
      bcoef = cpu_abscfssq->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(nx - 1, bcoef), &grid, &block,
        2147483647U);
      if (c_fb_Scales_needsGpuEnsureCapac) {
        gpuEmxEnsureCapacity_real_T(cpu_fb_Scales, &gpu_fb_Scales, true);
      }

      c_fb_Scales_needsGpuEnsureCapac = false;
      gpuEmxEnsureCapacity_real_T(cpu_abscfssq, &gpu_abscfssq, true);
      wav_outdatedOnCpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel35<<<grid, block>>>(gpu_fb_Scales, gpu_a, lidx, bcoef,
          nx - 1, gpu_abscfssq, cpu_a->size[0U], cpu_fb_Scales->size[1U],
          cpu_abscfssq->size[0U]);
      }
    }

    if (cpu_abscfssq->size[1] < 1) {
      g_cpu_y->size[0] = 1;
      g_cpu_y->size[1] = 0;
    } else {
      N = static_cast<uint32_T>(cpu_abscfssq->size[1]);
      eint = g_cpu_y->size[0] * g_cpu_y->size[1];
      g_cpu_y->size[0] = 1;
      g_cpu_y->size[1] = cpu_abscfssq->size[1];
      emxEnsureCapacity_uint32_T(g_cpu_y, eint, &d_emlrtRTEI);
      mwGetLaunchParameters1D(computeNumIters(static_cast<int32_T>(N) - 1),
        &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_uint32_T(g_cpu_y, &d_gpu_y, true);
      c_y_needsGpuEnsureCapacity = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel130<<<grid, block>>>(static_cast<int32_T>(N) - 1,
          d_gpu_y);
      }
    }

    eint = cpu_z->size[0];
    cpu_z->size[0] = cpu_abscfssq->size[0];
    emxEnsureCapacity_real_T(cpu_z, eint, &eb_emlrtRTEI);
    bcoef = cpu_abscfssq->size[0] - 1;
    mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real_T(cpu_z, &gpu_z, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel36<<<grid, block>>>(bcoef, gpu_z);
    }

    if (cpu_abscfssq->size[1] > 1) {
      if (g_cpu_y->size[1] == 1) {
        lidx = cpu_abscfssq->size[1];
        eint = cpu_c->size[0];
        cpu_c->size[0] = cpu_abscfssq->size[1];
        emxEnsureCapacity_real_T(cpu_c, eint, &gb_emlrtRTEI);
        mwGetLaunchParameters1D(computeNumIters(lidx - 1), &grid, &block,
          2147483647U);
        if (c_y_needsGpuEnsureCapacity) {
          gpuEmxEnsureCapacity_uint32_T(g_cpu_y, &d_gpu_y, true);
        }

        gpuEmxEnsureCapacity_real_T(cpu_c, &gpu_c, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_cwtAvg_kernel37<<<grid, block>>>(d_gpu_y, lidx - 1, gpu_c);
        }

        if (wav_outdatedOnCpu) {
          gpuEmxEnsureCapacity_real_T(cpu_abscfssq, &gpu_abscfssq, true);
        }

        c_y_needsGpuEnsureCapacity = false;
        ec_cwtAvg_kernel38<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(d_gpu_y,
          gpu_c, cpu_abscfssq->size[1U]);
      } else {
        eint = cpu_c->size[0];
        cpu_c->size[0] = cpu_abscfssq->size[1];
        emxEnsureCapacity_real_T(cpu_c, eint, &fb_emlrtRTEI);
        if (c_y_needsGpuEnsureCapacity) {
          gpuEmxEnsureCapacity_uint32_T(g_cpu_y, &d_gpu_y, true);
        }

        gpuEmxEnsureCapacity_real_T(cpu_c, &gpu_c, true);
        ec_cwtAvg_kernel127<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(d_gpu_y,
          gpu_c);
        cpu_nrefine = cpu_abscfssq->size[1];
        mwGetLaunchParameters1D(computeNumIters(cpu_nrefine - 3), &grid, &block,
          2147483647U);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_cwtAvg_kernel128<<<grid, block>>>(d_gpu_y, cpu_nrefine - 3, gpu_c);
        }

        c_y_needsGpuEnsureCapacity = false;
        if (wav_outdatedOnCpu) {
          gpuEmxEnsureCapacity_real_T(cpu_abscfssq, &gpu_abscfssq, true);
        }

        ec_cwtAvg_kernel129<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(d_gpu_y,
          gpu_c, cpu_abscfssq->size[1U]);
      }

      if (cpu_abscfssq->size[0] >= 1) {
        b_r = 0.0;
        delta = 1.0;
        cublasCheck(cublasDgemv(getCublasGlobalHandle(), CUBLAS_OP_N,
          cpu_abscfssq->size[0], cpu_abscfssq->size[1], (double *)&delta,
          (double *)&gpu_abscfssq.data[0], cpu_abscfssq->size[0], (double *)
          &gpu_c.data[0], 1, (double *)&b_r, (double *)&gpu_z.data[0], 1),
                    __FILE__, __LINE__);
      }
    }

    cpu_r = 0.0;
    wav_outdatedOnCpu = false;
    if (cpu_z->size[0] <= 1) {
      if (cpu_fb_Scales->size[1] == 1) {
        if (fb_Scales_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_fb_Scales, &gpu_fb_Scales);
        }

        fb_Scales_outdatedOnCpu = false;
        if (std::isinf(cpu_fb_Scales->data[0]) || std::isnan(cpu_fb_Scales->
             data[0])) {
          c_fb_Scales_needsGpuEnsureCapac = true;
          cpu_r = rtNaN;
        } else {
          c_fb_Scales_needsGpuEnsureCapac = true;
        }
      }
    } else {
      if (cpu_fb_Scales->size[1] == 1) {
        lidx = cpu_z->size[0];
        eint = b_cpu_c->size[0];
        b_cpu_c->size[0] = cpu_z->size[0];
        emxEnsureCapacity_real_T(b_cpu_c, eint, &gb_emlrtRTEI);
        mwGetLaunchParameters1D(computeNumIters(lidx - 1), &grid, &block,
          2147483647U);
        if (c_fb_Scales_needsGpuEnsureCapac) {
          gpuEmxEnsureCapacity_real_T(cpu_fb_Scales, &gpu_fb_Scales, true);
        }

        gpuEmxEnsureCapacity_real_T(b_cpu_c, &d_gpu_c, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_cwtAvg_kernel122<<<grid, block>>>(gpu_fb_Scales, lidx - 1, d_gpu_c);
        }

        if (fb_Scales_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_fb_Scales, &gpu_fb_Scales);
        }

        fb_Scales_outdatedOnCpu = false;
        b_r = 0.5 * cpu_fb_Scales->data[0];
        c_fb_Scales_needsGpuEnsureCapac = true;
        ec_cwtAvg_kernel123<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(b_r,
          d_gpu_c, cpu_z->size[0U]);
      } else {
        eint = b_cpu_c->size[0];
        b_cpu_c->size[0] = cpu_z->size[0];
        emxEnsureCapacity_real_T(b_cpu_c, eint, &fb_emlrtRTEI);
        if (c_fb_Scales_needsGpuEnsureCapac) {
          gpuEmxEnsureCapacity_real_T(cpu_fb_Scales, &gpu_fb_Scales, true);
        }

        gpuEmxEnsureCapacity_real_T(b_cpu_c, &d_gpu_c, true);
        ec_cwtAvg_kernel124<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
          (gpu_fb_Scales, d_gpu_c);
        cpu_nrefine = cpu_z->size[0];
        mwGetLaunchParameters1D(computeNumIters(cpu_nrefine - 3), &grid, &block,
          2147483647U);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_cwtAvg_kernel125<<<grid, block>>>(gpu_fb_Scales, cpu_nrefine - 3,
            d_gpu_c);
        }

        c_fb_Scales_needsGpuEnsureCapac = false;
        ec_cwtAvg_kernel126<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
          (gpu_fb_Scales, d_gpu_c, cpu_z->size[0U]);
      }

      b_r = 0.0;
      delta = 1.0;
      checkCudaError(cudaMemcpy(gpu_r, &cpu_r, 8UL, cudaMemcpyHostToDevice),
                     __FILE__, __LINE__);
      cublasCheck(cublasDgemv(getCublasGlobalHandle(), CUBLAS_OP_T, cpu_z->size
        [0], 1, (double *)&delta, (double *)&gpu_z.data[0], cpu_z->size[0],
        (double *)&d_gpu_c.data[0], 1, (double *)&b_r, (double *)gpu_r, 1),
                  __FILE__, __LINE__);
      wav_outdatedOnCpu = true;
    }

    if (!(s == 0.0)) {
      if (wav_outdatedOnCpu) {
        checkCudaError(cudaMemcpy(&cpu_r, gpu_r, 8UL, cudaMemcpyDeviceToHost),
                       __FILE__, __LINE__);
      }

      a = std::sqrt(s / (2.0 / b_c / static_cast<real_T>(cpu_abscfssq->size[1]) *
                         cpu_r));
      eint = cpu_cfspos->size[0] * cpu_cfspos->size[1];
      mwGetLaunchParameters1D(computeNumIters(eint - 1), &grid, &block,
        2147483647U);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel39<<<grid, block>>>(a, eint - 1, gpu_cfspos);
      }
    }

    cpu_nrefine = cpu_cfspos->size[0] * cpu_cfspos->size[1];
    for (bcoef = 0; bcoef < 2; bcoef++) {
      xSize[bcoef] = static_cast<uint32_T>(cpu_cfspos->size[bcoef]);
    }

    eint = h_cpu_y->size[0] * h_cpu_y->size[1];
    h_cpu_y->size[0] = static_cast<int32_T>(xSize[0]);
    h_cpu_y->size[1] = static_cast<int32_T>(xSize[1]);
    emxEnsureCapacity_real_T(h_cpu_y, eint, &k_emlrtRTEI);
    mwGetLaunchParameters1D(computeNumIters(cpu_nrefine - 1), &grid, &block,
      2147483647U);
    gpuEmxEnsureCapacity_real_T(h_cpu_y, &e_gpu_y, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel40<<<grid, block>>>(gpu_cfspos, cpu_nrefine - 1, e_gpu_y);
    }

    for (bcoef = 0; bcoef < 2; bcoef++) {
      xSize[bcoef] = static_cast<uint32_T>(h_cpu_y->size[bcoef]);
    }

    eint = cpu_abswt2->size[0] * cpu_abswt2->size[1];
    cpu_abswt2->size[0] = static_cast<int32_T>(xSize[0]);
    cpu_abswt2->size[1] = static_cast<int32_T>(xSize[1]);
    emxEnsureCapacity_real_T(cpu_abswt2, eint, &e_emlrtRTEI);
    cpu_nrefine = static_cast<int32_T>(xSize[0]) * static_cast<int32_T>(xSize[1]);
    mwGetLaunchParameters1D(computeNumIters(cpu_nrefine - 1), &grid, &block,
      2147483647U);
    gpuEmxEnsureCapacity_real_T(cpu_abswt2, &gpu_abswt2, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel41<<<grid, block>>>(e_gpu_y, cpu_nrefine - 1, gpu_abswt2);
    }

    if (cpu_abswt2->size[0] == cpu_fb_Scales->size[1]) {
      eint = cpu_abswt2S->size[0] * cpu_abswt2S->size[1];
      cpu_abswt2S->size[0] = cpu_abswt2->size[0];
      cpu_abswt2S->size[1] = cpu_abswt2->size[1];
      emxEnsureCapacity_real_T(cpu_abswt2S, eint, &hb_emlrtRTEI);
      bcoef = cpu_abswt2->size[1] - 1;
      nsubs = cpu_abswt2->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(bcoef, nsubs), &grid, &block,
        2147483647U);
      if (c_fb_Scales_needsGpuEnsureCapac) {
        gpuEmxEnsureCapacity_real_T(cpu_fb_Scales, &gpu_fb_Scales, true);
      }

      c_fb_Scales_needsGpuEnsureCapac = false;
      gpuEmxEnsureCapacity_real_T(cpu_abswt2S, &gpu_abswt2S, true);
      fx_data_outdatedOnCpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel42<<<grid, block>>>(gpu_fb_Scales, gpu_abswt2, nsubs,
          bcoef, gpu_abswt2S, cpu_abswt2S->size[0U], cpu_abswt2->size[0U]);
      }

      wav_outdatedOnCpu = false;
      abswt2S_outdatedOnCpu = true;
    } else {
      if (abswt2S_outdatedOnCpu) {
        gpuEmxMemcpyGpuToCpu_real_T(cpu_abswt2S, &gpu_abswt2S);
      }

      gpuEmxMemcpyGpuToCpu_real_T(cpu_abswt2, &gpu_abswt2);
      if (fb_Scales_outdatedOnCpu) {
        gpuEmxMemcpyGpuToCpu_real_T(cpu_fb_Scales, &gpu_fb_Scales);
      }

      fb_Scales_outdatedOnCpu = false;
      binary_expand_op_2(cpu_abswt2S, cpu_abswt2, cpu_fb_Scales);
      abswt2S_outdatedOnCpu = false;
      wav_outdatedOnCpu = true;
      c_fb_Scales_needsGpuEnsureCapac = true;
      fx_data_outdatedOnCpu = true;
    }

    eint = i_cpu_y->size[0] * i_cpu_y->size[1];
    i_cpu_y->size[0] = static_cast<int32_T>(defaultSL_idx_1);
    i_cpu_y->size[1] = cpu_abswt2S->size[1];
    emxEnsureCapacity_real_T(i_cpu_y, eint, &ib_emlrtRTEI);
    bcoef = cpu_abswt2S->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(bcoef, static_cast<int32_T>
      (defaultSL_idx_1) - 1), &grid, &block, 2147483647U);
    if (fx_data_outdatedOnCpu) {
      gpuEmxEnsureCapacity_real_T(cpu_abswt2S, &gpu_abswt2S, !wav_outdatedOnCpu);
    }

    gpuEmxEnsureCapacity_real_T(i_cpu_y, &f_gpu_y, true);
    if (wav_outdatedOnCpu) {
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_abswt2S, cpu_abswt2S);
    }

    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel43<<<grid, block>>>(gpu_abswt2S, static_cast<int32_T>
        (defaultSL_idx_1) - 1, bcoef, f_gpu_y, i_cpu_y->size[0U],
        cpu_abswt2S->size[0U]);
    }

    if ((static_cast<int32_T>(defaultSL_idx_1) == 0) && (cpu_abswt2S->size[1] ==
         0)) {
      if (static_cast<int32_T>(defaultSL_idx_1) == 1) {
        if (c_fb_Scales_needsGpuEnsureCapac) {
          gpuEmxEnsureCapacity_real_T(cpu_fb_Scales, &gpu_fb_Scales, true);
        }

        c_fb_Scales_needsGpuEnsureCapac = false;
        ec_cwtAvg_kernel44<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
          (gpu_fb_Scales, gpu_r);
        wav_outdatedOnCpu = false;
      } else {
        cpu_r = 0.0;
        wav_outdatedOnCpu = true;
      }

      eint = cpu_savgpTMP->size[0] * cpu_savgpTMP->size[1];
      cpu_savgpTMP->size[0] = 1;
      cpu_savgpTMP->size[1] = 1;
      emxEnsureCapacity_real_T(cpu_savgpTMP, eint, &jb_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(cpu_savgpTMP, &gpu_savgpTMP, true);
      if (wav_outdatedOnCpu) {
        checkCudaError(cudaMemcpy(gpu_r, &cpu_r, 8UL, cudaMemcpyHostToDevice),
                       __FILE__, __LINE__);
      }

      ec_cwtAvg_kernel45<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_r,
        gpu_savgpTMP);
    } else {
      eint = cpu_savgpTMP->size[0] * cpu_savgpTMP->size[1];
      cpu_savgpTMP->size[0] = 1;
      cpu_savgpTMP->size[1] = cpu_abswt2S->size[1];
      emxEnsureCapacity_real_T(cpu_savgpTMP, eint, &jb_emlrtRTEI);
      bcoef = cpu_abswt2S->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(cpu_savgpTMP, &gpu_savgpTMP, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel115<<<grid, block>>>(bcoef, gpu_savgpTMP);
      }

      if (static_cast<int32_T>(defaultSL_idx_1) <= 1) {
        if (static_cast<int32_T>(defaultSL_idx_1) == 1) {
          if (fb_Scales_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_fb_Scales, &gpu_fb_Scales);
          }

          fb_Scales_outdatedOnCpu = false;
          if (std::isinf(cpu_fb_Scales->data[0]) || std::isnan
              (cpu_fb_Scales->data[0])) {
            c_fb_Scales_needsGpuEnsureCapac = true;
            eint = cpu_savgpTMP->size[0] * cpu_savgpTMP->size[1];
            cpu_savgpTMP->size[0] = 1;
            cpu_savgpTMP->size[1] = cpu_abswt2S->size[1];
            emxEnsureCapacity_real_T(cpu_savgpTMP, eint, &jb_emlrtRTEI);
            bcoef = cpu_abswt2S->size[1] - 1;
            mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block,
              2147483647U);
            gpuEmxEnsureCapacity_real_T(cpu_savgpTMP, &gpu_savgpTMP, true);
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwtAvg_kernel116<<<grid, block>>>(bcoef, gpu_savgpTMP);
            }
          } else {
            c_fb_Scales_needsGpuEnsureCapac = true;
          }
        }
      } else {
        if (static_cast<int32_T>(defaultSL_idx_1) == 1) {
          eint = c_cpu_c->size[0];
          c_cpu_c->size[0] = static_cast<int32_T>(defaultSL_idx_1);
          emxEnsureCapacity_real_T(c_cpu_c, eint, &gb_emlrtRTEI);
          mwGetLaunchParameters1D(computeNumIters(static_cast<int32_T>
            (defaultSL_idx_1) - 1), &grid, &block, 2147483647U);
          if (c_fb_Scales_needsGpuEnsureCapac) {
            gpuEmxEnsureCapacity_real_T(cpu_fb_Scales, &gpu_fb_Scales, true);
          }

          gpuEmxEnsureCapacity_real_T(c_cpu_c, &c_gpu_c, true);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel117<<<grid, block>>>(gpu_fb_Scales,
              static_cast<int32_T>(defaultSL_idx_1) - 1, c_gpu_c);
          }

          c_fb_Scales_needsGpuEnsureCapac = false;
          ec_cwtAvg_kernel118<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
            static_cast<int32_T>(defaultSL_idx_1), gpu_fb_Scales, c_gpu_c);
        } else {
          eint = c_cpu_c->size[0];
          c_cpu_c->size[0] = static_cast<int32_T>(defaultSL_idx_1);
          emxEnsureCapacity_real_T(c_cpu_c, eint, &fb_emlrtRTEI);
          if (c_fb_Scales_needsGpuEnsureCapac) {
            gpuEmxEnsureCapacity_real_T(cpu_fb_Scales, &gpu_fb_Scales, true);
          }

          gpuEmxEnsureCapacity_real_T(c_cpu_c, &c_gpu_c, true);
          ec_cwtAvg_kernel119<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
            (gpu_fb_Scales, c_gpu_c);
          mwGetLaunchParameters1D(computeNumIters(static_cast<int32_T>
            (defaultSL_idx_1) - 3), &grid, &block, 2147483647U);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel120<<<grid, block>>>(gpu_fb_Scales,
              static_cast<int32_T>(defaultSL_idx_1) - 3, c_gpu_c);
          }

          c_fb_Scales_needsGpuEnsureCapac = false;
          ec_cwtAvg_kernel121<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
            (gpu_fb_Scales, static_cast<int32_T>(defaultSL_idx_1), c_gpu_c);
        }

        if (cpu_abswt2S->size[1] >= 1) {
          b_r = 0.0;
          delta = 1.0;
          cublasCheck(cublasDgemv(getCublasGlobalHandle(), CUBLAS_OP_T,
            static_cast<int32_T>(defaultSL_idx_1), cpu_abswt2S->size[1], (double
            *)&delta, (double *)&f_gpu_y.data[0], static_cast<int32_T>
            (defaultSL_idx_1), (double *)&c_gpu_c.data[0], 1, (double *)&b_r,
            (double *)&gpu_savgpTMP.data[0], 1), __FILE__, __LINE__);
        }
      }
    }

    eint = cpu_xCh->size[0];
    cpu_xCh->size[0] = cpu_savgpTMP->size[1];
    emxEnsureCapacity_real_T(cpu_xCh, eint, &kb_emlrtRTEI);
    bcoef = cpu_savgpTMP->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real_T(cpu_xCh, &gpu_xCh, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwtAvg_kernel46<<<grid, block>>>(gpu_savgpTMP, bcoef, gpu_xCh);
    }

    xCh_outdatedOnCpu = true;

    //  Downsample
    // 'ec_cwtAvg:38' if doDownsample
    if (doDownsample) {
      int64_T e;
      real_T varargin_2[4];
      int32_T omega_tmp2[1];

      // 'ec_cwtAvg:39' y{ch} = resample(xCh,ds(1),ds(2));
      fc = ds[0] / ds[1];
      b_c = fc;
      cpu_r = std::abs(fc);
      if (std::isinf(cpu_r) || std::isnan(cpu_r)) {
        r = rtNaN;
      } else if (cpu_r < 4.4501477170144028E-308) {
        r = 4.94065645841247E-324;
      } else {
        std::frexp(cpu_r, &exponent);
        r = std::ldexp(1.0, exponent - 53);
      }

      tau = std::fmax(1.0E-12, r);
      if (std::isinf(fc) || std::isnan(fc)) {
        if (!std::isnan(fc)) {
          if (fc < 0.0) {
            q_ok = -1.0;
          } else {
            q_ok = 1.0;
          }
        } else {
          q_ok = 0.0;
        }

        tau = 0.0;
      } else {
        cpu_r = 1.0;
        d = 0.0;
        b_r = 0.0;
        delta = 1.0;
        do {
          exitg1 = 0;
          intFsq = std::round(fc);
          if (!std::isinf(fc)) {
            fc -= intFsq;
            intDsq = b_r;
            b_r = cpu_r;
            cpu_r = cpu_r * intFsq + intDsq;
            intDsq = delta;
            delta = d;
            d = d * intFsq + intDsq;
          } else {
            b_r = cpu_r;
            delta = d;
            cpu_r = fc;
            d = 0.0;
          }

          if ((fc == 0.0) || (std::abs(cpu_r / d - b_c) <= tau)) {
            exitg1 = 1;
          } else {
            fc = 1.0 / fc;
          }
        } while (exitg1 == 0);

        if (std::isnan(d)) {
          fb_VoicesPerOctave = rtNaN;
        } else if (d < 0.0) {
          fb_VoicesPerOctave = -1.0;
        } else {
          fb_VoicesPerOctave = (d > 0.0);
        }

        q_ok = cpu_r / fb_VoicesPerOctave;
        tau = std::abs(d);
      }

      b_r = std::fmax(q_ok, tau);
      fc = 0.5 / b_r;
      s = 20.0 * b_r + 1.0;
      varargin_2[0] = 0.0;
      varargin_2[1] = 2.0 * fc;
      varargin_2[2] = 2.0 * fc;
      varargin_2[3] = 1.0;
      cpu_r = 0.0;
      delta = 0.0;
      for (nG = 0; nG < 3; nG++) {
        fc = varargin_2[nG + 1];
        if (std::isnan(fc)) {
          first_iteration = false;
        } else if (std::isnan(cpu_r)) {
          first_iteration = true;
        } else {
          first_iteration = (cpu_r < fc);
        }

        if (first_iteration) {
          cpu_r = fc;
        }

        if (std::isnan(fc)) {
          first_iteration = false;
        } else if (std::isnan(delta)) {
          first_iteration = true;
        } else {
          first_iteration = (delta > fc);
        }

        if (first_iteration) {
          delta = fc;
        }
      }

      if ((!(cpu_r > 1.0)) && (!(delta < 0.0))) {
        real_T F[4];
        boolean_T Nodd;
        boolean_T b_outdatedOnGpu;
        for (bcoef = 0; bcoef < 4; bcoef++) {
          F[bcoef] = varargin_2[bcoef] / 2.0;
        }

        b_c = (((s - 1.0) + 1.0) - 1.0) / 2.0;
        Nodd = (rt_remd_snf((s - 1.0) + 1.0, 2.0) == 1.0);
        intFsq = 0.0;
        if (!Nodd) {
          eint = cpu_m->size[0] * cpu_m->size[1];
          cpu_m->size[0] = 1;
          cpu_m->size[1] = static_cast<int32_T>(b_c) + 1;
          emxEnsureCapacity_real_T(cpu_m, eint, &pb_emlrtRTEI);
          mwGetLaunchParameters1D(computeNumIters(static_cast<int32_T>(b_c)),
            &grid, &block, 2147483647U);
          gpuEmxEnsureCapacity_real_T(cpu_m, &gpu_m, true);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel80<<<grid, block>>>(static_cast<int32_T>(b_c), gpu_m);
          }
        } else {
          eint = cpu_m->size[0] * cpu_m->size[1];
          cpu_m->size[0] = 1;
          cpu_m->size[1] = static_cast<int32_T>(b_c) + 1;
          emxEnsureCapacity_real_T(cpu_m, eint, &ob_emlrtRTEI);
          mwGetLaunchParameters1D(computeNumIters(static_cast<int32_T>(b_c)),
            &grid, &block, 2147483647U);
          gpuEmxEnsureCapacity_real_T(cpu_m, &gpu_m, true);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel114<<<grid, block>>>(static_cast<int32_T>(b_c),
              gpu_m);
          }
        }

        eint = cpu_k->size[0];
        cpu_k->size[0] = cpu_m->size[1];
        emxEnsureCapacity_real_T(cpu_k, eint, &rb_emlrtRTEI);
        bcoef = cpu_m->size[1] - 1;
        mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block,
          2147483647U);
        gpuEmxEnsureCapacity_real_T(cpu_k, &gpu_k, true);
        fx_data_outdatedOnCpu = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_cwtAvg_kernel81<<<grid, block>>>(gpu_m, bcoef, gpu_k);
        }

        c_omega_tmp1_needsGpuEnsureCapa = false;
        wav_outdatedOnCpu = true;
        first_iteration = (F[2] - F[1] != 0.0);
        nG = cpu_k->size[0];
        if (first_iteration) {
          eint = cpu_G->size[0] * cpu_G->size[1];
          cpu_G->size[0] = cpu_k->size[0];
          cpu_G->size[1] = cpu_k->size[0];
          emxEnsureCapacity_real_T(cpu_G, eint, &tb_emlrtRTEI);
          k = cpu_k->size[0] * cpu_k->size[0] - 1;
          mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
          gpuEmxEnsureCapacity_real_T(cpu_G, &gpu_G, true);
          G_needsGpuEnsureCapacity = false;
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel82<<<grid, block>>>(k, gpu_G);
          }

          b_fx_data_outdatedOnCpu = true;
          intDsq = 2.0 * static_cast<real_T>(cpu_k->size[0]) - 1.0;
        } else {
          b_fx_data_outdatedOnCpu = false;
          cpu_G->size[0] = 0;
          cpu_G->size[1] = 0;
          intDsq = 0.0;
        }

        eint = cpu_sinc1A->size[0] * cpu_sinc1A->size[1];
        cpu_sinc1A->size[0] = 1;
        cpu_sinc1A->size[1] = static_cast<int32_T>(intDsq);
        emxEnsureCapacity_real_T(cpu_sinc1A, eint, &ub_emlrtRTEI);
        y_needsGpuEnsureCapacity = true;
        eint = cpu_sinc2A->size[0] * cpu_sinc2A->size[1];
        cpu_sinc2A->size[0] = 1;
        cpu_sinc2A->size[1] = static_cast<int32_T>(intDsq);
        emxEnsureCapacity_real_T(cpu_sinc2A, eint, &vb_emlrtRTEI);
        b_y_needsGpuEnsureCapacity = true;
        eint = cpu_sinc3A->size[0] * cpu_sinc3A->size[1];
        cpu_sinc3A->size[0] = 1;
        cpu_sinc3A->size[1] = static_cast<int32_T>(intDsq);
        emxEnsureCapacity_real_T(cpu_sinc3A, eint, &wb_emlrtRTEI);
        fb_Omega_outdatedOnCpu = true;
        eint = cpu_sinc4A->size[0] * cpu_sinc4A->size[1];
        cpu_sinc4A->size[0] = 1;
        cpu_sinc4A->size[1] = static_cast<int32_T>(intDsq);
        emxEnsureCapacity_real_T(cpu_sinc4A, eint, &yb_emlrtRTEI);
        interval_outdatedOnGpu = true;
        if (Nodd) {
          nx = -1;
          if (cpu_k->size[0] < 2) {
            cpu_nrefine = 0;
            ix = 0;
          } else {
            cpu_nrefine = 1;
            ix = cpu_k->size[0];
          }

          nsubs = ix - cpu_nrefine;
          for (eint = 0; eint < nsubs; eint++) {
            if (wav_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(cpu_k, &gpu_k);
            }

            cpu_k->data[eint] = cpu_k->data[cpu_nrefine + eint];
            wav_outdatedOnCpu = false;
            c_omega_tmp1_needsGpuEnsureCapa = true;
          }

          eint = cpu_k->size[0];
          cpu_k->size[0] = ix - cpu_nrefine;
          emxEnsureCapacity_real_T(cpu_k, eint, &bc_emlrtRTEI);
          fx_data_outdatedOnCpu = true;
        } else {
          nx = 0;
        }

        eint = cpu_b->size[0];
        cpu_b->size[0] = cpu_k->size[0];
        emxEnsureCapacity_real_T(cpu_b, eint, &ac_emlrtRTEI);
        k = cpu_k->size[0] - 1;
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        gpuEmxEnsureCapacity_real_T(cpu_b, &gpu_b, true);
        h_needsGpuEnsureCapacity = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_cwtAvg_kernel83<<<grid, block>>>(k, gpu_b);
        }

        b_outdatedOnGpu = false;
        subs_outdatedOnCpu = true;
        for (ix = 0; ix < 2; ix++) {
          lidx = ix << 1;
          n_idx_0 = A[lidx];
          delta = F[lidx + 1];
          fc = F[lidx];
          cpu_r = static_cast<real_T>(A[lidx + 1] - n_idx_0) / (delta - fc);
          b_r = static_cast<real_T>(n_idx_0) - cpu_r * fc;
          if (Nodd) {
            intFsq += b_r * (delta - fc) + cpu_r / 2.0 * (delta * delta - fc *
              fc);
          }

          eint = cpu_dv23->size[0];
          cpu_dv23->size[0] = cpu_k->size[0];
          emxEnsureCapacity_real_T(cpu_dv23, eint, &gc_emlrtRTEI);
          k = cpu_k->size[0] - 1;
          mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
          if (fx_data_outdatedOnCpu) {
            gpuEmxEnsureCapacity_real_T(cpu_k, &gpu_k,
              !c_omega_tmp1_needsGpuEnsureCapa);
          }

          gpuEmxEnsureCapacity_real_T(cpu_dv23, &gpu_dv23, true);
          if (c_omega_tmp1_needsGpuEnsureCapa) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_k, cpu_k);
          }

          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel84<<<grid, block>>>(delta, gpu_k, k, gpu_dv23);
          }

          cpu_nrefine = cpu_dv23->size[0];
          eint = cpu_dv24->size[0];
          cpu_dv24->size[0] = cpu_k->size[0];
          emxEnsureCapacity_real_T(cpu_dv24, eint, &gc_emlrtRTEI);
          mwGetLaunchParameters1D(computeNumIters(cpu_nrefine - 1), &grid,
            &block, 2147483647U);
          gpuEmxEnsureCapacity_real_T(cpu_dv24, &gpu_dv24, true);
          c_omega_tmp1_needsGpuEnsureCapa = false;
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel85<<<grid, block>>>(F[lidx], gpu_k, cpu_nrefine - 1,
              gpu_dv24, gpu_dv23);
          }

          cpu_nrefine = cpu_dv24->size[0];
          mwGetLaunchParameters1D(computeNumIters(cpu_nrefine - 1), &grid,
            &block, 2147483647U);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel86<<<grid, block>>>(cpu_nrefine - 1, gpu_dv24);
          }

          a = cpu_r / 39.478417604357432;
          if (cpu_dv23->size[0] == 1) {
            bcoef = cpu_k->size[0];
          } else {
            bcoef = cpu_dv23->size[0];
          }

          if ((cpu_dv23->size[0] == cpu_k->size[0]) && (cpu_b->size[0] == bcoef))
          {
            bcoef = cpu_b->size[0] - 1;
            mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block,
              2147483647U);
            fx_data_outdatedOnCpu = false;
            if (h_needsGpuEnsureCapacity) {
              gpuEmxEnsureCapacity_real_T(cpu_b, &gpu_b, !b_outdatedOnGpu);
            }

            h_needsGpuEnsureCapacity = false;
            if (b_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, cpu_b);
            }

            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwtAvg_kernel87<<<grid, block>>>(gpu_k, gpu_dv24, gpu_dv23, a,
                bcoef, gpu_b);
            }

            b_outdatedOnGpu = false;
            subs_outdatedOnCpu = true;
          } else {
            if (subs_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(cpu_b, &gpu_b);
            }

            gpuEmxMemcpyGpuToCpu_real_T(cpu_dv23, &gpu_dv23);
            gpuEmxMemcpyGpuToCpu_real_T(cpu_dv24, &gpu_dv24);
            if (wav_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(cpu_k, &gpu_k);
            }

            wav_outdatedOnCpu = false;
            binary_expand_op_1(cpu_b, a, cpu_dv23, cpu_dv24, cpu_k);
            subs_outdatedOnCpu = false;
            b_outdatedOnGpu = true;
            fx_data_outdatedOnCpu = true;
            h_needsGpuEnsureCapacity = true;
          }

          eint = k_cpu_y->size[0];
          k_cpu_y->size[0] = cpu_k->size[0];
          emxEnsureCapacity_real_T(k_cpu_y, eint, &gc_emlrtRTEI);
          k = cpu_k->size[0] - 1;
          mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
          if (fx_data_outdatedOnCpu) {
            gpuEmxEnsureCapacity_real_T(cpu_k, &gpu_k, true);
          }

          gpuEmxEnsureCapacity_real_T(k_cpu_y, &l_gpu_y, true);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel88<<<grid, block>>>(F[lidx + 1], gpu_k, k, l_gpu_y);
          }

          cpu_nrefine = k_cpu_y->size[0];
          fc = F[lidx + 1];
          a = fc * (cpu_r * fc + b_r);
          eint = l_cpu_y->size[0];
          l_cpu_y->size[0] = cpu_k->size[0];
          emxEnsureCapacity_real_T(l_cpu_y, eint, &gc_emlrtRTEI);
          mwGetLaunchParameters1D(computeNumIters(cpu_nrefine - 1), &grid,
            &block, 2147483647U);
          fx_data_outdatedOnCpu = false;
          gpuEmxEnsureCapacity_real_T(l_cpu_y, &m_gpu_y, true);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel89<<<grid, block>>>(F[lidx], gpu_k, cpu_nrefine - 1,
              m_gpu_y, l_gpu_y);
          }

          cpu_nrefine = l_cpu_y->size[0];
          mwGetLaunchParameters1D(computeNumIters(cpu_nrefine - 1), &grid,
            &block, 2147483647U);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel90<<<grid, block>>>(cpu_nrefine - 1, m_gpu_y);
          }

          fc = F[lidx];
          delta = fc * (cpu_r * fc + b_r);
          if (cpu_b->size[0] == k_cpu_y->size[0]) {
            bcoef = cpu_b->size[0] - 1;
            mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block,
              2147483647U);
            if (h_needsGpuEnsureCapacity) {
              gpuEmxEnsureCapacity_real_T(cpu_b, &gpu_b, !b_outdatedOnGpu);
            }

            h_needsGpuEnsureCapacity = false;
            if (b_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, cpu_b);
            }

            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwtAvg_kernel91<<<grid, block>>>(m_gpu_y, delta, l_gpu_y, a,
                bcoef, gpu_b);
            }

            b_outdatedOnGpu = false;
            subs_outdatedOnCpu = true;
          } else {
            if (subs_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(cpu_b, &gpu_b);
            }

            gpuEmxMemcpyGpuToCpu_real_T(k_cpu_y, &l_gpu_y);
            gpuEmxMemcpyGpuToCpu_real_T(l_cpu_y, &m_gpu_y);
            binary_expand_op(cpu_b, a, k_cpu_y, delta, l_cpu_y);
            subs_outdatedOnCpu = false;
            b_outdatedOnGpu = true;
            h_needsGpuEnsureCapacity = true;
          }

          if (first_iteration) {
            cpu_r = 2.0 * F[lidx + 1];
            b_r = 2.0 * F[lidx];
            mwGetLaunchParameters1D(computeNumIters(static_cast<int32_T>(intDsq)
              - 1), &grid, &block, 2147483647U);
            if (interval_outdatedOnGpu) {
              gpuEmxEnsureCapacity_real_T(cpu_sinc4A, &gpu_sinc4A, true);
            }

            if (fb_Omega_outdatedOnCpu) {
              gpuEmxEnsureCapacity_real_T(cpu_sinc3A, &gpu_sinc3A, true);
            }

            if (b_y_needsGpuEnsureCapacity) {
              gpuEmxEnsureCapacity_real_T(cpu_sinc2A, &gpu_sinc2A, true);
            }

            if (y_needsGpuEnsureCapacity) {
              gpuEmxEnsureCapacity_real_T(cpu_sinc1A, &gpu_sinc1A, true);
            }

            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwtAvg_kernel92<<<grid, block>>>(b_r, cpu_r, nG, nx,
                static_cast<int32_T>(intDsq) - 1, gpu_sinc4A, gpu_sinc3A,
                gpu_sinc2A, gpu_sinc1A);
            }

            mwGetLaunchParameters1D(computeNumIters(nG - 1, nG - 1), &grid,
              &block, 2147483647U);
            interval_outdatedOnGpu = false;
            b_y_needsGpuEnsureCapacity = false;
            fb_Omega_outdatedOnCpu = false;
            y_needsGpuEnsureCapacity = false;
            if (G_needsGpuEnsureCapacity) {
              gpuEmxEnsureCapacity_real_T(cpu_G, &gpu_G, true);
            }

            G_needsGpuEnsureCapacity = false;
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwtAvg_kernel93<<<grid, block>>>(gpu_sinc4A, gpu_sinc2A, b_r,
                gpu_sinc3A, gpu_sinc1A, cpu_r, nG, nG - 1, nG - 1, gpu_G,
                cpu_G->size[0U]);
            }

            b_fx_data_outdatedOnCpu = true;
          }
        }

        if (Nodd) {
          eint = cpu_b0->size[0];
          cpu_b0->size[0] = cpu_b->size[0] + 1;
          emxEnsureCapacity_real_T(cpu_b0, eint, &dc_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(cpu_b0, &gpu_b0, true);
          ec_cwtAvg_kernel94<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(intFsq,
            gpu_b0);
          nsubs = cpu_b->size[0];
          mwGetLaunchParameters1D(computeNumIters(nsubs - 1), &grid, &block,
            2147483647U);
          if (h_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real_T(cpu_b, &gpu_b, !b_outdatedOnGpu);
          }

          if (b_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, cpu_b);
          }

          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel95<<<grid, block>>>(gpu_b, nsubs - 1, gpu_b0);
          }

          eint = cpu_b->size[0];
          cpu_b->size[0] = cpu_b0->size[0];
          emxEnsureCapacity_real_T(cpu_b, eint, &ic_emlrtRTEI);
          bcoef = cpu_b0->size[0] - 1;
          mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block,
            2147483647U);
          gpuEmxEnsureCapacity_real_T(cpu_b, &gpu_b, true);
          h_needsGpuEnsureCapacity = false;
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel96<<<grid, block>>>(gpu_b0, bcoef, gpu_b);
          }

          b_outdatedOnGpu = false;
        }

        if (first_iteration) {
          if ((cpu_G->size[0] == 0) || (cpu_G->size[1] == 0) || (cpu_b->size[0] ==
               0)) {
            eint = b_cpu_a->size[0];
            b_cpu_a->size[0] = cpu_G->size[1];
            emxEnsureCapacity_real_T(b_cpu_a, eint, &fc_emlrtRTEI);
            bcoef = cpu_G->size[1] - 1;
            mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block,
              2147483647U);
            gpuEmxEnsureCapacity_real_T(b_cpu_a, &b_gpu_a, true);
            c_omega_tmp1_needsGpuEnsureCapa = false;
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwtAvg_kernel97<<<grid, block>>>(bcoef, b_gpu_a);
            }

            fx_data_outdatedOnCpu = false;
            y_needsGpuEnsureCapacity = true;
          } else if (cpu_G->size[0] == cpu_G->size[1]) {
            eint = b_cpu_a->size[0];
            b_cpu_a->size[0] = cpu_b->size[0];
            emxEnsureCapacity_real_T(b_cpu_a, eint, &fc_emlrtRTEI);
            bcoef = cpu_b->size[0] - 1;
            mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block,
              2147483647U);
            if (h_needsGpuEnsureCapacity) {
              gpuEmxEnsureCapacity_real_T(cpu_b, &gpu_b, !b_outdatedOnGpu);
            }

            gpuEmxEnsureCapacity_real_T(b_cpu_a, &b_gpu_a, true);
            if (b_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, cpu_b);
            }

            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwtAvg_kernel102<<<grid, block>>>(gpu_b, bcoef, b_gpu_a);
            }

            nG = cpu_G->size[0];
            lidx = cpu_G->size[1];
            if (nG <= lidx) {
              lidx = nG;
            }

            nG = b_cpu_a->size[0];
            if (nG <= lidx) {
              lidx = nG;
            }

            eint = cpu_IPIV->size[0];
            cpu_IPIV->size[0] = lidx;
            emxEnsureCapacity_int32_T(cpu_IPIV, eint, &lc_emlrtRTEI);
            if (G_needsGpuEnsureCapacity) {
              gpuEmxEnsureCapacity_real_T(cpu_G, &gpu_G, true);
            }

            cusolverCheck(cusolverDnDgetrf_bufferSize(getCuSolverGlobalHandle(),
              lidx, lidx, (double *)&gpu_G.data[0], cpu_G->size[0],
              getCuSolverWorkspaceReq()), __FILE__, __LINE__);
            setCuSolverWorkspaceTypeSize(8);
            cusolverInitWorkspace();
            G_needsGpuEnsureCapacity = false;
            gpuEmxEnsureCapacity_int32_T(cpu_IPIV, &gpu_IPIV, true);
            cusolverCheck(cusolverDnDgetrf(getCuSolverGlobalHandle(), lidx, lidx,
              (double *)&gpu_G.data[0], cpu_G->size[0], static_cast<real_T *>
              (getCuSolverWorkspaceBuff()), &gpu_IPIV.data[0], gpu_nrefine),
                          __FILE__, __LINE__);
            checkCudaError(cudaMemcpy(&cpu_nrefine, gpu_nrefine, 4UL,
              cudaMemcpyDeviceToHost), __FILE__, __LINE__);
            if (cpu_nrefine < 0) {
              omega_tmp2[0] = b_cpu_a->size[0];
              eint = b_cpu_a->size[0];
              b_cpu_a->size[0] = omega_tmp2[0];
              emxEnsureCapacity_real_T(b_cpu_a, eint, &pc_emlrtRTEI);
              mwGetLaunchParameters1D(computeNumIters(omega_tmp2[0] - 1), &grid,
                &block, 2147483647U);
              gpuEmxEnsureCapacity_real_T(b_cpu_a, &b_gpu_a, true);
              c_omega_tmp1_needsGpuEnsureCapa = false;
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel103<<<grid, block>>>(omega_tmp2[0] - 1, b_gpu_a);
              }

              fx_data_outdatedOnCpu = false;
              y_needsGpuEnsureCapacity = true;
            } else {
              c_omega_tmp1_needsGpuEnsureCapa = false;
              cusolverCheck(cusolverDnDgetrs(getCuSolverGlobalHandle(),
                CUBLAS_OP_N, lidx, 1, (double *)&gpu_G.data[0], cpu_G->size[0],
                &gpu_IPIV.data[0], (double *)&b_gpu_a.data[0], b_cpu_a->size[0],
                gpu_nrefine), __FILE__, __LINE__);
              fx_data_outdatedOnCpu = false;
              y_needsGpuEnsureCapacity = true;
            }
          } else {
            ptrdiff_t info_t;
            lidx = cpu_G->size[0];
            nx = cpu_G->size[1] - 1;
            eint = cpu_jpvt->size[0] * cpu_jpvt->size[1];
            cpu_jpvt->size[0] = 1;
            cpu_jpvt->size[1] = cpu_G->size[1];
            emxEnsureCapacity_int32_T(cpu_jpvt, eint, &jc_emlrtRTEI);
            bcoef = cpu_G->size[1] - 1;
            mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block,
              2147483647U);
            gpuEmxEnsureCapacity_int32_T(cpu_jpvt, &gpu_jpvt, true);
            interval_outdatedOnGpu = false;
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwtAvg_kernel104<<<grid, block>>>(bcoef, gpu_jpvt);
            }

            y_needsGpuEnsureCapacity = false;
            b_y_needsGpuEnsureCapacity = true;
            nG = cpu_G->size[0];
            cpu_nrefine = cpu_G->size[1];
            if (nG <= cpu_nrefine) {
              cpu_nrefine = nG;
            }

            eint = cpu_tau->size[0];
            cpu_tau->size[0] = cpu_nrefine;
            emxEnsureCapacity_real_T(cpu_tau, eint, &nc_emlrtRTEI);
            eint = jpvt_t->size[0];
            jpvt_t->size[0] = cpu_G->size[1];
            emxEnsureCapacity_ptrdiff_t(jpvt_t, eint, &oc_emlrtRTEI);
            for (eint = 0; eint < cpu_G->size[1]; eint++) {
              jpvt_t->data[eint] = (ptrdiff_t)0;
            }

            if (b_fx_data_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(cpu_G, &gpu_G);
            }

            info_t = LAPACKE_dgeqp3(102, (ptrdiff_t)cpu_G->size[0], (ptrdiff_t)
              cpu_G->size[1], &cpu_G->data[0], (ptrdiff_t)cpu_G->size[0],
              &jpvt_t->data[0], &cpu_tau->data[0]);
            fx_data_outdatedOnCpu = true;
            b_fx_data_outdatedOnCpu = false;
            c_omega_tmp1_needsGpuEnsureCapa = true;
            wav_outdatedOnCpu = true;
            if ((int32_T)info_t != 0) {
              mwGetLaunchParameters1D(computeNumIters(nx, lidx - 1), &grid,
                &block, 2147483647U);
              gpuEmxEnsureCapacity_real_T(cpu_G, &gpu_G, false);
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_G, cpu_G);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel105<<<grid, block>>>(lidx - 1, nx, gpu_G,
                  cpu_G->size[0U]);
              }

              c_omega_tmp1_needsGpuEnsureCapa = false;
              b_fx_data_outdatedOnCpu = true;
              nG = cpu_G->size[0];
              lidx = cpu_G->size[1];
              if (nG <= lidx) {
                lidx = nG;
              }

              mwGetLaunchParameters1D(computeNumIters(lidx - 1), &grid, &block,
                2147483647U);
              gpuEmxEnsureCapacity_real_T(cpu_tau, &gpu_tau, false);
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_tau, cpu_tau);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel106<<<grid, block>>>(lidx - 1, gpu_tau);
              }

              e = computeEndIdx(static_cast<int64_T>(lidx + 1),
                                static_cast<int64_T>(cpu_nrefine), 1L);
              mwGetLaunchParameters1D(computeNumIters(e), &grid, &block,
                2147483647U);
              wav_outdatedOnCpu = false;
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel107<<<grid, block>>>(lidx + 1, e, gpu_tau);
              }

              fx_data_outdatedOnCpu = false;
              mwGetLaunchParameters1D(computeNumIters(nx), &grid, &block,
                2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel108<<<grid, block>>>(nx, gpu_jpvt);
              }
            } else {
              for (k = 0; k <= nx; k++) {
                if (b_y_needsGpuEnsureCapacity) {
                  gpuEmxMemcpyGpuToCpu_int32_T(cpu_jpvt, &gpu_jpvt);
                }

                cpu_jpvt->data[k] = (int32_T)jpvt_t->data[k];
                b_y_needsGpuEnsureCapacity = false;
                y_needsGpuEnsureCapacity = true;
                interval_outdatedOnGpu = true;
              }
            }

            ix = -1;
            if (cpu_G->size[0] < cpu_G->size[1]) {
              lidx = cpu_G->size[0];
              cpu_nrefine = cpu_G->size[1];
            } else {
              lidx = cpu_G->size[1];
              cpu_nrefine = cpu_G->size[0];
            }

            if (b_fx_data_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(cpu_G, &gpu_G);
            }

            delta = std::fmin(1.4901161193847656E-8, 2.2204460492503131E-15 *
                              static_cast<real_T>(cpu_nrefine)) * std::abs
              (cpu_G->data[0]);
            while ((ix + 1 < lidx) && (!(std::abs(cpu_G->data[(ix + cpu_G->size
                       [0] * (ix + 1)) + 1]) <= delta))) {
              ix++;
            }

            eint = b_cpu_a->size[0];
            b_cpu_a->size[0] = cpu_G->size[1];
            emxEnsureCapacity_real_T(b_cpu_a, eint, &fc_emlrtRTEI);
            bcoef = cpu_G->size[1] - 1;
            mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block,
              2147483647U);
            gpuEmxEnsureCapacity_real_T(b_cpu_a, &b_gpu_a, true);
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwtAvg_kernel109<<<grid, block>>>(bcoef, b_gpu_a);
            }

            cpu_nrefine = 0;
            nG = cpu_G->size[0];
            lidx = cpu_G->size[1];
            if (nG <= lidx) {
              lidx = nG;
            }

            gpuEmxEnsureCapacity_real_T(cpu_G, &gpu_G,
              !c_omega_tmp1_needsGpuEnsureCapa);
            if (wav_outdatedOnCpu) {
              gpuEmxEnsureCapacity_real_T(cpu_tau, &gpu_tau,
                !fx_data_outdatedOnCpu);
            }

            if (h_needsGpuEnsureCapacity) {
              gpuEmxEnsureCapacity_real_T(cpu_b, &gpu_b, !b_outdatedOnGpu);
            }

            if (c_omega_tmp1_needsGpuEnsureCapa) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_G, cpu_G);
            }

            if (fx_data_outdatedOnCpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_tau, cpu_tau);
            }

            if (b_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, cpu_b);
            }

            cusolverCheck(cusolverDnDormqr_bufferSize(getCuSolverGlobalHandle(),
              CUBLAS_SIDE_LEFT, CUBLAS_OP_T, cpu_b->size[0], 1, lidx, (double *)
              &gpu_G.data[0], cpu_G->size[0], (double *)&gpu_tau.data[0],
              (double *)&gpu_b.data[0], cpu_b->size[0], getCuSolverWorkspaceReq()),
                          __FILE__, __LINE__);
            setCuSolverWorkspaceTypeSize(8);
            cusolverInitWorkspace();
            G_needsGpuEnsureCapacity = false;
            checkCudaError(cudaMemcpy(gpu_nrefine, &cpu_nrefine, 4UL,
              cudaMemcpyHostToDevice), __FILE__, __LINE__);
            cusolverCheck(cusolverDnDormqr(getCuSolverGlobalHandle(),
              CUBLAS_SIDE_LEFT, CUBLAS_OP_T, cpu_b->size[0], 1, lidx, (double *)
              &gpu_G.data[0], cpu_G->size[0], (double *)&gpu_tau.data[0],
              (double *)&gpu_b.data[0], cpu_b->size[0], static_cast<real_T *>
              (getCuSolverWorkspaceBuff()), *getCuSolverWorkspaceReq(),
              gpu_nrefine), __FILE__, __LINE__);
            checkCudaError(cudaMemcpy(&cpu_nrefine, gpu_nrefine, 4UL,
              cudaMemcpyDeviceToHost), __FILE__, __LINE__);
            if (cpu_nrefine < 0) {
              omega_tmp2[0] = cpu_b->size[0];
              eint = cpu_b->size[0];
              cpu_b->size[0] = omega_tmp2[0];
              emxEnsureCapacity_real_T(cpu_b, eint, &uc_emlrtRTEI);
              mwGetLaunchParameters1D(computeNumIters(omega_tmp2[0] - 1), &grid,
                &block, 2147483647U);
              gpuEmxEnsureCapacity_real_T(cpu_b, &gpu_b, true);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel110<<<grid, block>>>(omega_tmp2[0] - 1, gpu_b);
              }
            }

            mwGetLaunchParameters1D(computeNumIters(ix), &grid, &block,
              2147483647U);
            if (interval_outdatedOnGpu) {
              gpuEmxEnsureCapacity_int32_T(cpu_jpvt, &gpu_jpvt,
                !y_needsGpuEnsureCapacity);
            }

            c_omega_tmp1_needsGpuEnsureCapa = false;
            if (y_needsGpuEnsureCapacity) {
              gpuEmxMemcpyCpuToGpu_int32_T(&gpu_jpvt, cpu_jpvt);
            }

            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwtAvg_kernel111<<<grid, block>>>(gpu_b, gpu_jpvt, ix, b_gpu_a);
            }

            fx_data_outdatedOnCpu = false;
            y_needsGpuEnsureCapacity = true;
            for (lidx = 0; lidx <= ix; lidx++) {
              if (y_needsGpuEnsureCapacity) {
                gpuEmxMemcpyGpuToCpu_real_T(b_cpu_a, &b_gpu_a);
              }

              if (b_y_needsGpuEnsureCapacity) {
                gpuEmxMemcpyGpuToCpu_int32_T(cpu_jpvt, &gpu_jpvt);
              }

              b_y_needsGpuEnsureCapacity = false;
              b_cpu_a->data[cpu_jpvt->data[ix - lidx] - 1] /= cpu_G->data[(ix -
                lidx) + cpu_G->size[0] * (ix - lidx)];
              y_needsGpuEnsureCapacity = false;
              fx_data_outdatedOnCpu = true;
              G_needsGpuEnsureCapacity = true;
              c_omega_tmp1_needsGpuEnsureCapa = true;
              cpu_nrefine = ix - lidx;
              for (nG = 0; nG < cpu_nrefine; nG++) {
                b_cpu_a->data[cpu_jpvt->data[nG] - 1] -= b_cpu_a->data
                  [cpu_jpvt->data[ix - lidx] - 1] * cpu_G->data[nG + cpu_G->
                  size[0] * (ix - lidx)];
              }
            }
          }
        } else {
          eint = b_cpu_a->size[0];
          b_cpu_a->size[0] = cpu_b->size[0];
          emxEnsureCapacity_real_T(b_cpu_a, eint, &ec_emlrtRTEI);
          bcoef = cpu_b->size[0] - 1;
          mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block,
            2147483647U);
          if (h_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_real_T(cpu_b, &gpu_b, !b_outdatedOnGpu);
          }

          gpuEmxEnsureCapacity_real_T(b_cpu_a, &b_gpu_a, true);
          c_omega_tmp1_needsGpuEnsureCapa = false;
          if (b_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&gpu_b, cpu_b);
          }

          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel112<<<grid, block>>>(gpu_b, bcoef, b_gpu_a);
          }

          fx_data_outdatedOnCpu = false;
          y_needsGpuEnsureCapacity = true;
          if (Nodd) {
            ec_cwtAvg_kernel113<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(b_gpu_a);
          }
        }

        if (Nodd) {
          if (b_c + 1.0 < 2.0) {
            cpu_nrefine = 0;
            ix = 1;
            lidx = -1;
            nx = 0;
            nG = 0;
          } else {
            cpu_nrefine = static_cast<int32_T>(b_c + 1.0) - 1;
            ix = -1;
            lidx = 1;
            nx = 1;
            nG = static_cast<int32_T>(b_c + 1.0);
          }

          eint = cpu_h->size[0] * cpu_h->size[1];
          cpu_h->size[0] = 1;
          cpu_h->size[1] = ((div_s32(lidx - cpu_nrefine, ix) + nG) - nx) + 2;
          emxEnsureCapacity_real_T(cpu_h, eint, &qc_emlrtRTEI);
          nsubs = div_s32(lidx - cpu_nrefine, ix);
          mwGetLaunchParameters1D(computeNumIters(nsubs), &grid, &block,
            2147483647U);
          if (c_omega_tmp1_needsGpuEnsureCapa) {
            gpuEmxEnsureCapacity_real_T(b_cpu_a, &b_gpu_a,
              !fx_data_outdatedOnCpu);
          }

          gpuEmxEnsureCapacity_real_T(cpu_h, &gpu_h, true);
          if (fx_data_outdatedOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_a, b_cpu_a);
          }

          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel98<<<grid, block>>>(b_gpu_a, ix, cpu_nrefine, nsubs,
              gpu_h);
          }

          h_needsGpuEnsureCapacity = false;
          ec_cwtAvg_kernel99<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(b_gpu_a,
            ix, cpu_nrefine, lidx, gpu_h);
          wav_outdatedOnCpu = true;
          nsubs = nG - nx;
          for (eint = 0; eint < nsubs; eint++) {
            if (wav_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(cpu_h, &gpu_h);
            }

            if (y_needsGpuEnsureCapacity) {
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_a, &b_gpu_a);
            }

            y_needsGpuEnsureCapacity = false;
            cpu_h->data[(eint + div_s32(lidx - cpu_nrefine, ix)) + 2] =
              b_cpu_a->data[nx + eint] / 2.0;
            wav_outdatedOnCpu = false;
            h_outdatedOnGpu = true;
            h_needsGpuEnsureCapacity = true;
          }
        } else {
          eint = d_cpu_x->size[0];
          d_cpu_x->size[0] = b_cpu_a->size[0];
          emxEnsureCapacity_real_T(d_cpu_x, eint, &mc_emlrtRTEI);
          bcoef = b_cpu_a->size[0] - 1;
          mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block,
            2147483647U);
          if (c_omega_tmp1_needsGpuEnsureCapa) {
            gpuEmxEnsureCapacity_real_T(b_cpu_a, &b_gpu_a,
              !fx_data_outdatedOnCpu);
          }

          gpuEmxEnsureCapacity_real_T(d_cpu_x, &e_gpu_x, true);
          interval_outdatedOnGpu = false;
          if (fx_data_outdatedOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_a, b_cpu_a);
          }

          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel100<<<grid, block>>>(b_gpu_a, bcoef, e_gpu_x);
          }

          fx_data_outdatedOnCpu = false;
          wav_outdatedOnCpu = true;
          lidx = b_cpu_a->size[0] - 1;
          cpu_nrefine = b_cpu_a->size[0] >> 1;
          for (nG = 0; nG < cpu_nrefine; nG++) {
            if (wav_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(d_cpu_x, &e_gpu_x);
            }

            b_r = d_cpu_x->data[nG];
            d_cpu_x->data[nG] = d_cpu_x->data[lidx - nG];
            d_cpu_x->data[lidx - nG] = b_r;
            wav_outdatedOnCpu = false;
            fx_data_outdatedOnCpu = true;
            interval_outdatedOnGpu = true;
          }

          eint = cpu_h->size[0] * cpu_h->size[1];
          cpu_h->size[0] = 1;
          cpu_h->size[1] = d_cpu_x->size[0] + b_cpu_a->size[0];
          emxEnsureCapacity_real_T(cpu_h, eint, &rc_emlrtRTEI);
          nsubs = d_cpu_x->size[0];
          mwGetLaunchParameters1D(computeNumIters(nsubs - 1), &grid, &block,
            2147483647U);
          if (interval_outdatedOnGpu) {
            gpuEmxEnsureCapacity_real_T(d_cpu_x, &e_gpu_x,
              !fx_data_outdatedOnCpu);
          }

          gpuEmxEnsureCapacity_real_T(cpu_h, &gpu_h, true);
          h_needsGpuEnsureCapacity = false;
          if (fx_data_outdatedOnCpu) {
            gpuEmxMemcpyCpuToGpu_real_T(&e_gpu_x, d_cpu_x);
          }

          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel101<<<grid, block>>>(e_gpu_x, nsubs - 1, gpu_h);
          }

          wav_outdatedOnCpu = true;
          nsubs = b_cpu_a->size[0];
          for (eint = 0; eint < nsubs; eint++) {
            if (wav_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(cpu_h, &gpu_h);
            }

            if (y_needsGpuEnsureCapacity) {
              gpuEmxMemcpyGpuToCpu_real_T(b_cpu_a, &b_gpu_a);
            }

            y_needsGpuEnsureCapacity = false;
            cpu_h->data[eint + d_cpu_x->size[0]] = 0.5 * b_cpu_a->data[eint];
            wav_outdatedOnCpu = false;
            h_outdatedOnGpu = true;
            h_needsGpuEnsureCapacity = true;
          }
        }
      }

      if (s == std::floor(s)) {
        ix = static_cast<int32_T>(s);
      } else {
        ix = static_cast<int32_T>(std::round(s));
        coder::internal::warning();
      }

      eint = cpu_dv22->size[0];
      cpu_dv22->size[0] = ix;
      emxEnsureCapacity_real_T(cpu_dv22, eint, &mb_emlrtRTEI);
      if (ix <= 1) {
        eint = cpu_dv22->size[0];
        cpu_dv22->size[0] = ix;
        emxEnsureCapacity_real_T(cpu_dv22, eint, &nb_emlrtRTEI);
        mwGetLaunchParameters1D(computeNumIters(ix - 1), &grid, &block,
          2147483647U);
        gpuEmxEnsureCapacity_real_T(cpu_dv22, &gpu_dv22, true);
        wav_outdatedOnCpu = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_cwtAvg_kernel47<<<grid, block>>>(ix - 1, gpu_dv22);
        }

        c_omega_tmp1_needsGpuEnsureCapa = false;
      } else {
        lidx = ix >> 1;
        e = computeEndIdx(static_cast<int64_T>(lidx + 1), static_cast<int64_T>
                          (ix), 1L);
        mwGetLaunchParameters1D(computeNumIters(e), &grid, &block, 2147483647U);
        gpuEmxEnsureCapacity_real_T(cpu_dv22, &gpu_dv22, true);
        wav_outdatedOnCpu = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_cwtAvg_kernel79<<<grid, block>>>(gpu_dc6, *global_gpu_table100, dc7,
            gpu_dc1, ix, lidx, 1 - (ix & 1), lidx + 1, e, gpu_dv22, q1[0], q1[1],
            q1[2], q1[3], q1[4], q1[5], q1[6], q1[7], p1[0], p1[1], p1[2], p1[3],
            p1[4], p1[5], p1[6], p1[7], q2[0], q2[1], q2[2], q2[3], q2[4], q2[5],
            q2[6], q2[7], p2[0], p2[1], p2[2], p2[3], p2[4], p2[5], p2[6], p2[7],
            q4[0], q4[1], q4[2], q4[3], q4[4], q4[5], q4[6], q4[7], p4[0], p4[1],
            p4[2], p4[3], p4[4], p4[5], p4[6], p4[7], c[0], c[1], c[2], c[3], c
            [4], c[5], c[6]);
        }

        c_omega_tmp1_needsGpuEnsureCapa = false;
        fx_data_outdatedOnCpu = true;
        for (k = 0; k < lidx; k++) {
          if (fx_data_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real_T(cpu_dv22, &gpu_dv22);
          }

          cpu_dv22->data[k] = cpu_dv22->data[(ix - k) - 1];
          fx_data_outdatedOnCpu = false;
          c_omega_tmp1_needsGpuEnsureCapa = true;
          wav_outdatedOnCpu = true;
        }
      }

      eint = cpu_h1->size[0];
      cpu_h1->size[0] = cpu_h->size[1];
      emxEnsureCapacity_real_T(cpu_h1, eint, &qb_emlrtRTEI);
      bcoef = cpu_h->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block, 2147483647U);
      if (wav_outdatedOnCpu) {
        gpuEmxEnsureCapacity_real_T(cpu_dv22, &gpu_dv22,
          !c_omega_tmp1_needsGpuEnsureCapa);
      }

      if (h_needsGpuEnsureCapacity) {
        gpuEmxEnsureCapacity_real_T(cpu_h, &gpu_h, !h_outdatedOnGpu);
      }

      h_needsGpuEnsureCapacity = false;
      gpuEmxEnsureCapacity_real_T(cpu_h1, &gpu_h1, true);
      wav_outdatedOnCpu = false;
      if (c_omega_tmp1_needsGpuEnsureCapa) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_dv22, cpu_dv22);
      }

      if (h_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_h, cpu_h);
      }

      h_outdatedOnGpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel48<<<grid, block>>>(gpu_dv22, gpu_h, bcoef, gpu_h1);
      }

      cpu_nrefine = cpu_h1->size[0];
      if (cpu_h1->size[0] == 0) {
        cpu_r = 0.0;
      } else {
        gpuEmxMemcpyGpuToCpu_real_T(cpu_h1, &gpu_h1);
        cpu_r = cpu_h1->data[0];
        wav_outdatedOnCpu = true;
        for (k = 0; k <= cpu_nrefine - 2; k++) {
          cpu_r += cpu_h1->data[k + 1];
        }
      }

      eint = cpu_opts_filter->size[0];
      cpu_opts_filter->size[0] = cpu_h1->size[0];
      emxEnsureCapacity_real_T(cpu_opts_filter, eint, &sb_emlrtRTEI);
      bcoef = cpu_h1->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block, 2147483647U);
      if (wav_outdatedOnCpu) {
        gpuEmxEnsureCapacity_real_T(cpu_h1, &gpu_h1, true);
      }

      gpuEmxEnsureCapacity_real_T(cpu_opts_filter, &gpu_opts_filter, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel49<<<grid, block>>>(cpu_r, gpu_h1, q_ok, bcoef,
          gpu_opts_filter);
      }

      cpu_r = (static_cast<real_T>(cpu_opts_filter->size[0]) - 1.0) / 2.0;
      r = cpu_r;
      if (tau == 0.0) {
        if (cpu_r == 0.0) {
          r = 0.0;
        }
      } else if (std::isnan(tau)) {
        r = rtNaN;
      } else if (cpu_r == 0.0) {
        r = 0.0;
      } else if (std::isinf(tau)) {
        if (cpu_r < 0.0) {
          r = tau;
        }
      } else {
        r = std::fmod(cpu_r, tau);
        if (r == 0.0) {
          r = tau * 0.0;
        } else if (cpu_r < 0.0) {
          r += tau;
        }
      }

      delta = std::floor(tau - r);
      intDsq = std::floor(std::ceil(cpu_r + delta) / tau);
      cpu_r = static_cast<real_T>(cpu_opts_filter->size[0]) + delta;
      b_r = 0.0;
      cpu_nrefine = cpu_xCh->size[0];
      while (std::ceil((((static_cast<real_T>(cpu_nrefine) - 1.0) * q_ok + cpu_r)
                        + b_r) / tau) - intDsq < std::ceil(static_cast<real_T>
              (cpu_nrefine) * q_ok / tau)) {
        b_r++;
      }

      eint = b_cpu_h->size[0];
      b_cpu_h->size[0] = static_cast<int32_T>((delta + static_cast<real_T>
        (cpu_opts_filter->size[0])) + b_r);
      emxEnsureCapacity_real_T(b_cpu_h, eint, &xb_emlrtRTEI);
      bcoef = static_cast<int32_T>((delta + static_cast<real_T>
        (cpu_opts_filter->size[0])) + b_r) - 1;
      mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(b_cpu_h, &b_gpu_h, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel50<<<grid, block>>>(bcoef, b_gpu_h);
      }

      if (cpu_opts_filter->size[0] < 1) {
        j_cpu_y->size[0] = 1;
        j_cpu_y->size[1] = 0;
      } else {
        N = static_cast<uint32_T>(cpu_opts_filter->size[0]);
        eint = j_cpu_y->size[0] * j_cpu_y->size[1];
        j_cpu_y->size[0] = 1;
        j_cpu_y->size[1] = cpu_opts_filter->size[0];
        emxEnsureCapacity_uint32_T(j_cpu_y, eint, &d_emlrtRTEI);
        mwGetLaunchParameters1D(computeNumIters(static_cast<int32_T>(N) - 1),
          &grid, &block, 2147483647U);
        gpuEmxEnsureCapacity_uint32_T(j_cpu_y, &g_gpu_y, true);
        d_y_needsGpuEnsureCapacity = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_cwtAvg_kernel78<<<grid, block>>>(static_cast<int32_T>(N) - 1,
            g_gpu_y);
        }
      }

      eint = cpu_iv9->size[0] * cpu_iv9->size[1];
      cpu_iv9->size[0] = 1;
      cpu_iv9->size[1] = j_cpu_y->size[1];
      emxEnsureCapacity_int32_T(cpu_iv9, eint, &cc_emlrtRTEI);
      bcoef = j_cpu_y->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block, 2147483647U);
      if (d_y_needsGpuEnsureCapacity) {
        gpuEmxEnsureCapacity_uint32_T(j_cpu_y, &g_gpu_y, true);
      }

      d_y_needsGpuEnsureCapacity = false;
      gpuEmxEnsureCapacity_int32_T(cpu_iv9, &gpu_iv9, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel51<<<grid, block>>>(g_gpu_y, delta, bcoef, gpu_iv9);
      }

      bcoef = cpu_iv9->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block, 2147483647U);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        ec_cwtAvg_kernel52<<<grid, block>>>(gpu_opts_filter, gpu_iv9, bcoef,
          b_gpu_h);
      }

      if ((!(q_ok == 1.0)) || (!(tau == 1.0))) {
        int32_T cpu_csz[2];
        int32_T cpu_lshift[2];
        intFsq = std::ceil(static_cast<real_T>(cpu_xCh->size[0]) * q_ok / tau);
        if (!(q_ok - 1.0 >= 0.0)) {
          g_y = nullptr;
          m9 = emlrtCreateCharArray(2, &iv10[0]);
          emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m9, &rfmt[0]);
          emlrtAssign(&g_y, m9);
          h_y = nullptr;
          m10 = emlrtCreateDoubleScalar(q_ok - 1.0);
          emlrtAssign(&h_y, m10);
          emlrt_marshallIn(b_sprintf(g_y, h_y, &e_emlrtMCI),
                           "<output of sprintf>", unusedExpr);
        }

        eint = cpu_yCol->size[0];
        cpu_yCol->size[0] = cpu_xCh->size[0] * static_cast<int32_T>(q_ok);
        emxEnsureCapacity_real_T(cpu_yCol, eint, &kc_emlrtRTEI);
        bcoef = cpu_xCh->size[0] * static_cast<int32_T>(q_ok) - 1;
        mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block,
          2147483647U);
        gpuEmxEnsureCapacity_real_T(cpu_yCol, &gpu_yCol, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_cwtAvg_kernel53<<<grid, block>>>(bcoef, gpu_yCol);
        }

        if ((static_cast<int32_T>(q_ok) == 0) || (((static_cast<int32_T>(q_ok) >
               0) && (cpu_xCh->size[0] * static_cast<int32_T>(q_ok) < 1)) || ((
               static_cast<int32_T>(q_ok) < 0) && (cpu_xCh->size[0] *
               static_cast<int32_T>(q_ok) > 1)))) {
          lidx = 1;
          cpu_nrefine = 0;
        } else {
          lidx = static_cast<int32_T>(q_ok);
          cpu_nrefine = cpu_xCh->size[0] * static_cast<int32_T>(q_ok);
        }

        mwGetLaunchParameters1D(computeNumIters(div_s32(cpu_nrefine - 1, lidx)),
          &grid, &block, 2147483647U);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_cwtAvg_kernel54<<<grid, block>>>(gpu_xCh, lidx, div_s32(cpu_nrefine
            - 1, lidx), gpu_yCol);
        }

        eint = cpu_xCh->size[0] * static_cast<int32_T>(q_ok);
        origSiz[0] = eint;
        nx = e_cpu_x->size[0] * e_cpu_x->size[1];
        e_cpu_x->size[0] = eint;
        e_cpu_x->size[1] = 1;
        emxEnsureCapacity_real_T(e_cpu_x, nx, &sc_emlrtRTEI);
        mwGetLaunchParameters1D(computeNumIters(eint - 1), &grid, &block,
          2147483647U);
        gpuEmxEnsureCapacity_real_T(e_cpu_x, &d_gpu_x, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_cwtAvg_kernel55<<<grid, block>>>(gpu_yCol, eint - 1, d_gpu_x);
        }

        if ((eint == 1) && (b_cpu_h->size[0] == 1)) {
          eint = b_cpu_w->size[0] * b_cpu_w->size[1];
          b_cpu_w->size[0] = 1;
          b_cpu_w->size[1] = 1;
          emxEnsureCapacity_real_T(b_cpu_w, eint, &sc_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(b_cpu_w, &gpu_w, true);
          c_omega_tmp1_needsGpuEnsureCapa = false;
          ec_cwtAvg_kernel56<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(b_gpu_h,
            gpu_yCol, gpu_w);
        } else if (b_cpu_h->size[0] > eint) {
          if (eint == 0) {
            cpu_nrefine = b_cpu_h->size[0];
          } else {
            cpu_nrefine = (b_cpu_h->size[0] + eint) - 1;
          }

          eint = b_cpu_w->size[0] * b_cpu_w->size[1];
          b_cpu_w->size[0] = cpu_nrefine;
          b_cpu_w->size[1] = 1;
          emxEnsureCapacity_real_T(b_cpu_w, eint, &sc_emlrtRTEI);
          mwGetLaunchParameters1D(computeNumIters(cpu_nrefine - 1), &grid,
            &block, 2147483647U);
          gpuEmxEnsureCapacity_real_T(b_cpu_w, &gpu_w, true);
          c_omega_tmp1_needsGpuEnsureCapa = false;
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel66<<<grid, block>>>(cpu_nrefine - 1, gpu_w);
          }

          if (origSiz[0] != 0) {
            if ((b_cpu_h->size[0] == 1) && (origSiz[0] == 1)) {
              eint = b_cpu_w->size[0] * b_cpu_w->size[1];
              b_cpu_w->size[0] = 1;
              b_cpu_w->size[1] = 1;
              emxEnsureCapacity_real_T(b_cpu_w, eint, &sc_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(b_cpu_w, &gpu_w, true);
              ec_cwtAvg_kernel67<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>
                (gpu_yCol, b_gpu_h, gpu_w);
            } else {
              real_T blockDims[3];
              int32_T b_threadDims[3];
              cpu_r = (static_cast<real_T>(b_cpu_h->size[0]) +
                       static_cast<real_T>(origSiz[0])) - 1.0;
              fc = std::fmin(32.0, cpu_r);
              blockDims[0] = std::floor((cpu_r + (fc - 1.0)) / fc);
              if (fc >= -2.147483648E+9) {
                eint = static_cast<int32_T>(fc);
              } else {
                eint = MIN_int32_T;
              }

              b_threadDims[0] = eint;
              if (cpu_r < 2.147483648E+9) {
                if (cpu_r >= -2.147483648E+9) {
                  nG = static_cast<int32_T>(cpu_r);
                } else {
                  nG = MIN_int32_T;
                }
              } else {
                nG = MAX_int32_T;
              }

              fc = std::floor(static_cast<real_T>(origSiz[0]) / 2.0) + std::
                floor((static_cast<real_T>(origSiz[0]) - 1.0) / 2.0);
              if (fc >= -2.147483648E+9) {
                lidx = static_cast<int32_T>(fc);
              } else {
                lidx = MIN_int32_T;
              }

              if ((nG < 0) && (origSiz[0] < MIN_int32_T - nG)) {
                cpu_nrefine = MIN_int32_T;
              } else if ((nG > 0) && (origSiz[0] > MAX_int32_T - nG)) {
                cpu_nrefine = MAX_int32_T;
              } else {
                cpu_nrefine = nG + origSiz[0];
              }

              if (cpu_nrefine >= -2147483647) {
                cpu_nrefine--;
              }

              eint = b_cpu_expanded->size[0] * b_cpu_expanded->size[1];
              b_cpu_expanded->size[0] = cpu_nrefine;
              b_cpu_expanded->size[1] = 1;
              emxEnsureCapacity_real_T(b_cpu_expanded, eint, &vc_emlrtRTEI);
              bcoef = (nG + origSiz[0]) - 2;
              mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block,
                2147483647U);
              gpuEmxEnsureCapacity_real_T(b_cpu_expanded, &gpu_expanded, true);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel68<<<grid, block>>>(bcoef, gpu_expanded);
              }

              ix = b_cpu_h->size[0];
              eint = n_cpu_y->size[0] * n_cpu_y->size[1];
              n_cpu_y->size[0] = 1;
              n_cpu_y->size[1] = b_cpu_h->size[0];
              emxEnsureCapacity_int32_T(n_cpu_y, eint, &wc_emlrtRTEI);
              n_cpu_y->data[0] = 1;
              cpu_nrefine = 1;
              for (k = 0; k <= ix - 2; k++) {
                cpu_nrefine++;
                n_cpu_y->data[k + 1] = cpu_nrefine;
              }

              eint = cpu_iv14->size[0];
              cpu_iv14->size[0] = n_cpu_y->size[1];
              emxEnsureCapacity_int32_T(cpu_iv14, eint, &vc_emlrtRTEI);
              bcoef = n_cpu_y->size[1] - 1;
              mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block,
                2147483647U);
              gpuEmxEnsureCapacity_int32_T(n_cpu_y, &j_gpu_y, false);
              gpuEmxEnsureCapacity_int32_T(cpu_iv14, &gpu_iv14, true);
              gpuEmxMemcpyCpuToGpu_int32_T(&j_gpu_y, n_cpu_y);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel69<<<grid, block>>>(lidx, j_gpu_y, bcoef,
                  gpu_iv14);
              }

              omega_tmp2[0] = cpu_iv14->size[0];
              mwGetLaunchParameters1D(computeNumIters(omega_tmp2[0] - 1), &grid,
                &block, 2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel70<<<grid, block>>>(b_gpu_h, gpu_iv14,
                  omega_tmp2[0] - 1, gpu_expanded);
              }

              if (origSiz[0] < -2147483647) {
                cpu_nrefine = MIN_int32_T;
              } else {
                cpu_nrefine = origSiz[0] - 1;
              }

              if (cpu_nrefine < 0) {
                ix = 0;
              } else {
                ix = cpu_nrefine + 1;
              }

              wav_outdatedOnCpu = false;
              eint = cpu_rows->size[0] * cpu_rows->size[1];
              cpu_rows->size[0] = 1;
              cpu_rows->size[1] = ix;
              emxEnsureCapacity_int32_T(cpu_rows, eint, &wc_emlrtRTEI);
              if (ix > 0) {
                cpu_rows->data[0] = 0;
                wav_outdatedOnCpu = true;
                cpu_nrefine = 0;
                for (k = 0; k <= ix - 2; k++) {
                  cpu_nrefine++;
                  cpu_rows->data[k + 1] = cpu_nrefine;
                }
              }

              eint = b_cpu_w->size[0] * b_cpu_w->size[1];
              b_cpu_w->size[0] = nG;
              b_cpu_w->size[1] = 1;
              emxEnsureCapacity_real_T(b_cpu_w, eint, &vc_emlrtRTEI);
              c_omega_tmp1_needsGpuEnsureCapa = true;
              if (nG != 0) {
                if (blockDims[0] < 4.294967296E+9) {
                  if (blockDims[0] >= 0.0) {
                    N = static_cast<uint32_T>(blockDims[0]);
                  } else {
                    N = 0U;
                  }
                } else if (blockDims[0] >= 4.294967296E+9) {
                  N = MAX_uint32_T;
                } else {
                  N = 0U;
                }

                eint = b_threadDims[0];
                if (b_threadDims[0] < 0) {
                  eint = 0;
                }

                mwApplyLaunchParameters(computeNumIters(0, nG - 1), dim3(N, 1U,
                  1U), dim3(static_cast<uint32_T>(eint), 1U, 1U), &grid, &block);
                gpuEmxEnsureCapacity_int32_T(cpu_rows, &gpu_rows,
                  !wav_outdatedOnCpu);
                gpuEmxEnsureCapacity_real_T(b_cpu_w, &gpu_w, true);
                c_omega_tmp1_needsGpuEnsureCapa = false;
                if (wav_outdatedOnCpu) {
                  gpuEmxMemcpyCpuToGpu_int32_T(&gpu_rows, cpu_rows);
                }

                validLaunchParams = mwValidateLaunchParameters(grid, block);
                if (validLaunchParams) {
                  ec_cwtAvg_kernel71<<<grid, block>>>(gpu_yCol, gpu_expanded,
                    gpu_rows, origSiz[0], nG - 1, gpu_w);
                }
              }
            }
          }
        } else {
          if (eint == 0) {
            cpu_nrefine = b_cpu_h->size[0];
          } else {
            cpu_nrefine = (eint + b_cpu_h->size[0]) - 1;
          }

          eint = b_cpu_w->size[0] * b_cpu_w->size[1];
          b_cpu_w->size[0] = cpu_nrefine;
          b_cpu_w->size[1] = 1;
          emxEnsureCapacity_real_T(b_cpu_w, eint, &sc_emlrtRTEI);
          mwGetLaunchParameters1D(computeNumIters(cpu_nrefine - 1), &grid,
            &block, 2147483647U);
          gpuEmxEnsureCapacity_real_T(b_cpu_w, &gpu_w, true);
          c_omega_tmp1_needsGpuEnsureCapa = false;
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel72<<<grid, block>>>(cpu_nrefine - 1, gpu_w);
          }

          if (origSiz[0] != 0) {
            if ((origSiz[0] == 1) && (b_cpu_h->size[0] == 1)) {
              eint = d_cpu_c->size[0];
              d_cpu_c->size[0] = 1;
              emxEnsureCapacity_real_T(d_cpu_c, eint, &tc_emlrtRTEI);
              delta = 1.0;
              b_r = 0.0;
              gpuEmxEnsureCapacity_real_T(d_cpu_c, &b_gpu_c, true);
              cublasCheck(cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N,
                CUBLAS_OP_N, 1, 1, 1, (double *)&delta, (double *)&d_gpu_x.data
                [0], 1, (double *)&b_gpu_h.data[0], 1, (double *)&b_r, (double *)
                &b_gpu_c.data[0], 1), __FILE__, __LINE__);
              eint = b_cpu_w->size[0] * b_cpu_w->size[1];
              b_cpu_w->size[0] = cpu_nrefine;
              b_cpu_w->size[1] = 1;
              emxEnsureCapacity_real_T(b_cpu_w, eint, &sc_emlrtRTEI);
              mwGetLaunchParameters1D(computeNumIters(cpu_nrefine - 1), &grid,
                &block, 2147483647U);
              gpuEmxEnsureCapacity_real_T(b_cpu_w, &gpu_w, true);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel73<<<grid, block>>>(b_gpu_c, cpu_nrefine - 1,
                  gpu_w);
              }
            } else {
              real_T blockDims[3];
              int8_T threadDims[3];
              N = (static_cast<uint32_T>(origSiz[0]) + static_cast<uint32_T>
                   (b_cpu_h->size[0])) - 1U;
              cpu_nrefine = static_cast<int32_T>(std::fmin(32.0, static_cast<
                real_T>(N)));
              blockDims[0] = std::floor((static_cast<real_T>(N) +
                (static_cast<real_T>(cpu_nrefine) - 1.0)) / static_cast<real_T>
                (cpu_nrefine));
              threadDims[0] = static_cast<int8_T>(cpu_nrefine);
              if (N > 2147483647U) {
                N = 2147483647U;
              }

              nG = static_cast<int32_T>(N);
              lidx = static_cast<int32_T>(std::floor(static_cast<real_T>
                (b_cpu_h->size[0]) / 2.0)) + static_cast<int32_T>(std::floor((
                static_cast<real_T>(b_cpu_h->size[0]) - 1.0) / 2.0));
              if ((static_cast<int32_T>(N) > 0) && (b_cpu_h->size[0] >
                   MAX_int32_T - static_cast<int32_T>(N))) {
                cpu_nrefine = MAX_int32_T;
              } else {
                cpu_nrefine = static_cast<int32_T>(N) + b_cpu_h->size[0];
              }

              eint = cpu_expanded->size[0] * cpu_expanded->size[1];
              cpu_expanded->size[0] = cpu_nrefine - 1;
              cpu_expanded->size[1] = 1;
              emxEnsureCapacity_real_T(cpu_expanded, eint, &vc_emlrtRTEI);
              bcoef = (static_cast<int32_T>(N) + b_cpu_h->size[0]) - 2;
              mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block,
                2147483647U);
              gpuEmxEnsureCapacity_real_T(cpu_expanded, &b_gpu_expanded, true);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel74<<<grid, block>>>(bcoef, b_gpu_expanded);
              }

              eint = origSiz[0];
              nx = m_cpu_y->size[0] * m_cpu_y->size[1];
              m_cpu_y->size[0] = 1;
              m_cpu_y->size[1] = origSiz[0];
              emxEnsureCapacity_int32_T(m_cpu_y, nx, &wc_emlrtRTEI);
              m_cpu_y->data[0] = 1;
              cpu_nrefine = 1;
              for (k = 0; k <= eint - 2; k++) {
                cpu_nrefine++;
                m_cpu_y->data[k + 1] = cpu_nrefine;
              }

              eint = cpu_iv15->size[0];
              cpu_iv15->size[0] = m_cpu_y->size[1];
              emxEnsureCapacity_int32_T(cpu_iv15, eint, &vc_emlrtRTEI);
              bcoef = m_cpu_y->size[1] - 1;
              mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block,
                2147483647U);
              gpuEmxEnsureCapacity_int32_T(m_cpu_y, &k_gpu_y, false);
              gpuEmxEnsureCapacity_int32_T(cpu_iv15, &gpu_iv15, true);
              gpuEmxMemcpyCpuToGpu_int32_T(&k_gpu_y, m_cpu_y);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel75<<<grid, block>>>(lidx, k_gpu_y, bcoef,
                  gpu_iv15);
              }

              xt_size[0] = cpu_iv15->size[0];
              mwGetLaunchParameters1D(computeNumIters(xt_size[0] - 1), &grid,
                &block, 2147483647U);
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwtAvg_kernel76<<<grid, block>>>(gpu_yCol, gpu_iv15, xt_size
                  [0] - 1, b_gpu_expanded);
              }

              ix = b_cpu_h->size[0];
              eint = b_cpu_rows->size[0] * b_cpu_rows->size[1];
              b_cpu_rows->size[0] = 1;
              b_cpu_rows->size[1] = b_cpu_h->size[0];
              emxEnsureCapacity_int32_T(b_cpu_rows, eint, &wc_emlrtRTEI);
              b_cpu_rows->data[0] = 0;
              cpu_nrefine = 0;
              for (k = 0; k <= ix - 2; k++) {
                cpu_nrefine++;
                b_cpu_rows->data[k + 1] = cpu_nrefine;
              }

              eint = b_cpu_w->size[0] * b_cpu_w->size[1];
              b_cpu_w->size[0] = static_cast<int32_T>(N);
              b_cpu_w->size[1] = 1;
              emxEnsureCapacity_real_T(b_cpu_w, eint, &vc_emlrtRTEI);
              c_omega_tmp1_needsGpuEnsureCapa = true;
              if (static_cast<int32_T>(N) != 0) {
                if (blockDims[0] < 4.294967296E+9) {
                  if (blockDims[0] >= 0.0) {
                    N = static_cast<uint32_T>(blockDims[0]);
                  } else {
                    N = 0U;
                  }
                } else if (blockDims[0] >= 4.294967296E+9) {
                  N = MAX_uint32_T;
                } else {
                  N = 0U;
                }

                mwApplyLaunchParameters(computeNumIters(0, nG - 1), dim3(N, 1U,
                  1U), dim3(static_cast<uint32_T>(threadDims[0]), 1U, 1U), &grid,
                  &block);
                gpuEmxEnsureCapacity_int32_T(b_cpu_rows, &b_gpu_rows, false);
                gpuEmxEnsureCapacity_real_T(b_cpu_w, &gpu_w, true);
                c_omega_tmp1_needsGpuEnsureCapa = false;
                gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_rows, b_cpu_rows);
                validLaunchParams = mwValidateLaunchParameters(grid, block);
                if (validLaunchParams) {
                  ec_cwtAvg_kernel77<<<grid, block>>>(b_gpu_expanded, b_gpu_rows,
                    b_gpu_h, nG - 1, gpu_w, b_cpu_h->size[0U]);
                }
              }
            }
          }
        }

        if (!(tau - 1.0 >= 0.0)) {
          i_y = nullptr;
          m13 = emlrtCreateCharArray(2, &iv13[0]);
          emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m13, &rfmt[0]);
          emlrtAssign(&i_y, m13);
          j_y = nullptr;
          m14 = emlrtCreateDoubleScalar(tau - 1.0);
          emlrtAssign(&j_y, m14);
          emlrt_marshallIn(b_sprintf(i_y, j_y, &e_emlrtMCI),
                           "<output of sprintf>", unusedExpr);
        }

        nG = 2;
        if (b_cpu_w->size[0] != 1) {
          nG = 1;
        }

        wav_outdatedOnCpu = false;
        fx_data_outdatedOnCpu = false;
        for (bcoef = 0; bcoef < 2; bcoef++) {
          cpu_csz[bcoef] = b_cpu_w->size[bcoef];
          fx_data_outdatedOnCpu = true;
          cpu_lshift[bcoef] = b_cpu_w->size[bcoef];
          wav_outdatedOnCpu = true;
        }

        if (1 - nG >= 0) {
          cpu_nrefine = static_cast<int32_T>((2.0 - (1.0 - static_cast<real_T>
            (nG))) / 2.0);
          mwGetLaunchParameters1D(computeNumIters(cpu_nrefine - 1), &grid,
            &block, 2147483647U);
          if (wav_outdatedOnCpu) {
            checkCudaError(cudaMemcpy(*gpu_lshift, cpu_lshift, 8UL,
              cudaMemcpyHostToDevice), __FILE__, __LINE__);
          }

          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel57<<<grid, block>>>(1 - nG, cpu_nrefine - 1,
              *gpu_lshift);
          }

          checkCudaError(cudaMemcpy(cpu_lshift, *gpu_lshift, 8UL,
            cudaMemcpyDeviceToHost), __FILE__, __LINE__);
        }

        cpu_nrefine = cpu_lshift[0];
        cpu_lshift[0] = cpu_lshift[1];
        cpu_lshift[1] = cpu_nrefine;
        if ((tau == 0.0) || ((tau > 0.0) && (cpu_lshift[0] < 1))) {
          ix = 1;
          lidx = -1;
        } else {
          ix = static_cast<int32_T>(tau);
          lidx = cpu_lshift[0] - 1;
        }

        if (fx_data_outdatedOnCpu) {
          checkCudaError(cudaMemcpy(*gpu_csz, cpu_csz, 8UL,
            cudaMemcpyHostToDevice), __FILE__, __LINE__);
        }

        ec_cwtAvg_kernel58<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(ix, lidx, nG,
          *gpu_csz);
        eint = c_cpu_w->size[0] * c_cpu_w->size[1];
        c_cpu_w->size[0] = div_s32(lidx, ix) + 1;
        c_cpu_w->size[1] = cpu_nrefine;
        emxEnsureCapacity_real_T(c_cpu_w, eint, &xc_emlrtRTEI);
        bcoef = lidx / ix;
        mwGetLaunchParameters1D(computeNumIters(cpu_nrefine - 1, bcoef), &grid,
          &block, 2147483647U);
        if (c_omega_tmp1_needsGpuEnsureCapa) {
          gpuEmxEnsureCapacity_real_T(b_cpu_w, &gpu_w, true);
        }

        gpuEmxEnsureCapacity_real_T(c_cpu_w, &b_gpu_w, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_cwtAvg_kernel59<<<grid, block>>>(gpu_w, cpu_lshift[0], ix, bcoef,
            cpu_nrefine - 1, b_gpu_w, c_cpu_w->size[0U]);
        }

        checkCudaError(cudaMemcpy(cpu_csz, *gpu_csz, 8UL, cudaMemcpyDeviceToHost),
                       __FILE__, __LINE__);
        eint = o_cpu_y->size[0] * o_cpu_y->size[1];
        o_cpu_y->size[0] = cpu_csz[0];
        o_cpu_y->size[1] = cpu_csz[1];
        emxEnsureCapacity_real_T(o_cpu_y, eint, &sc_emlrtRTEI);
        bcoef = cpu_csz[0] * cpu_csz[1] - 1;
        mwGetLaunchParameters1D(computeNumIters(bcoef), &grid, &block,
          2147483647U);
        gpuEmxEnsureCapacity_real_T(o_cpu_y, &h_gpu_y, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_cwtAvg_kernel60<<<grid, block>>>(b_gpu_w, bcoef, h_gpu_y);
        }

        cpu_r = std::ceil(((static_cast<real_T>(cpu_xCh->size[0]) - 1.0) * q_ok
                           + static_cast<real_T>(b_cpu_h->size[0])) / tau);
        if (!(cpu_csz[0] < cpu_r)) {
          if (cpu_r < 1.0) {
            cpu_nrefine = 0;
          } else {
            cpu_nrefine = static_cast<int32_T>(cpu_r);
          }

          nx = d_cpu_w->size[0] * d_cpu_w->size[1];
          d_cpu_w->size[0] = div_s32(lidx, ix) + 1;
          d_cpu_w->size[1] = cpu_lshift[1];
          emxEnsureCapacity_real_T(d_cpu_w, nx, &xc_emlrtRTEI);
          bcoef = lidx / ix;
          mwGetLaunchParameters1D(computeNumIters(cpu_lshift[1] - 1, bcoef),
            &grid, &block, 2147483647U);
          gpuEmxEnsureCapacity_real_T(d_cpu_w, &c_gpu_w, true);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel61<<<grid, block>>>(gpu_w, cpu_lshift[0], ix, bcoef,
              cpu_lshift[1] - 1, c_gpu_w, d_cpu_w->size[0U]);
          }

          nx = o_cpu_y->size[0] * o_cpu_y->size[1];
          o_cpu_y->size[0] = cpu_nrefine;
          o_cpu_y->size[1] = cpu_csz[1];
          emxEnsureCapacity_real_T(o_cpu_y, nx, &ad_emlrtRTEI);
          mwGetLaunchParameters1D(computeNumIters(cpu_csz[1] - 1, cpu_nrefine -
            1), &grid, &block, 2147483647U);
          gpuEmxEnsureCapacity_real_T(o_cpu_y, &h_gpu_y, true);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel62<<<grid, block>>>(c_gpu_w, cpu_csz[0], cpu_nrefine
              - 1, cpu_csz[1] - 1, h_gpu_y, o_cpu_y->size[0U]);
          }
        }

        if (std::isnan(intFsq)) {
          eint = p_cpu_y->size[0] * p_cpu_y->size[1];
          p_cpu_y->size[0] = 1;
          p_cpu_y->size[1] = 1;
          emxEnsureCapacity_real_T(p_cpu_y, eint, &d_emlrtRTEI);
          gpuEmxEnsureCapacity_real_T(p_cpu_y, &i_gpu_y, true);
          e_y_needsGpuEnsureCapacity = false;
          ec_cwtAvg_kernel63<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(i_gpu_y);
        } else if (intFsq < 1.0) {
          p_cpu_y->size[0] = 1;
          p_cpu_y->size[1] = 0;
        } else {
          eint = p_cpu_y->size[0] * p_cpu_y->size[1];
          p_cpu_y->size[0] = 1;
          p_cpu_y->size[1] = static_cast<int32_T>(intFsq - 1.0) + 1;
          emxEnsureCapacity_real_T(p_cpu_y, eint, &d_emlrtRTEI);
          mwGetLaunchParameters1D(computeNumIters(static_cast<int32_T>(intFsq -
            1.0)), &grid, &block, 2147483647U);
          gpuEmxEnsureCapacity_real_T(p_cpu_y, &i_gpu_y, true);
          e_y_needsGpuEnsureCapacity = false;
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwtAvg_kernel65<<<grid, block>>>(static_cast<int32_T>(intFsq -
              1.0), i_gpu_y);
          }
        }

        eint = cpu_xCh->size[0];
        cpu_xCh->size[0] = static_cast<int32_T>(intFsq);
        emxEnsureCapacity_real_T(cpu_xCh, eint, &yc_emlrtRTEI);
        mwGetLaunchParameters1D(computeNumIters(static_cast<int32_T>(intFsq) - 1),
          &grid, &block, 2147483647U);
        if (e_y_needsGpuEnsureCapacity) {
          gpuEmxEnsureCapacity_real_T(p_cpu_y, &i_gpu_y, true);
        }

        e_y_needsGpuEnsureCapacity = false;
        gpuEmxEnsureCapacity_real_T(cpu_xCh, &gpu_xCh, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_cwtAvg_kernel64<<<grid, block>>>(h_gpu_y, i_gpu_y, intDsq,
            static_cast<int32_T>(intFsq) - 1, gpu_xCh);
        }
      }

      nx = y_data[b_nx].f1->size[0] * y_data[b_nx].f1->size[1];
      y_data[b_nx].f1->size[0] = cpu_xCh->size[0];
      emxEnsureCapacity_real_T(y_data[b_nx].f1, nx, &hc_emlrtRTEI);
      eint = y_data[b_nx].f1->size[0] * y_data[b_nx].f1->size[1];
      y_data[b_nx].f1->size[1] = 1;
      emxEnsureCapacity_real_T(y_data[b_nx].f1, eint, &hc_emlrtRTEI);
      for (eint = 0; eint < cpu_xCh->size[0]; eint++) {
        if (xCh_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_xCh, &gpu_xCh);
        }

        xCh_outdatedOnCpu = false;
        y_data[b_nx].f1->data[eint] = cpu_xCh->data[eint];
      }

      //  Downsample
    } else {
      // 'ec_cwtAvg:40' else
      // 'ec_cwtAvg:41' y{ch} = xCh;
      nx = y_data[b_nx].f1->size[0] * y_data[b_nx].f1->size[1];
      y_data[b_nx].f1->size[0] = cpu_xCh->size[0];
      emxEnsureCapacity_real_T(y_data[b_nx].f1, nx, &lb_emlrtRTEI);
      eint = y_data[b_nx].f1->size[0] * y_data[b_nx].f1->size[1];
      y_data[b_nx].f1->size[1] = 1;
      emxEnsureCapacity_real_T(y_data[b_nx].f1, eint, &lb_emlrtRTEI);
      for (eint = 0; eint < cpu_xCh->size[0]; eint++) {
        if (xCh_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_xCh, &gpu_xCh);
        }

        xCh_outdatedOnCpu = false;
        y_data[b_nx].f1->data[eint] = cpu_xCh->data[eint];
      }
    }
  }

  emxFree_real_T(&d_cpu_w);
  emxFree_real_T(&c_cpu_w);
  emxFree_real_T(&cpu_b0);
  emxFree_real_T(&p_cpu_y);
  emxFree_real_T(&o_cpu_y);
  emxFree_int32_T(&b_cpu_rows);
  emxFree_int32_T(&cpu_rows);
  emxFree_int32_T(&cpu_iv15);
  emxFree_int32_T(&cpu_iv14);
  emxFree_int32_T(&n_cpu_y);
  emxFree_int32_T(&m_cpu_y);
  emxFree_real_T(&b_cpu_expanded);
  emxFree_real_T(&cpu_expanded);
  emxFree_real_T(&d_cpu_c);
  emxFree_real_T(&b_cpu_w);
  emxFree_real_T(&l_cpu_y);
  emxFree_int32_T(&cpu_IPIV);
  emxFree_ptrdiff_t(&jpvt_t);
  emxFree_real_T(&k_cpu_y);
  emxFree_real_T(&e_cpu_x);
  emxFree_real_T(&cpu_tau);
  emxFree_real_T(&cpu_dv24);
  emxFree_int32_T(&cpu_jpvt);
  emxFree_real_T(&d_cpu_x);
  emxFree_real_T(&cpu_yCol);
  emxFree_real_T(&cpu_dv23);
  emxFree_real_T(&b_cpu_a);
  emxFree_real_T(&cpu_b);
  emxFree_int32_T(&cpu_iv9);
  emxFree_real_T(&cpu_sinc4A);
  emxFree_uint32_T(&j_cpu_y);
  emxFree_real_T(&b_cpu_h);
  emxFree_real_T(&cpu_sinc3A);
  emxFree_real_T(&cpu_sinc2A);
  emxFree_real_T(&cpu_sinc1A);
  emxFree_real_T(&cpu_G);
  emxFree_real_T(&cpu_k);
  emxFree_real_T(&cpu_m);
  emxFree_real_T(&cpu_h);
  emxFree_real_T(&cpu_h1);
  emxFree_real_T(&cpu_dv22);
  emxFree_real_T(&cpu_opts_filter);
  emxFree_real_T(&cpu_xCh);
  emxFree_real_T(&c_cpu_c);
  emxFree_real_T(&i_cpu_y);
  emxFree_real_T(&cpu_abswt2S);
  emxFree_real_T(&cpu_abswt2);
  emxFree_real_T(&h_cpu_y);
  emxFree_real_T(&b_cpu_c);
  emxFree_real_T(&cpu_c);
  emxFree_real_T(&cpu_z);
  emxFree_uint32_T(&g_cpu_y);
  emxFree_real_T(&cpu_a);
  emxFree_real_T(&cpu_abscfssq);
  emxFree_real_T(&f_cpu_y);
  emxFree_creal_T(&cpu_cfspos);
  emxFree_creal_T(&cpu_cfsposdft);
  emxFree_real_T(&c_cpu_x);
  emxFree_creal_T(&cpu_xposdft);
  emxFree_real_T(&cpu_xv);
  emxFree_real_T(&cpu_savgpTMP);
  emxFree_real_T(&cpu_daughter);
  emxFree_real_T(&cpu_fb_Scales);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  gpuEmxMemcpyGpuToCpu_real_T(cpu_freqs, &gpu_freqs);
  gpuEmxFree_real_T(&b_gpu_x);
  gpuEmxFree_real_T(&gpu_freqs);
  checkCudaError(mwCudaFree(gpu_dc6), __FILE__, __LINE__);
  checkCudaError(mwCudaFree(gpu_dc1), __FILE__, __LINE__);
  checkCudaError(mwCudaFree(gpu_nrefine), __FILE__, __LINE__);
  checkCudaError(mwCudaFree(gpu_r), __FILE__, __LINE__);
  checkCudaError(mwCudaFree(*gpu_wav), __FILE__, __LINE__);
  gpuEmxFree_int32_T(&gpu_omega_tmp1);
  checkCudaError(mwCudaFree(*gpu_wname), __FILE__, __LINE__);
  gpuEmxFree_real_T(&gpu_omega_tmp2);
  checkCudaError(mwCudaFree(*gpu_interval), __FILE__, __LINE__);
  gpuEmxFree_real_T(&gpu_fb_Omega);
  checkCudaError(mwCudaFree(*gpu_subs), __FILE__, __LINE__);
  checkCudaError(mwCudaFree(*gpu_x_data), __FILE__, __LINE__);
  gpuEmxFree_real_T(&gpu_fb_Scales);
  checkCudaError(mwCudaFree(*b_gpu_x_data), __FILE__, __LINE__);
  checkCudaError(mwCudaFree(*gpu_xt_data), __FILE__, __LINE__);
  gpuEmxFree_real_T(&gpu_y);
  checkCudaError(mwCudaFree(*gpu_y_data), __FILE__, __LINE__);
  gpuEmxFree_real_T(&b_gpu_y);
  checkCudaError(mwCudaFree(*b_gpu_y_data), __FILE__, __LINE__);
  checkCudaError(mwCudaFree(*e_gpu_fx_data), __FILE__, __LINE__);
  gpuEmxFree_real_T(&o_gpu_y);
  checkCudaError(mwCudaFree(*gpu_a_data), __FILE__, __LINE__);
  gpuEmxFree_real_T(&p_gpu_y);
  checkCudaError(mwCudaFree(*gpu_dv10_data), __FILE__, __LINE__);
  checkCudaError(mwCudaFree(*gpu_dv4_data), __FILE__, __LINE__);
  checkCudaError(mwCudaFree(*d_gpu_fx_data), __FILE__, __LINE__);
  gpuEmxFree_real_T(&gpu_daughter);
  gpuEmxFree_real_T(&gpu_f);
  gpuEmxFree_real_T(&b_gpu_somega);
  gpuEmxFree_real_T(&gpu_somega);
  gpuEmxFree_real_T(&d_gpu_w);
  gpuEmxFree_real_T(&gpu_absomega);
  gpuEmxFree_real_T(&gpu_expnt);
  checkCudaError(mwCudaFree(*c_gpu_fx_data), __FILE__, __LINE__);
  gpuEmxFree_real_T(&gpu_powscales);
  checkCudaError(mwCudaFree(*b_gpu_a_data), __FILE__, __LINE__);
  gpuEmxFree_real_T(&gpu_x);
  gpuEmxFree_real_T(&n_gpu_y);
  checkCudaError(mwCudaFree(*gpu_dv15_data), __FILE__, __LINE__);
  checkCudaError(mwCudaFree(*gpu_dv11_data), __FILE__, __LINE__);
  checkCudaError(mwCudaFree(*b_gpu_fx_data), __FILE__, __LINE__);
  gpuEmxFree_real_T(&gpu_savgpTMP);
  gpuEmxFree_real_T(&gpu_xv);
  gpuEmxFree_creal_T(&gpu_xposdft);
  gpuEmxFree_real_T(&c_gpu_x);
  gpuEmxFree_creal_T(&gpu_cfsposdft);
  gpuEmxFree_creal_T(&gpu_cfspos);
  gpuEmxFree_real_T(&c_gpu_y);
  gpuEmxFree_real_T(&gpu_abscfssq);
  gpuEmxFree_real_T(&gpu_a);
  gpuEmxFree_uint32_T(&d_gpu_y);
  gpuEmxFree_real_T(&gpu_z);
  gpuEmxFree_real_T(&gpu_c);
  gpuEmxFree_real_T(&d_gpu_c);
  gpuEmxFree_real_T(&e_gpu_y);
  gpuEmxFree_real_T(&gpu_abswt2);
  gpuEmxFree_real_T(&gpu_abswt2S);
  gpuEmxFree_real_T(&f_gpu_y);
  gpuEmxFree_real_T(&c_gpu_c);
  gpuEmxFree_real_T(&gpu_xCh);
  gpuEmxFree_real_T(&gpu_opts_filter);
  gpuEmxFree_real_T(&gpu_dv22);
  gpuEmxFree_real_T(&gpu_h1);
  gpuEmxFree_real_T(&gpu_h);
  gpuEmxFree_real_T(&gpu_m);
  gpuEmxFree_real_T(&gpu_k);
  gpuEmxFree_real_T(&gpu_G);
  gpuEmxFree_real_T(&gpu_sinc1A);
  gpuEmxFree_real_T(&gpu_sinc2A);
  gpuEmxFree_real_T(&gpu_sinc3A);
  gpuEmxFree_real_T(&b_gpu_h);
  gpuEmxFree_uint32_T(&g_gpu_y);
  gpuEmxFree_real_T(&gpu_sinc4A);
  gpuEmxFree_int32_T(&gpu_iv9);
  gpuEmxFree_real_T(&gpu_b);
  gpuEmxFree_real_T(&b_gpu_a);
  gpuEmxFree_real_T(&gpu_dv23);
  gpuEmxFree_real_T(&gpu_yCol);
  gpuEmxFree_real_T(&e_gpu_x);
  gpuEmxFree_int32_T(&gpu_jpvt);
  gpuEmxFree_real_T(&gpu_dv24);
  gpuEmxFree_real_T(&gpu_tau);
  gpuEmxFree_real_T(&d_gpu_x);
  gpuEmxFree_real_T(&l_gpu_y);
  gpuEmxFree_int32_T(&gpu_IPIV);
  gpuEmxFree_real_T(&m_gpu_y);
  gpuEmxFree_real_T(&gpu_w);
  gpuEmxFree_real_T(&b_gpu_c);
  gpuEmxFree_real_T(&b_gpu_expanded);
  gpuEmxFree_real_T(&gpu_expanded);
  gpuEmxFree_int32_T(&k_gpu_y);
  gpuEmxFree_int32_T(&j_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv14);
  gpuEmxFree_int32_T(&gpu_iv15);
  gpuEmxFree_int32_T(&gpu_rows);
  gpuEmxFree_int32_T(&b_gpu_rows);
  gpuEmxFree_real_T(&h_gpu_y);
  gpuEmxFree_real_T(&i_gpu_y);
  gpuEmxFree_real_T(&gpu_b0);
  gpuEmxFree_real_T(&b_gpu_w);
  gpuEmxFree_real_T(&c_gpu_w);
  checkCudaError(mwCudaFree(*gpu_fx_data), __FILE__, __LINE__);
  checkCudaError(mwCudaFree(*gpu_csz), __FILE__, __LINE__);
  checkCudaError(mwCudaFree(*gpu_lshift), __FILE__, __LINE__);
}

void ec_cwtAvg_atexit()
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
  mwCudaFree(*global_gpu_cv);
  mwCudaFree(*global_gpu_table100);
}

void ec_cwtAvg_initialize()
{
  emlrtInitGPU(emlrtRootTLSGlobal);
  cudaGetLastError();
  mexFunctionCreateRootTLS();
  emlrtClearAllocCountR2012b(emlrtRootTLSGlobal, false, 0U, nullptr);
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtLicenseCheckR2022a(emlrtRootTLSGlobal,
    "EMLRT:runTime:MexFunctionNeedsLicense", "distrib_computing_toolbox", 2);
  emlrtLicenseCheckR2022a(emlrtRootTLSGlobal,
    "EMLRT:runTime:MexFunctionNeedsLicense", "wavelet_toolbox", 2);
  emlrtLicenseCheckR2022a(emlrtRootTLSGlobal,
    "EMLRT:runTime:MexFunctionNeedsLicense", "signal_toolbox", 2);
  cublasEnsureInitialization(CUBLAS_POINTER_MODE_HOST);
  cusolverEnsureInitialization();
  if (emlrtFirstTimeR2012b(emlrtRootTLSGlobal)) {
    ec_cwtAvg_once();
  }
}

void ec_cwtAvg_terminate()
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

// End of code generation (ec_cwtAvg.cu)
