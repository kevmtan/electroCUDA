//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// conv2.cu
//
// Code generation for function 'conv2'
//

// Include files
#include "conv2.h"
#include "ec_wt_fp_data.h"
#include "ec_wt_fp_emxutil.h"
#include "ec_wt_fp_mexutil.h"
#include "ec_wt_fp_types.h"
#include "rt_nonfinite.h"
#include "MWCudaDimUtility.hpp"
#include "MWCudaMemoryFunctions.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"
#include <cmath>

// Variable Definitions
static emlrtRTEInfo xg_emlrtRTEI{
    49,                                                               // lineNo
    31,                                                               // colNo
    "conv2",                                                          // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/conv2.m" // pName
};

static emlrtRTEInfo yg_emlrtRTEI{
    47,                                                               // lineNo
    9,                                                                // colNo
    "conv2",                                                          // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/conv2.m" // pName
};

static emlrtRTEInfo ah_emlrtRTEI{
    58,                                                               // lineNo
    5,                                                                // colNo
    "conv2",                                                          // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/conv2.m" // pName
};

static emlrtRTEInfo bh_emlrtRTEI{
    75,                                                               // lineNo
    5,                                                                // colNo
    "conv2",                                                          // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/conv2.m" // pName
};

static emlrtRTEInfo
    ch_emlrtRTEI{
        88,                  // lineNo
        13,                  // colNo
        "eml_mtimes_helper", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/ops/"
        "eml_mtimes_helper.m" // pName
    };

static emlrtRTEInfo dh_emlrtRTEI{
    1,                 // lineNo
    1,                 // colNo
    "stencil_codegen", // fName
    "/usr/local/MATLAB/R2024a/toolbox/gpucoder/gpucoder/+gpucoder/+internal/"
    "stencil_codegen.p" // pName
};

static emlrtRTEInfo eh_emlrtRTEI{
    49,                                                               // lineNo
    9,                                                                // colNo
    "conv2",                                                          // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/conv2.m" // pName
};

static emlrtRTEInfo fh_emlrtRTEI{
    172,                                                          // lineNo
    20,                                                           // colNo
    "colon",                                                      // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/ops/colon.m" // pName
};

static emlrtRTEInfo gh_emlrtRTEI{
    49,                                                               // lineNo
    13,                                                               // colNo
    "conv2",                                                          // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/conv2.m" // pName
};

static emlrtRTEInfo hh_emlrtRTEI{
    82,                                                           // lineNo
    9,                                                            // colNo
    "colon",                                                      // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/ops/colon.m" // pName
};

static emlrtRTEInfo ih_emlrtRTEI{
    56,                                                               // lineNo
    5,                                                                // colNo
    "conv2",                                                          // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/conv2.m" // pName
};

// Function Declarations
namespace coder {
static void
conv2NonSeparable(emxArray_real32_T *cpu_a, boolean_T *a_outdatedOnCpu,
                  emxArray_real32_T *gpu_a, boolean_T *a_outdatedOnGpu,
                  emxArray_creal32_T *cpu_b, emxArray_creal32_T *gpu_b,
                  boolean_T *b_outdatedOnGpu, emxArray_creal32_T *cpu_c,
                  boolean_T *c_outdatedOnCpu, emxArray_creal32_T *gpu_c,
                  boolean_T *c_outdatedOnGpu);

}
static __global__ void conv2NonSeparable_kernel73(const int32_T b,
                                                  emxArray_creal32_T c);

static __global__ void conv2NonSeparable_kernel74(const int32_T b,
                                                  emxArray_creal32_T c);

static __global__ void conv2NonSeparable_kernel75(const real32_T f,
                                                  creal32_T a_data[1]);

static __global__ void conv2NonSeparable_kernel76(const emxArray_creal32_T b,
                                                  const creal32_T a_data[1],
                                                  emxArray_creal32_T c);

static __global__ void conv2NonSeparable_kernel77(const int32_T OH,
                                                  emxArray_real32_T expanded);

static __global__ void conv2NonSeparable_kernel78(const int32_T offsetH,
                                                  const emxArray_int32_T y,
                                                  const int32_T b_y,
                                                  emxArray_int32_T iv);

static __global__ void
conv2NonSeparable_kernel79(const emxArray_real32_T a, const int32_T mc,
                           const emxArray_int32_T iv, const int32_T b,
                           emxArray_real32_T expanded, int32_T expanded_dim0);

static __global__ void conv2NonSeparable_kernel80(
    const emxArray_real32_T expanded, const emxArray_int32_T cols,
    const emxArray_int32_T rows, const emxArray_creal32_T b, const int32_T c,
    const int32_T d, emxArray_creal32_T b_c, int32_T b_dim0, int32_T b_dim1,
    int32_T expanded_dim0, int32_T c_dim0);

static __global__ void conv2_kernel52(const emxArray_creal32_T a,
                                      const int32_T b_a, emxArray_creal32_T c_a,
                                      int32_T a_dim0);

static __global__ void conv2_kernel53(const int32_T a, emxArray_creal32_T c);

static __global__ void conv2_kernel54(const emxArray_creal32_T a,
                                      const real32_T cv_im, real32_T *f,
                                      real32_T *cv_re);

static __global__ void conv2_kernel55(const real32_T *cv_re, const real32_T *f,
                                      emxArray_creal32_T c);

static __global__ void conv2_kernel56(const emxArray_creal32_T c,
                                      const int32_T b_c, emxArray_creal32_T c_c,
                                      int32_T c_dim0);

static __global__ void conv2_kernel57(const int32_T a,
                                      emxArray_creal32_T expanded);

static __global__ void conv2_kernel58(const emxArray_int32_T y,
                                      const int32_T b_y, emxArray_int32_T iv);

static __global__ void conv2_kernel59(const emxArray_creal32_T a,
                                      const emxArray_int32_T iv,
                                      const int32_T b,
                                      emxArray_creal32_T expanded);

static __global__ void conv2_kernel60(const emxArray_creal32_T expanded,
                                      const real32_T cv_im, const int32_T b,
                                      emxArray_creal32_T c);

static __global__ void conv2_kernel61(const int32_T b, emxArray_creal32_T c);

static __global__ void conv2_kernel62(const int32_T b, emxArray_creal32_T c);

static __global__ void conv2_kernel63(const real32_T cv_re,
                                      creal32_T b_data[1]);

static __global__ void conv2_kernel64(const emxArray_creal32_T a,
                                      const creal32_T b_data[1],
                                      emxArray_creal32_T b_a);

static __global__ void conv2_kernel65(const emxArray_creal32_T a,
                                      const int32_T iv1, emxArray_creal32_T c);

static __global__ void conv2_kernel66(const int32_T OH,
                                      emxArray_creal32_T expanded);

static __global__ void conv2_kernel67(const int32_T offsetH,
                                      const emxArray_int32_T y,
                                      const int32_T b_y, emxArray_int32_T iv1);

static __global__ void conv2_kernel68(const emxArray_int32_T y,
                                      const int32_T b_y, emxArray_int32_T iv2);

static __global__ void
conv2_kernel69(const emxArray_creal32_T a, const int32_T iv1_dim0,
               const emxArray_int32_T iv2, const emxArray_int32_T iv1,
               const int32_T b_iv1, const int32_T c_iv1,
               emxArray_creal32_T expanded, int32_T expanded_dim0);

static __global__ void
conv2_kernel70(const int32_T offsetH, const emxArray_creal32_T expanded,
               const int32_T k, const emxArray_int32_T rows,
               const int32_T b_rows, emxArray_creal32_T newIm,
               int32_T expanded_dim0);

static __global__ void conv2_kernel71(const real32_T cv_re,
                                      const int32_T offsetH, const int32_T k,
                                      emxArray_creal32_T c, int32_T c_dim0);

static __global__ void conv2_kernel72(const real32_T cv_im,
                                      const int32_T offsetH, const int32_T k,
                                      emxArray_creal32_T c, int32_T c_dim0);

static __global__ void conv2_kernel81(const int32_T b, emxArray_creal32_T c);

static __global__ void conv2_kernel82(const int32_T OH,
                                      emxArray_real32_T expanded);

static __global__ void conv2_kernel83(const int32_T offsetH,
                                      const emxArray_int32_T y,
                                      const int32_T b_y, emxArray_int32_T iv1);

static __global__ void conv2_kernel84(const emxArray_real32_T b,
                                      const emxArray_int32_T iv1,
                                      const int32_T c,
                                      emxArray_real32_T expanded);

static __global__ void conv2_kernel85(const emxArray_real32_T expanded,
                                      const emxArray_int32_T rows,
                                      const emxArray_creal32_T a,
                                      const int32_T b, emxArray_creal32_T c,
                                      int32_T a_dim0);

static __global__ void conv2_kernel86(const int32_T b, emxArray_creal32_T c);

static __global__ void conv2_kernel87(const int32_T OH,
                                      emxArray_creal32_T expanded);

static __global__ void conv2_kernel88(const int32_T offsetH,
                                      const emxArray_int32_T y,
                                      const int32_T b_y, emxArray_int32_T iv);

static __global__ void conv2_kernel89(const emxArray_creal32_T a,
                                      const emxArray_int32_T iv,
                                      const int32_T b,
                                      emxArray_creal32_T expanded);

static __global__ void conv2_kernel90(const emxArray_creal32_T expanded,
                                      const int32_T offsetH,
                                      const emxArray_int32_T rows,
                                      const int32_T b_rows,
                                      emxArray_creal32_T newIm);

static __global__ void conv2_kernel91(const real32_T cv_im,
                                      const real32_T cv_re,
                                      const int32_T offsetH,
                                      emxArray_creal32_T c);

// Function Definitions
//
//
namespace coder {
static void
conv2NonSeparable(emxArray_real32_T *cpu_a, boolean_T *a_outdatedOnCpu,
                  emxArray_real32_T *gpu_a, boolean_T *a_outdatedOnGpu,
                  emxArray_creal32_T *cpu_b, emxArray_creal32_T *gpu_b,
                  boolean_T *b_outdatedOnGpu, emxArray_creal32_T *cpu_c,
                  boolean_T *c_outdatedOnCpu, emxArray_creal32_T *gpu_c,
                  boolean_T *c_outdatedOnGpu)
{
  dim3 block;
  dim3 grid;
  emxArray_int32_T gpu_cols;
  emxArray_int32_T gpu_iv;
  emxArray_int32_T gpu_rows;
  emxArray_int32_T gpu_y;
  emxArray_int32_T *cpu_cols;
  emxArray_int32_T *cpu_iv;
  emxArray_int32_T *cpu_rows;
  emxArray_int32_T *cpu_y;
  emxArray_real32_T gpu_expanded;
  emxArray_real32_T *cpu_expanded;
  creal32_T(*gpu_a_data)[1];
  int32_T k;
  int32_T mc;
  int32_T nc;
  boolean_T validLaunchParams;
  nvtxRangePushA("#fcn#conv2NonSeparable#" MW_AT_LOCATION);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaMalloc#" MW_AT_LINE);
  checkCudaError(mwCudaMalloc(&gpu_a_data, 8UL), __FILE__, __LINE__);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&gpu_cols);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&gpu_rows);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&gpu_iv);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&gpu_y);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu_expanded);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  if ((cpu_a->size[0] == 0) || (cpu_b->size[0] == 0)) {
    mc = cpu_a->size[0] + cpu_b->size[0];
  } else {
    mc = (cpu_a->size[0] + cpu_b->size[0]) - 1;
  }
  if (cpu_b->size[1] == 0) {
    nc = 1;
  } else {
    nc = cpu_b->size[1];
  }
  k = cpu_c->size[0] * cpu_c->size[1];
  cpu_c->size[0] = mc;
  cpu_c->size[1] = nc;
  nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
  emxEnsureCapacity_creal32_T(cpu_c, k, &bh_emlrtRTEI);
  k = mc * nc - 1;
  nvtxMarkA("#computeNumIters#" MW_AT_LINE);
  mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
  nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
  gpuEmxEnsureCapacity_creal32_T(cpu_c, gpu_c, true);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    nvtxMarkA("#conv2NonSeparable_kernel73#" MW_AT_LINE);
    conv2NonSeparable_kernel73<<<grid, block>>>(k, *gpu_c);
  }
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&cpu_expanded, 2, &dh_emlrtRTEI, true);
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&cpu_y, 2, &hh_emlrtRTEI, true);
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&cpu_iv, 1, &dh_emlrtRTEI, true);
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&cpu_rows, 2, &dh_emlrtRTEI, true);
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&cpu_cols, 2, &dh_emlrtRTEI, true);
  if ((cpu_a->size[0] == 0) ||
      ((cpu_b->size[0] == 0) || (cpu_b->size[1] == 0))) {
    k = cpu_c->size[0] * cpu_c->size[1];
    cpu_c->size[0] = mc;
    cpu_c->size[1] = nc;
    nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
    emxEnsureCapacity_creal32_T(cpu_c, k, &bh_emlrtRTEI);
    k = mc * nc - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal32_T(cpu_c, gpu_c, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#conv2NonSeparable_kernel74#" MW_AT_LINE);
      conv2NonSeparable_kernel74<<<grid, block>>>(k, *gpu_c);
    }
  } else if ((cpu_a->size[0] == 1) &&
             ((cpu_b->size[0] == 1) && (cpu_b->size[1] == 1))) {
    real32_T f;
    if (*a_outdatedOnCpu) {
      nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LINE);
      gpuEmxMemcpyGpuToCpu_real32_T(cpu_a, gpu_a);
    }
    *a_outdatedOnCpu = false;
    f = cpu_a->data[0];
    nvtxMarkA("#conv2NonSeparable_kernel75#" MW_AT_LINE);
    conv2NonSeparable_kernel75<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
        f, *gpu_a_data);
    k = cpu_c->size[0] * cpu_c->size[1];
    cpu_c->size[0] = 1;
    cpu_c->size[1] = 1;
    nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
    emxEnsureCapacity_creal32_T(cpu_c, k, &bh_emlrtRTEI);
    nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal32_T(cpu_b, gpu_b, !*b_outdatedOnGpu);
    nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal32_T(cpu_c, gpu_c, true);
    if (*b_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_creal32_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_creal32_T(gpu_b, cpu_b);
    }
    *b_outdatedOnGpu = false;
    nvtxMarkA("#conv2NonSeparable_kernel76#" MW_AT_LINE);
    conv2NonSeparable_kernel76<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
        *gpu_b, *gpu_a_data, *gpu_c);
  } else {
    real_T blockDims[3];
    int32_T OW;
    int32_T b_OH;
    int32_T offsetH;
    uint32_T OH;
    int8_T threadDims[3];
    OH = (static_cast<uint32_T>(cpu_a->size[0]) +
          static_cast<uint32_T>(cpu_b->size[0])) -
         1U;
    mc = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
    nc = static_cast<int32_T>(
        std::fmin(32.0, (static_cast<real_T>(cpu_b->size[1]) + 1.0) - 1.0));
    blockDims[0] =
        std::floor((static_cast<real_T>(OH) + (static_cast<real_T>(mc) - 1.0)) /
                   static_cast<real_T>(mc));
    blockDims[1] =
        std::floor((static_cast<real_T>(static_cast<uint32_T>(cpu_b->size[1]) +
                                        static_cast<uint32_T>(nc)) -
                    1.0) /
                   static_cast<real_T>(nc));
    threadDims[0] = static_cast<int8_T>(mc);
    threadDims[1] = static_cast<int8_T>(nc);
    OW = cpu_b->size[1];
    if (OH > 2147483647U) {
      OH = 2147483647U;
    }
    b_OH = static_cast<int32_T>(OH);
    offsetH = static_cast<int32_T>(
                  std::floor(static_cast<real_T>(cpu_b->size[0]) / 2.0)) +
              static_cast<int32_T>(std::floor(
                  (static_cast<real_T>(cpu_b->size[0]) - 1.0) / 2.0));
    if (cpu_b->size[0] > MAX_int32_T - static_cast<int32_T>(OH)) {
      mc = MAX_int32_T;
    } else {
      mc = static_cast<int32_T>(OH) + cpu_b->size[0];
    }
    k = cpu_expanded->size[0] * cpu_expanded->size[1];
    cpu_expanded->size[0] = mc - 1;
    nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
    emxEnsureCapacity_real32_T(cpu_expanded, k, &dh_emlrtRTEI);
    if (cpu_b->size[1] > MAX_int32_T - cpu_b->size[1]) {
      mc = MAX_int32_T;
    } else {
      mc = cpu_b->size[1] + cpu_b->size[1];
    }
    k = cpu_expanded->size[0] * cpu_expanded->size[1];
    cpu_expanded->size[1] = mc - 1;
    nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
    emxEnsureCapacity_real32_T(cpu_expanded, k, &dh_emlrtRTEI);
    k = ((static_cast<int32_T>(OH) + cpu_b->size[0]) - 1) *
            ((cpu_b->size[1] + cpu_b->size[1]) - 1) -
        1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real32_T(cpu_expanded, &gpu_expanded, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#conv2NonSeparable_kernel77#" MW_AT_LINE);
      conv2NonSeparable_kernel77<<<grid, block>>>(k, gpu_expanded);
    }
    nc = cpu_a->size[0];
    k = cpu_y->size[0] * cpu_y->size[1];
    cpu_y->size[0] = 1;
    cpu_y->size[1] = cpu_a->size[0];
    nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
    emxEnsureCapacity_int32_T(cpu_y, k, &fh_emlrtRTEI);
    cpu_y->data[0] = 1;
    mc = 1;
    profileLoopStart("conv2NonSeparable_loop_0", __LINE__, (nc - 2) + 1, "");
    for (k = 0; k <= nc - 2; k++) {
      mc++;
      cpu_y->data[k + 1] = mc;
    }
    profileLoopEnd();
    k = cpu_iv->size[0];
    cpu_iv->size[0] = cpu_y->size[1];
    nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
    emxEnsureCapacity_int32_T(cpu_iv, k, &dh_emlrtRTEI);
    k = cpu_y->size[1] - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_int32_T(cpu_y, &gpu_y, false);
    nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_int32_T(cpu_iv, &gpu_iv, true);
    nvtxMarkA("#gpuEmxMemcpyCpuToGpu_int32_T#" MW_AT_LINE);
    gpuEmxMemcpyCpuToGpu_int32_T(&gpu_y, cpu_y);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#conv2NonSeparable_kernel78#" MW_AT_LINE);
      conv2NonSeparable_kernel78<<<grid, block>>>(offsetH, gpu_y, k, gpu_iv);
    }
    mc = static_cast<int32_T>(
             std::floor(static_cast<real_T>(cpu_b->size[1]) / 2.0)) +
         static_cast<int32_T>(
             std::floor((static_cast<real_T>(cpu_b->size[1]) - 1.0) / 2.0));
    nc = cpu_iv->size[0];
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(nc - 1), &grid, &block,
                            2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real32_T(cpu_a, gpu_a, !*a_outdatedOnGpu);
    if (*a_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real32_T(gpu_a, cpu_a);
    }
    *a_outdatedOnGpu = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#conv2NonSeparable_kernel79#" MW_AT_LINE);
      conv2NonSeparable_kernel79<<<grid, block>>>(
          *gpu_a, mc, gpu_iv, nc - 1, gpu_expanded, cpu_expanded->size[0U]);
    }
    nc = cpu_b->size[0];
    k = cpu_rows->size[0] * cpu_rows->size[1];
    cpu_rows->size[0] = 1;
    cpu_rows->size[1] = cpu_b->size[0];
    nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
    emxEnsureCapacity_int32_T(cpu_rows, k, &fh_emlrtRTEI);
    cpu_rows->data[0] = 0;
    mc = 0;
    profileLoopStart("conv2NonSeparable_loop_1", __LINE__, (nc - 2) + 1, "");
    for (k = 0; k <= nc - 2; k++) {
      mc++;
      cpu_rows->data[k + 1] = mc;
    }
    profileLoopEnd();
    nc = cpu_b->size[1];
    k = cpu_cols->size[0] * cpu_cols->size[1];
    cpu_cols->size[0] = 1;
    cpu_cols->size[1] = cpu_b->size[1];
    nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
    emxEnsureCapacity_int32_T(cpu_cols, k, &fh_emlrtRTEI);
    cpu_cols->data[0] = 0;
    mc = 0;
    profileLoopStart("conv2NonSeparable_loop_2", __LINE__, (nc - 2) + 1, "");
    for (k = 0; k <= nc - 2; k++) {
      mc++;
      cpu_cols->data[k + 1] = mc;
    }
    profileLoopEnd();
    k = cpu_c->size[0] * cpu_c->size[1];
    cpu_c->size[0] = static_cast<int32_T>(OH);
    cpu_c->size[1] = cpu_b->size[1];
    nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
    emxEnsureCapacity_creal32_T(cpu_c, k, &dh_emlrtRTEI);
    if (blockDims[0] < 4.294967296E+9) {
      OH = static_cast<uint32_T>(blockDims[0]);
    } else {
      OH = MAX_uint32_T;
    }
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwApplyLaunchParameters(computeNumIters(OW - 1, b_OH - 1),
                            dim3(OH, static_cast<uint32_T>(blockDims[1]), 1U),
                            dim3(static_cast<uint32_T>(threadDims[0]),
                                 static_cast<uint32_T>(threadDims[1]), 1U),
                            &grid, &block);
    nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_int32_T(cpu_cols, &gpu_cols, false);
    nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_int32_T(cpu_rows, &gpu_rows, false);
    nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal32_T(cpu_b, gpu_b, !*b_outdatedOnGpu);
    nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal32_T(cpu_c, gpu_c, true);
    nvtxMarkA("#gpuEmxMemcpyCpuToGpu_int32_T#" MW_AT_LINE);
    gpuEmxMemcpyCpuToGpu_int32_T(&gpu_cols, cpu_cols);
    nvtxMarkA("#gpuEmxMemcpyCpuToGpu_int32_T#" MW_AT_LINE);
    gpuEmxMemcpyCpuToGpu_int32_T(&gpu_rows, cpu_rows);
    if (*b_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_creal32_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_creal32_T(gpu_b, cpu_b);
    }
    *b_outdatedOnGpu = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#conv2NonSeparable_kernel80#" MW_AT_LINE);
      conv2NonSeparable_kernel80<<<grid, block>>>(
          gpu_expanded, gpu_cols, gpu_rows, *gpu_b, b_OH - 1, OW - 1, *gpu_c,
          cpu_b->size[0U], cpu_b->size[1U], cpu_expanded->size[0U],
          cpu_c->size[0U]);
    }
  }
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&cpu_cols);
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&cpu_rows);
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&cpu_iv);
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&cpu_y);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&cpu_expanded);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu_expanded);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&gpu_y);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&gpu_iv);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&gpu_rows);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&gpu_cols);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaFree#" MW_AT_LINE);
  checkCudaError(mwCudaFree(*gpu_a_data), __FILE__, __LINE__);
  *c_outdatedOnCpu = true;
  *c_outdatedOnGpu = false;
  nvtxRangePop();
}

} // namespace coder
static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel73(
    const int32_T b, emxArray_creal32_T c)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T qY;
    qY = static_cast<int32_T>(idx);
    c.data[qY].re = 0.0F;
    c.data[qY].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel74(
    const int32_T b, emxArray_creal32_T c)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T qY;
    qY = static_cast<int32_T>(idx);
    c.data[qY].re = 0.0F;
    c.data[qY].im = 0.0F;
  }
}

static __global__ __launch_bounds__(32, 1) void conv2NonSeparable_kernel75(
    const real32_T f, creal32_T a_data[1])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    a_data[0].im = 0.0F;
    a_data[0].re = f;
  }
}

static __global__ __launch_bounds__(32, 1) void conv2NonSeparable_kernel76(
    const emxArray_creal32_T b, const creal32_T a_data[1], emxArray_creal32_T c)
{
  int32_T k;
  k = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (k < 1) {
    creal32_T b_b;
    b_b.re = a_data[0].re * b.data[0].re - 0.0F * b.data[0].im;
    b_b.im = a_data[0].re * b.data[0].im + 0.0F * b.data[0].re;
    c.data[0] = b_b;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel77(
    const int32_T OH, emxArray_real32_T expanded)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T qY;
    qY = static_cast<int32_T>(idx);
    expanded.data[qY] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel78(
    const int32_T offsetH, const emxArray_int32_T y, const int32_T b_y,
    emxArray_int32_T iv)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T q1;
    int32_T qY;
    qY = static_cast<int32_T>(idx);
    q1 = y.data[qY];
    if ((offsetH > 0) && (q1 > MAX_int32_T - offsetH)) {
      q1 = MAX_int32_T;
    } else {
      q1 += offsetH;
    }
    iv.data[qY] = q1 - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel79(
    const emxArray_real32_T a, const int32_T mc, const emxArray_int32_T iv,
    const int32_T b, emxArray_real32_T expanded, int32_T expanded_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T qY;
    qY = static_cast<int32_T>(idx);
    expanded.data[iv.data[qY] + expanded_dim0 * mc] = a.data[qY];
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel80(
    const emxArray_real32_T expanded, const emxArray_int32_T cols,
    const emxArray_int32_T rows, const emxArray_creal32_T b, const int32_T c,
    const int32_T d, emxArray_creal32_T b_c, int32_T b_dim0, int32_T b_dim1,
    int32_T expanded_dim0, int32_T c_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(d) + 1UL) * (static_cast<uint64_T>(c) + 1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    creal32_T b_cv;
    int32_T ocol;
    int32_T orow;
    orow = static_cast<int32_T>(idx % (static_cast<uint64_T>(c) + 1UL));
    ocol = static_cast<int32_T>((idx - static_cast<uint64_T>(orow)) /
                                (static_cast<uint64_T>(c) + 1UL));
    b_cv.re = 0.0F;
    b_cv.im = 0.0F;
    for (int32_T n{0}; n < b_dim1; n++) {
      for (int32_T m{0}; m < b_dim0; m++) {
        creal32_T c_b;
        int32_T q1;
        int32_T qY;
        c_b = b.data[((b_dim0 - m) + b_dim0 * ((b_dim1 - n) - 1)) - 1];
        q1 = rows.data[m];
        if (q1 > 2147483646 - orow) {
          qY = MAX_int32_T;
        } else {
          qY = (orow + q1) + 1;
        }
        q1 = cols.data[n];
        if (q1 > 2147483646 - ocol) {
          q1 = MAX_int32_T;
        } else {
          q1 = (ocol + q1) + 1;
        }
        b_cv.re += expanded.data[(qY + expanded_dim0 * (q1 - 1)) - 1] * c_b.re;
        q1 = rows.data[m];
        if (q1 > 2147483646 - orow) {
          qY = MAX_int32_T;
        } else {
          qY = (orow + q1) + 1;
        }
        q1 = cols.data[n];
        if (q1 > 2147483646 - ocol) {
          q1 = MAX_int32_T;
        } else {
          q1 = (ocol + q1) + 1;
        }
        b_cv.im += expanded.data[(qY + expanded_dim0 * (q1 - 1)) - 1] * c_b.im;
      }
    }
    b_c.data[orow + c_dim0 * ocol] = b_cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2_kernel52(
    const emxArray_creal32_T a, const int32_T b_a, emxArray_creal32_T c_a,
    int32_T a_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_a);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    c_a.data[i1] = a.data[a_dim0 * i1];
  }
}

static __global__ __launch_bounds__(1024,
                                    1) void conv2_kernel53(const int32_T a,
                                                           emxArray_creal32_T c)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(a);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    c.data[i1].re = 0.0F;
    c.data[i1].im = 0.0F;
  }
}

static __global__
    __launch_bounds__(32, 1) void conv2_kernel54(const emxArray_creal32_T a,
                                                 const real32_T cv_im,
                                                 real32_T *f, real32_T *cv_re)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    *cv_re = cv_im * a.data[0].re;
    *f = cv_im * a.data[0].im;
  }
}

static __global__ __launch_bounds__(32, 1) void conv2_kernel55(
    const real32_T *cv_re, const real32_T *f, emxArray_creal32_T c)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[0].im = *f;
    c.data[0].re = *cv_re;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2_kernel56(
    const emxArray_creal32_T c, const int32_T b_c, emxArray_creal32_T c_c,
    int32_T c_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_c);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    c_c.data[c_dim0 * i1] = c.data[i1];
  }
}

static __global__
    __launch_bounds__(1024, 1) void conv2_kernel57(const int32_T a,
                                                   emxArray_creal32_T expanded)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(a);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    expanded.data[i1].re = 0.0F;
    expanded.data[i1].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2_kernel58(
    const emxArray_int32_T y, const int32_T b_y, emxArray_int32_T iv)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    iv.data[i1] = y.data[i1] - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2_kernel59(
    const emxArray_creal32_T a, const emxArray_int32_T iv, const int32_T b,
    emxArray_creal32_T expanded)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    expanded.data[iv.data[i1]] = a.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2_kernel60(
    const emxArray_creal32_T expanded, const real32_T cv_im, const int32_T b,
    emxArray_creal32_T c)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T q1;
    q1 = static_cast<int32_T>(idx);
    c.data[q1].re = cv_im * expanded.data[q1].re;
    c.data[q1].im = cv_im * expanded.data[q1].im;
  }
}

static __global__ __launch_bounds__(1024,
                                    1) void conv2_kernel61(const int32_T b,
                                                           emxArray_creal32_T c)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    c.data[i1].re = 0.0F;
    c.data[i1].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024,
                                    1) void conv2_kernel62(const int32_T b,
                                                           emxArray_creal32_T c)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    c.data[i1].re = 0.0F;
    c.data[i1].im = 0.0F;
  }
}

static __global__ __launch_bounds__(32,
                                    1) void conv2_kernel63(const real32_T cv_re,
                                                           creal32_T b_data[1])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    b_data[0].im = 0.0F;
    b_data[0].re = cv_re;
  }
}

static __global__
    __launch_bounds__(32, 1) void conv2_kernel64(const emxArray_creal32_T a,
                                                 const creal32_T b_data[1],
                                                 emxArray_creal32_T b_a)
{
  int32_T i;
  i = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (i < 1) {
    real32_T f1;
    b_a.data[0].re = 0.0F;
    b_a.data[0].im = 0.0F;
    f1 = b_data[0].re;
    b_a.data[0].re += a.data[0].re * f1 - a.data[0].im * 0.0F;
    b_a.data[0].im += a.data[0].re * 0.0F + a.data[0].im * f1;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2_kernel65(
    const emxArray_creal32_T a, const int32_T iv1, emxArray_creal32_T c)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(iv1);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    c.data[i1] = a.data[i1];
  }
}

static __global__
    __launch_bounds__(1024, 1) void conv2_kernel66(const int32_T OH,
                                                   emxArray_creal32_T expanded)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    expanded.data[i1].re = 0.0F;
    expanded.data[i1].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2_kernel67(
    const int32_T offsetH, const emxArray_int32_T y, const int32_T b_y,
    emxArray_int32_T iv1)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    int32_T q1;
    i1 = static_cast<int32_T>(idx);
    q1 = y.data[i1];
    if ((offsetH > 0) && (q1 > MAX_int32_T - offsetH)) {
      q1 = MAX_int32_T;
    } else {
      q1 += offsetH;
    }
    iv1.data[i1] = q1 - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2_kernel68(
    const emxArray_int32_T y, const int32_T b_y, emxArray_int32_T iv2)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    iv2.data[i1] = y.data[i1] - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2_kernel69(
    const emxArray_creal32_T a, const int32_T iv1_dim0,
    const emxArray_int32_T iv2, const emxArray_int32_T iv1, const int32_T b_iv1,
    const int32_T c_iv1, emxArray_creal32_T expanded, int32_T expanded_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c_iv1) + 1UL) *
                (static_cast<uint64_T>(b_iv1) + 1UL) -
            1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    int32_T q1;
    q1 = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_iv1) + 1UL));
    i1 = static_cast<int32_T>((idx - static_cast<uint64_T>(q1)) /
                              (static_cast<uint64_T>(b_iv1) + 1UL));
    expanded.data[iv1.data[q1] + expanded_dim0 * iv2.data[i1]] =
        a.data[q1 + iv1_dim0 * i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2_kernel70(
    const int32_T offsetH, const emxArray_creal32_T expanded, const int32_T k,
    const emxArray_int32_T rows, const int32_T b_rows, emxArray_creal32_T newIm,
    int32_T expanded_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_rows);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    int32_T q1;
    i1 = static_cast<int32_T>(idx);
    q1 = rows.data[i1];
    if (q1 > 2147483646 - k) {
      q1 = MAX_int32_T;
    } else {
      q1 = (k + q1) + 1;
    }
    newIm.data[i1] = expanded.data[(q1 + expanded_dim0 * offsetH) - 1];
  }
}

static __global__ __launch_bounds__(32, 1) void conv2_kernel71(
    const real32_T cv_re, const int32_T offsetH, const int32_T k,
    emxArray_creal32_T c, int32_T c_dim0)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[k + c_dim0 * offsetH].re = cv_re;
  }
}

static __global__ __launch_bounds__(32, 1) void conv2_kernel72(
    const real32_T cv_im, const int32_T offsetH, const int32_T k,
    emxArray_creal32_T c, int32_T c_dim0)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[k + c_dim0 * offsetH].im = cv_im;
  }
}

static __global__ __launch_bounds__(1024,
                                    1) void conv2_kernel81(const int32_T b,
                                                           emxArray_creal32_T c)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T orow;
    orow = static_cast<int32_T>(idx);
    c.data[orow].re = 0.0F;
    c.data[orow].im = 0.0F;
  }
}

static __global__
    __launch_bounds__(1024, 1) void conv2_kernel82(const int32_T OH,
                                                   emxArray_real32_T expanded)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T orow;
    orow = static_cast<int32_T>(idx);
    expanded.data[orow] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2_kernel83(
    const int32_T offsetH, const emxArray_int32_T y, const int32_T b_y,
    emxArray_int32_T iv1)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T orow;
    int32_T q1;
    orow = static_cast<int32_T>(idx);
    q1 = y.data[orow];
    if ((offsetH > 0) && (q1 > MAX_int32_T - offsetH)) {
      q1 = MAX_int32_T;
    } else {
      q1 += offsetH;
    }
    iv1.data[orow] = q1 - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2_kernel84(
    const emxArray_real32_T b, const emxArray_int32_T iv1, const int32_T c,
    emxArray_real32_T expanded)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T orow;
    orow = static_cast<int32_T>(idx);
    expanded.data[iv1.data[orow]] = b.data[orow];
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2_kernel85(
    const emxArray_real32_T expanded, const emxArray_int32_T rows,
    const emxArray_creal32_T a, const int32_T b, emxArray_creal32_T c,
    int32_T a_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    creal32_T b_cv;
    int32_T orow;
    orow = static_cast<int32_T>(idx);
    b_cv.re = 0.0F;
    b_cv.im = 0.0F;
    for (int32_T m{0}; m < a_dim0; m++) {
      creal32_T b_b;
      int32_T q1;
      b_b = a.data[(a_dim0 - m) - 1];
      q1 = rows.data[m];
      if (q1 > 2147483646 - orow) {
        q1 = MAX_int32_T;
      } else {
        q1 = (orow + q1) + 1;
      }
      b_cv.re += expanded.data[q1 - 1] * b_b.re;
      q1 = rows.data[m];
      if (q1 > 2147483646 - orow) {
        q1 = MAX_int32_T;
      } else {
        q1 = (orow + q1) + 1;
      }
      b_cv.im += expanded.data[q1 - 1] * b_b.im;
    }
    c.data[orow] = b_cv;
  }
}

static __global__ __launch_bounds__(1024,
                                    1) void conv2_kernel86(const int32_T b,
                                                           emxArray_creal32_T c)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T orow;
    orow = static_cast<int32_T>(idx);
    c.data[orow].re = 0.0F;
    c.data[orow].im = 0.0F;
  }
}

static __global__
    __launch_bounds__(1024, 1) void conv2_kernel87(const int32_T OH,
                                                   emxArray_creal32_T expanded)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T orow;
    orow = static_cast<int32_T>(idx);
    expanded.data[orow].re = 0.0F;
    expanded.data[orow].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2_kernel88(
    const int32_T offsetH, const emxArray_int32_T y, const int32_T b_y,
    emxArray_int32_T iv)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T orow;
    int32_T q1;
    orow = static_cast<int32_T>(idx);
    q1 = y.data[orow];
    if ((offsetH > 0) && (q1 > MAX_int32_T - offsetH)) {
      q1 = MAX_int32_T;
    } else {
      q1 += offsetH;
    }
    iv.data[orow] = q1 - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2_kernel89(
    const emxArray_creal32_T a, const emxArray_int32_T iv, const int32_T b,
    emxArray_creal32_T expanded)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T orow;
    orow = static_cast<int32_T>(idx);
    expanded.data[iv.data[orow]] = a.data[orow];
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2_kernel90(
    const emxArray_creal32_T expanded, const int32_T offsetH,
    const emxArray_int32_T rows, const int32_T b_rows, emxArray_creal32_T newIm)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_rows);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T orow;
    int32_T q1;
    orow = static_cast<int32_T>(idx);
    q1 = rows.data[orow];
    if (q1 > 2147483646 - offsetH) {
      q1 = MAX_int32_T;
    } else {
      q1 = (offsetH + q1) + 1;
    }
    newIm.data[orow] = expanded.data[q1 - 1];
  }
}

static __global__ __launch_bounds__(32, 1) void conv2_kernel91(
    const real32_T cv_im, const real32_T cv_re, const int32_T offsetH,
    emxArray_creal32_T c)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[offsetH].re = cv_re;
    c.data[offsetH].im = cv_im;
  }
}

//
//
namespace coder {
void b_conv2(const emxArray_creal32_T *cpu_a, const emxArray_real32_T *cpu_b,
             emxArray_creal32_T *cpu_c, boolean_T *c_outdatedOnCpu,
             emxArray_creal32_T *gpu_c, boolean_T *c_outdatedOnGpu)
{
  dim3 block;
  dim3 grid;
  emxArray_creal32_T b_gpu_expanded;
  emxArray_creal32_T gpu_a;
  emxArray_creal32_T gpu_newIm;
  emxArray_creal32_T *cpu_expanded;
  emxArray_creal32_T *cpu_newIm;
  emxArray_int32_T b_gpu_rows;
  emxArray_int32_T b_gpu_y;
  emxArray_int32_T gpu_iv;
  emxArray_int32_T gpu_iv1;
  emxArray_int32_T gpu_rows;
  emxArray_int32_T gpu_y;
  emxArray_int32_T *b_cpu_rows;
  emxArray_int32_T *b_cpu_y;
  emxArray_int32_T *cpu_iv;
  emxArray_int32_T *cpu_iv1;
  emxArray_int32_T *cpu_rows;
  emxArray_int32_T *cpu_y;
  emxArray_real32_T gpu_b;
  emxArray_real32_T gpu_expanded;
  emxArray_real32_T *b_cpu_expanded;
  nvtxRangePushA("#fcn#b_conv2#" MW_AT_LOCATION);
  nvtxMarkA("#gpuEmxReset_creal32_T#" MW_AT_LINE);
  gpuEmxReset_creal32_T(&gpu_newIm);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&gpu_rows);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&b_gpu_rows);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&gpu_iv1);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&gpu_iv);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&gpu_y);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&b_gpu_y);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu_expanded);
  nvtxMarkA("#gpuEmxReset_creal32_T#" MW_AT_LINE);
  gpuEmxReset_creal32_T(&b_gpu_expanded);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu_b);
  nvtxMarkA("#gpuEmxReset_creal32_T#" MW_AT_LINE);
  gpuEmxReset_creal32_T(&gpu_a);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#emxInit_creal32_T#" MW_AT_LINE);
  emxInit_creal32_T(&cpu_expanded, 1, &dh_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real32_T#" MW_AT_LINE);
  emxInit_real32_T(&b_cpu_expanded, 1, &dh_emlrtRTEI, true);
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&cpu_y, 2, &hh_emlrtRTEI, true);
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&b_cpu_y, 2, &hh_emlrtRTEI, true);
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&cpu_iv, 1, &dh_emlrtRTEI, true);
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&cpu_iv1, 1, &dh_emlrtRTEI, true);
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&cpu_rows, 2, &dh_emlrtRTEI, true);
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&b_cpu_rows, 2, &dh_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal32_T#" MW_AT_LINE);
  emxInit_creal32_T(&cpu_newIm, 1, &dh_emlrtRTEI, true);
  if ((cpu_a->size[0] == 1) && (cpu_b->size[0] == 1)) {
    int32_T k;
    k = cpu_c->size[0];
    cpu_c->size[0] = 1;
    nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
    emxEnsureCapacity_creal32_T(cpu_c, k, &eh_emlrtRTEI);
    cpu_c->data[0].re = cpu_b->data[0] * cpu_a->data[0].re;
    cpu_c->data[0].im = cpu_b->data[0] * cpu_a->data[0].im;
    *c_outdatedOnCpu = false;
    *c_outdatedOnGpu = true;
  } else if (cpu_b->size[0] > cpu_a->size[0]) {
    int32_T k;
    int32_T mc;
    boolean_T validLaunchParams;
    if (cpu_a->size[0] == 0) {
      mc = cpu_b->size[0];
    } else {
      mc = (cpu_b->size[0] + cpu_a->size[0]) - 1;
    }
    k = cpu_c->size[0];
    cpu_c->size[0] = mc;
    nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
    emxEnsureCapacity_creal32_T(cpu_c, k, &ih_emlrtRTEI);
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(mc - 1), &grid, &block,
                            2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal32_T(cpu_c, gpu_c, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#conv2_kernel81#" MW_AT_LINE);
      conv2_kernel81<<<grid, block>>>(mc - 1, *gpu_c);
    }
    *c_outdatedOnGpu = false;
    *c_outdatedOnCpu = true;
    if (cpu_a->size[0] != 0) {
      if ((cpu_b->size[0] == 1) && (cpu_a->size[0] == 1)) {
        creal32_T a;
        real32_T cv_im;
        real32_T cv_re;
        a = cpu_a->data[0];
        k = cpu_c->size[0];
        cpu_c->size[0] = 1;
        nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
        emxEnsureCapacity_creal32_T(cpu_c, k, &ih_emlrtRTEI);
        cv_im = cpu_b->data[0] * a.re;
        cv_re = cpu_b->data[0] * a.im;
        cpu_c->data[0].im = cv_re;
        cpu_c->data[0].re = cv_im;
        *c_outdatedOnCpu = false;
        *c_outdatedOnGpu = true;
      } else {
        real_T blockDims_idx_0;
        int32_T b_OH;
        int32_T n;
        int32_T offsetH;
        uint32_T OH;
        int8_T threadDims_idx_0;
        OH = (static_cast<uint32_T>(cpu_b->size[0]) +
              static_cast<uint32_T>(cpu_a->size[0])) -
             1U;
        mc = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
        blockDims_idx_0 = std::floor(
            (static_cast<real_T>(OH) + (static_cast<real_T>(mc) - 1.0)) /
            static_cast<real_T>(mc));
        threadDims_idx_0 = static_cast<int8_T>(mc);
        if (OH > 2147483647U) {
          OH = 2147483647U;
        }
        b_OH = static_cast<int32_T>(OH);
        offsetH = static_cast<int32_T>(
                      std::floor(static_cast<real_T>(cpu_a->size[0]) / 2.0)) +
                  static_cast<int32_T>(std::floor(
                      (static_cast<real_T>(cpu_a->size[0]) - 1.0) / 2.0));
        if (cpu_a->size[0] > MAX_int32_T - static_cast<int32_T>(OH)) {
          mc = MAX_int32_T;
        } else {
          mc = static_cast<int32_T>(OH) + cpu_a->size[0];
        }
        k = b_cpu_expanded->size[0];
        b_cpu_expanded->size[0] = mc - 1;
        nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
        emxEnsureCapacity_real32_T(b_cpu_expanded, k, &dh_emlrtRTEI);
        k = (static_cast<int32_T>(OH) + cpu_a->size[0]) - 2;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real32_T(b_cpu_expanded, &gpu_expanded, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#conv2_kernel82#" MW_AT_LINE);
          conv2_kernel82<<<grid, block>>>(k, gpu_expanded);
        }
        n = cpu_b->size[0];
        k = b_cpu_y->size[0] * b_cpu_y->size[1];
        b_cpu_y->size[0] = 1;
        b_cpu_y->size[1] = cpu_b->size[0];
        nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
        emxEnsureCapacity_int32_T(b_cpu_y, k, &fh_emlrtRTEI);
        b_cpu_y->data[0] = 1;
        mc = 1;
        profileLoopStart("b_conv2_loop_1", __LINE__, (n - 2) + 1, "");
        for (k = 0; k <= n - 2; k++) {
          mc++;
          b_cpu_y->data[k + 1] = mc;
        }
        profileLoopEnd();
        k = cpu_iv1->size[0];
        cpu_iv1->size[0] = b_cpu_y->size[1];
        nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
        emxEnsureCapacity_int32_T(cpu_iv1, k, &dh_emlrtRTEI);
        k = b_cpu_y->size[1] - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_int32_T(b_cpu_y, &gpu_y, false);
        nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_int32_T(cpu_iv1, &gpu_iv1, true);
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_int32_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_int32_T(&gpu_y, b_cpu_y);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#conv2_kernel83#" MW_AT_LINE);
          conv2_kernel83<<<grid, block>>>(offsetH, gpu_y, k, gpu_iv1);
        }
        mc = cpu_iv1->size[0];
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(mc - 1), &grid, &block,
                                2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_real32_T(cpu_b, &gpu_b, false);
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_b, cpu_b);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#conv2_kernel84#" MW_AT_LINE);
          conv2_kernel84<<<grid, block>>>(gpu_b, gpu_iv1, mc - 1, gpu_expanded);
        }
        n = cpu_a->size[0];
        k = b_cpu_rows->size[0] * b_cpu_rows->size[1];
        b_cpu_rows->size[0] = 1;
        b_cpu_rows->size[1] = cpu_a->size[0];
        nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
        emxEnsureCapacity_int32_T(b_cpu_rows, k, &fh_emlrtRTEI);
        b_cpu_rows->data[0] = 0;
        mc = 0;
        profileLoopStart("b_conv2_loop_3", __LINE__, (n - 2) + 1, "");
        for (k = 0; k <= n - 2; k++) {
          mc++;
          b_cpu_rows->data[k + 1] = mc;
        }
        profileLoopEnd();
        k = cpu_c->size[0];
        cpu_c->size[0] = static_cast<int32_T>(OH);
        nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
        emxEnsureCapacity_creal32_T(cpu_c, k, &dh_emlrtRTEI);
        if (blockDims_idx_0 < 4.294967296E+9) {
          OH = static_cast<uint32_T>(blockDims_idx_0);
        } else {
          OH = MAX_uint32_T;
        }
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwApplyLaunchParameters(
            computeNumIters(b_OH - 1), dim3(OH, 1U, 1U),
            dim3(static_cast<uint32_T>(threadDims_idx_0), 1U, 1U), &grid,
            &block);
        nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_int32_T(b_cpu_rows, &gpu_rows, false);
        nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_creal32_T(cpu_a, &gpu_a, false);
        nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_creal32_T(cpu_c, gpu_c, true);
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_int32_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_int32_T(&gpu_rows, b_cpu_rows);
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_creal32_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_a, cpu_a);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#conv2_kernel85#" MW_AT_LINE);
          conv2_kernel85<<<grid, block>>>(gpu_expanded, gpu_rows, gpu_a,
                                          b_OH - 1, *gpu_c, cpu_a->size[0U]);
        }
      }
    }
  } else {
    int32_T k;
    int32_T mc;
    boolean_T validLaunchParams;
    if ((cpu_a->size[0] == 0) || (cpu_b->size[0] == 0)) {
      mc = cpu_a->size[0] + cpu_b->size[0];
    } else {
      mc = (cpu_a->size[0] + cpu_b->size[0]) - 1;
    }
    k = cpu_c->size[0];
    cpu_c->size[0] = mc;
    nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
    emxEnsureCapacity_creal32_T(cpu_c, k, &ah_emlrtRTEI);
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(mc - 1), &grid, &block,
                            2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal32_T(cpu_c, gpu_c, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#conv2_kernel86#" MW_AT_LINE);
      conv2_kernel86<<<grid, block>>>(mc - 1, *gpu_c);
    }
    *c_outdatedOnGpu = false;
    *c_outdatedOnCpu = true;
    if ((cpu_a->size[0] != 0) && (cpu_b->size[0] != 0)) {
      if ((cpu_a->size[0] == 1) && (cpu_b->size[0] == 1)) {
        real32_T cv_im;
        real32_T cv_re;
        cv_re = cpu_b->data[0];
        k = cpu_c->size[0];
        cpu_c->size[0] = 1;
        nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
        emxEnsureCapacity_creal32_T(cpu_c, k, &ah_emlrtRTEI);
        cv_im = cv_re * cpu_a->data[0].re;
        cv_re *= cpu_a->data[0].im;
        cpu_c->data[0].im = cv_re;
        cpu_c->data[0].re = cv_im;
        *c_outdatedOnCpu = false;
        *c_outdatedOnGpu = true;
      } else {
        int32_T b_OH;
        int32_T n;
        int32_T offsetH;
        uint32_T OH;
        boolean_T c_needsGpuEnsureCapacity;
        boolean_T rows_needsGpuEnsureCapacity;
        boolean_T rows_outdatedOnGpu;
        OH = (static_cast<uint32_T>(cpu_a->size[0]) +
              static_cast<uint32_T>(cpu_b->size[0])) -
             1U;
        if (OH > 2147483647U) {
          OH = 2147483647U;
        }
        b_OH = static_cast<int32_T>(OH);
        offsetH = static_cast<int32_T>(
                      std::floor(static_cast<real_T>(cpu_b->size[0]) / 2.0)) +
                  static_cast<int32_T>(std::floor(
                      (static_cast<real_T>(cpu_b->size[0]) - 1.0) / 2.0));
        if (cpu_b->size[0] > MAX_int32_T - static_cast<int32_T>(OH)) {
          mc = MAX_int32_T;
        } else {
          mc = static_cast<int32_T>(OH) + cpu_b->size[0];
        }
        k = cpu_expanded->size[0];
        cpu_expanded->size[0] = mc - 1;
        nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
        emxEnsureCapacity_creal32_T(cpu_expanded, k, &dh_emlrtRTEI);
        k = (static_cast<int32_T>(OH) + cpu_b->size[0]) - 2;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_creal32_T(cpu_expanded, &b_gpu_expanded, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#conv2_kernel87#" MW_AT_LINE);
          conv2_kernel87<<<grid, block>>>(k, b_gpu_expanded);
        }
        n = cpu_a->size[0];
        k = cpu_y->size[0] * cpu_y->size[1];
        cpu_y->size[0] = 1;
        cpu_y->size[1] = cpu_a->size[0];
        nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
        emxEnsureCapacity_int32_T(cpu_y, k, &fh_emlrtRTEI);
        cpu_y->data[0] = 1;
        mc = 1;
        profileLoopStart("b_conv2_loop_0", __LINE__, (n - 2) + 1, "");
        for (k = 0; k <= n - 2; k++) {
          mc++;
          cpu_y->data[k + 1] = mc;
        }
        profileLoopEnd();
        k = cpu_iv->size[0];
        cpu_iv->size[0] = cpu_y->size[1];
        nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
        emxEnsureCapacity_int32_T(cpu_iv, k, &dh_emlrtRTEI);
        k = cpu_y->size[1] - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_int32_T(cpu_y, &b_gpu_y, false);
        nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_int32_T(cpu_iv, &gpu_iv, true);
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_int32_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_y, cpu_y);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#conv2_kernel88#" MW_AT_LINE);
          conv2_kernel88<<<grid, block>>>(offsetH, b_gpu_y, k, gpu_iv);
        }
        mc = cpu_iv->size[0];
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(mc - 1), &grid, &block,
                                2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_creal32_T(cpu_a, &gpu_a, false);
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_creal32_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_a, cpu_a);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#conv2_kernel89#" MW_AT_LINE);
          conv2_kernel89<<<grid, block>>>(gpu_a, gpu_iv, mc - 1,
                                          b_gpu_expanded);
        }
        n = cpu_b->size[0];
        k = cpu_rows->size[0] * cpu_rows->size[1];
        cpu_rows->size[0] = 1;
        cpu_rows->size[1] = cpu_b->size[0];
        nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
        emxEnsureCapacity_int32_T(cpu_rows, k, &fh_emlrtRTEI);
        cpu_rows->data[0] = 0;
        rows_outdatedOnGpu = true;
        rows_needsGpuEnsureCapacity = true;
        mc = 0;
        profileLoopStart("b_conv2_loop_2", __LINE__, (n - 2) + 1, "");
        for (k = 0; k <= n - 2; k++) {
          mc++;
          cpu_rows->data[k + 1] = mc;
        }
        profileLoopEnd();
        k = cpu_c->size[0];
        cpu_c->size[0] = static_cast<int32_T>(OH);
        nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
        emxEnsureCapacity_creal32_T(cpu_c, k, &dh_emlrtRTEI);
        c_needsGpuEnsureCapacity = true;
        mc = cpu_b->size[0];
        profileLoopStart("b_conv2_loop_4", __LINE__, (b_OH - 1) + 1, "");
        for (offsetH = 0; offsetH < b_OH; offsetH++) {
          real32_T cv_im;
          real32_T cv_re;
          boolean_T newIm_outdatedOnCpu;
          k = cpu_newIm->size[0];
          cpu_newIm->size[0] = cpu_rows->size[1];
          nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
          emxEnsureCapacity_creal32_T(cpu_newIm, k, &dh_emlrtRTEI);
          k = cpu_rows->size[1] - 1;
          nvtxMarkA("#computeNumIters#" MW_AT_LINE);
          mwGetLaunchParameters1D(computeNumIters(k), &grid, &block,
                                  2147483647U);
          if (rows_needsGpuEnsureCapacity) {
            nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
            gpuEmxEnsureCapacity_int32_T(cpu_rows, &b_gpu_rows,
                                         !rows_outdatedOnGpu);
          }
          rows_needsGpuEnsureCapacity = false;
          nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
          gpuEmxEnsureCapacity_creal32_T(cpu_newIm, &gpu_newIm, true);
          if (rows_outdatedOnGpu) {
            nvtxMarkA("#gpuEmxMemcpyCpuToGpu_int32_T#" MW_AT_LINE);
            gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_rows, cpu_rows);
          }
          rows_outdatedOnGpu = false;
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            nvtxMarkA("#conv2_kernel90#" MW_AT_LINE);
            conv2_kernel90<<<grid, block>>>(b_gpu_expanded, offsetH, b_gpu_rows,
                                            k, gpu_newIm);
          }
          newIm_outdatedOnCpu = true;
          cv_re = 0.0F;
          cv_im = 0.0F;
          profileLoopStart("b_conv2_loop_5", __LINE__, (mc - 1) + 1, "");
          for (n = 0; n < mc; n++) {
            if (newIm_outdatedOnCpu) {
              nvtxMarkA("#gpuEmxMemcpyGpuToCpu_creal32_T#" MW_AT_LINE);
              gpuEmxMemcpyGpuToCpu_creal32_T(cpu_newIm, &gpu_newIm);
            }
            cv_re +=
                cpu_newIm->data[n].re * cpu_b->data[(cpu_b->size[0] - n) - 1];
            newIm_outdatedOnCpu = false;
            cv_im +=
                cpu_newIm->data[n].im * cpu_b->data[(cpu_b->size[0] - n) - 1];
          }
          profileLoopEnd();
          if (c_needsGpuEnsureCapacity) {
            nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
            gpuEmxEnsureCapacity_creal32_T(cpu_c, gpu_c, true);
          }
          c_needsGpuEnsureCapacity = false;
          nvtxMarkA("#conv2_kernel91#" MW_AT_LINE);
          conv2_kernel91<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
              cv_im, cv_re, offsetH, *gpu_c);
        }
        profileLoopEnd();
      }
    }
  }
  nvtxMarkA("#emxFree_creal32_T#" MW_AT_LINE);
  emxFree_creal32_T(&cpu_newIm);
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&b_cpu_rows);
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&cpu_rows);
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&cpu_iv1);
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&cpu_iv);
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&b_cpu_y);
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&cpu_y);
  nvtxMarkA("#emxFree_real32_T#" MW_AT_LINE);
  emxFree_real32_T(&b_cpu_expanded);
  nvtxMarkA("#emxFree_creal32_T#" MW_AT_LINE);
  emxFree_creal32_T(&cpu_expanded);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#gpuEmxFree_creal32_T#" MW_AT_LINE);
  gpuEmxFree_creal32_T(&gpu_a);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu_b);
  nvtxMarkA("#gpuEmxFree_creal32_T#" MW_AT_LINE);
  gpuEmxFree_creal32_T(&b_gpu_expanded);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu_expanded);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&b_gpu_y);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&gpu_y);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&gpu_iv);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&gpu_iv1);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&b_gpu_rows);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&gpu_rows);
  nvtxMarkA("#gpuEmxFree_creal32_T#" MW_AT_LINE);
  gpuEmxFree_creal32_T(&gpu_newIm);
  nvtxRangePop();
}

//
//
void conv2(const emxArray_creal32_T *cpu_a, emxArray_real32_T *cpu_b,
           boolean_T *b_outdatedOnCpu, emxArray_real32_T *gpu_b,
           boolean_T *b_outdatedOnGpu, emxArray_creal32_T *cpu_c,
           boolean_T *c_outdatedOnCpu, emxArray_creal32_T *gpu_c,
           boolean_T *c_outdatedOnGpu)
{
  dim3 block;
  dim3 grid;
  emxArray_creal32_T b_gpu_a;
  emxArray_creal32_T b_gpu_c;
  emxArray_creal32_T b_gpu_expanded;
  emxArray_creal32_T c_gpu_a;
  emxArray_creal32_T gpu_a;
  emxArray_creal32_T gpu_expanded;
  emxArray_creal32_T gpu_newIm;
  emxArray_creal32_T *b_cpu_a;
  emxArray_creal32_T *b_cpu_c;
  emxArray_creal32_T *b_cpu_expanded;
  emxArray_creal32_T *c_cpu_a;
  emxArray_creal32_T *cpu_expanded;
  emxArray_creal32_T *cpu_newIm;
  emxArray_int32_T b_gpu_y;
  emxArray_int32_T c_gpu_y;
  emxArray_int32_T gpu_iv;
  emxArray_int32_T gpu_iv1;
  emxArray_int32_T gpu_iv2;
  emxArray_int32_T gpu_rows;
  emxArray_int32_T gpu_y;
  emxArray_int32_T *b_cpu_y;
  emxArray_int32_T *c_cpu_y;
  emxArray_int32_T *cpu_iv;
  emxArray_int32_T *cpu_iv1;
  emxArray_int32_T *cpu_iv2;
  emxArray_int32_T *cpu_rows;
  emxArray_int32_T *cpu_y;
  creal32_T(*gpu_b_data)[1];
  real32_T *gpu_cv_re;
  real32_T *gpu_f;
  boolean_T a_outdatedOnGpu;
  nvtxRangePushA("#fcn#conv2#" MW_AT_LOCATION);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaMalloc#" MW_AT_LINE);
  checkCudaError(mwCudaMalloc(&gpu_cv_re, 4UL), __FILE__, __LINE__);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaMalloc#" MW_AT_LINE);
  checkCudaError(mwCudaMalloc(&gpu_f, 4UL), __FILE__, __LINE__);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaMalloc#" MW_AT_LINE);
  checkCudaError(mwCudaMalloc(&gpu_b_data, 8UL), __FILE__, __LINE__);
  nvtxMarkA("#gpuEmxReset_creal32_T#" MW_AT_LINE);
  gpuEmxReset_creal32_T(&c_gpu_a);
  nvtxMarkA("#gpuEmxReset_creal32_T#" MW_AT_LINE);
  gpuEmxReset_creal32_T(&gpu_newIm);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&gpu_rows);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&gpu_iv2);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&c_gpu_y);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&gpu_iv1);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&gpu_iv);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&b_gpu_y);
  nvtxMarkA("#gpuEmxReset_creal32_T#" MW_AT_LINE);
  gpuEmxReset_creal32_T(&b_gpu_expanded);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&gpu_y);
  nvtxMarkA("#gpuEmxReset_creal32_T#" MW_AT_LINE);
  gpuEmxReset_creal32_T(&gpu_expanded);
  nvtxMarkA("#gpuEmxReset_creal32_T#" MW_AT_LINE);
  gpuEmxReset_creal32_T(&b_gpu_a);
  nvtxMarkA("#gpuEmxReset_creal32_T#" MW_AT_LINE);
  gpuEmxReset_creal32_T(&b_gpu_c);
  nvtxMarkA("#gpuEmxReset_creal32_T#" MW_AT_LINE);
  gpuEmxReset_creal32_T(&gpu_a);
  a_outdatedOnGpu = true;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#emxInit_creal32_T#" MW_AT_LINE);
  emxInit_creal32_T(&b_cpu_c, 1, &gh_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal32_T#" MW_AT_LINE);
  emxInit_creal32_T(&b_cpu_a, 1, &xg_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal32_T#" MW_AT_LINE);
  emxInit_creal32_T(&cpu_expanded, 1, &dh_emlrtRTEI, true);
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&cpu_y, 2, &hh_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal32_T#" MW_AT_LINE);
  emxInit_creal32_T(&b_cpu_expanded, 2, &dh_emlrtRTEI, true);
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&b_cpu_y, 2, &hh_emlrtRTEI, true);
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&cpu_iv, 1, &dh_emlrtRTEI, true);
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&cpu_iv1, 1, &dh_emlrtRTEI, true);
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&c_cpu_y, 2, &hh_emlrtRTEI, true);
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&cpu_iv2, 1, &dh_emlrtRTEI, true);
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&cpu_rows, 2, &dh_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal32_T#" MW_AT_LINE);
  emxInit_creal32_T(&cpu_newIm, 1, &dh_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal32_T#" MW_AT_LINE);
  emxInit_creal32_T(&c_cpu_a, 1, &ch_emlrtRTEI, true);
  if ((cpu_a->size[0] == 1) && (cpu_b->size[0] == 1)) {
    if (cpu_a->size[1] < 1) {
      int32_T i;
      i = cpu_c->size[0] * cpu_c->size[1];
      cpu_c->size[0] = 1;
      cpu_c->size[1] = 1;
      nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
      emxEnsureCapacity_creal32_T(cpu_c, i, &yg_emlrtRTEI);
      cpu_c->data[0].im = 0.0F;
      cpu_c->data[0].re = 0.0F;
      *c_outdatedOnCpu = false;
      *c_outdatedOnGpu = true;
    } else {
      int32_T i;
      real32_T cv_im;
      boolean_T validLaunchParams;
      i = b_cpu_a->size[0];
      b_cpu_a->size[0] = cpu_a->size[1];
      nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
      emxEnsureCapacity_creal32_T(b_cpu_a, i, &xg_emlrtRTEI);
      i = cpu_a->size[1] - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal32_T(cpu_a, &gpu_a, false);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal32_T(b_cpu_a, &b_gpu_a, true);
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_creal32_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_a, cpu_a);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#conv2_kernel52#" MW_AT_LINE);
        conv2_kernel52<<<grid, block>>>(gpu_a, i, b_gpu_a, cpu_a->size[0U]);
      }
      if (*b_outdatedOnCpu) {
        nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LINE);
        gpuEmxMemcpyGpuToCpu_real32_T(cpu_b, gpu_b);
      }
      *b_outdatedOnCpu = false;
      cv_im = cpu_b->data[0];
      i = b_cpu_c->size[0];
      b_cpu_c->size[0] = b_cpu_a->size[0];
      nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
      emxEnsureCapacity_creal32_T(b_cpu_c, i, &bh_emlrtRTEI);
      i = b_cpu_a->size[0] - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal32_T(b_cpu_c, &b_gpu_c, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#conv2_kernel53#" MW_AT_LINE);
        conv2_kernel53<<<grid, block>>>(i, b_gpu_c);
      }
      if (b_cpu_a->size[0] == 1) {
        cv_im = cpu_b->data[0];
        i = b_cpu_c->size[0];
        b_cpu_c->size[0] = 1;
        nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
        emxEnsureCapacity_creal32_T(b_cpu_c, i, &bh_emlrtRTEI);
        nvtxMarkA("#conv2_kernel54#" MW_AT_LINE);
        conv2_kernel54<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
            b_gpu_a, cv_im, gpu_f, gpu_cv_re);
        nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_creal32_T(b_cpu_c, &b_gpu_c, true);
        nvtxMarkA("#conv2_kernel55#" MW_AT_LINE);
        conv2_kernel55<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_cv_re,
                                                                gpu_f, b_gpu_c);
      } else {
        int32_T b_OH;
        int32_T mc;
        int32_T nc;
        int32_T offsetH;
        int8_T threadDims_idx_0;
        nc = static_cast<int32_T>(std::fmin(
            32.0, (static_cast<real_T>(b_cpu_a->size[0]) + 1.0) - 1.0));
        offsetH = static_cast<int32_T>(std::floor(
            (static_cast<real_T>(static_cast<uint32_T>(b_cpu_a->size[0]) +
                                 static_cast<uint32_T>(nc)) -
             1.0) /
            static_cast<real_T>(nc)));
        threadDims_idx_0 = static_cast<int8_T>(nc);
        b_OH = b_cpu_a->size[0];
        if (b_cpu_a->size[0] > 2147483646) {
          mc = MAX_int32_T;
        } else {
          mc = b_cpu_a->size[0] + 1;
        }
        i = cpu_expanded->size[0];
        cpu_expanded->size[0] = mc - 1;
        nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
        emxEnsureCapacity_creal32_T(cpu_expanded, i, &dh_emlrtRTEI);
        i = b_cpu_a->size[0] - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_creal32_T(cpu_expanded, &gpu_expanded, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#conv2_kernel57#" MW_AT_LINE);
          conv2_kernel57<<<grid, block>>>(i, gpu_expanded);
        }
        nc = b_cpu_a->size[0];
        i = cpu_y->size[0] * cpu_y->size[1];
        cpu_y->size[0] = 1;
        cpu_y->size[1] = b_cpu_a->size[0];
        nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
        emxEnsureCapacity_int32_T(cpu_y, i, &fh_emlrtRTEI);
        cpu_y->data[0] = 1;
        mc = 1;
        profileLoopStart("conv2_loop_0", __LINE__, (nc - 2) + 1, "");
        for (int32_T k{0}; k <= nc - 2; k++) {
          mc++;
          cpu_y->data[k + 1] = mc;
        }
        profileLoopEnd();
        i = cpu_iv->size[0];
        cpu_iv->size[0] = cpu_y->size[1];
        nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
        emxEnsureCapacity_int32_T(cpu_iv, i, &dh_emlrtRTEI);
        i = cpu_y->size[1] - 1;
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
        nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_int32_T(cpu_y, &gpu_y, false);
        nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_int32_T(cpu_iv, &gpu_iv, true);
        nvtxMarkA("#gpuEmxMemcpyCpuToGpu_int32_T#" MW_AT_LINE);
        gpuEmxMemcpyCpuToGpu_int32_T(&gpu_y, cpu_y);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#conv2_kernel58#" MW_AT_LINE);
          conv2_kernel58<<<grid, block>>>(gpu_y, i, gpu_iv);
        }
        mc = cpu_iv->size[0];
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwGetLaunchParameters1D(computeNumIters(mc - 1), &grid, &block,
                                2147483647U);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#conv2_kernel59#" MW_AT_LINE);
          conv2_kernel59<<<grid, block>>>(b_gpu_a, gpu_iv, mc - 1,
                                          gpu_expanded);
        }
        i = b_cpu_c->size[0];
        b_cpu_c->size[0] = b_cpu_a->size[0];
        nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
        emxEnsureCapacity_creal32_T(b_cpu_c, i, &dh_emlrtRTEI);
        nvtxMarkA("#computeNumIters#" MW_AT_LINE);
        mwApplyLaunchParameters(
            computeNumIters(b_OH - 1),
            dim3(static_cast<uint32_T>(offsetH), 1U, 1U),
            dim3(static_cast<uint32_T>(threadDims_idx_0), 1U, 1U), &grid,
            &block);
        nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
        gpuEmxEnsureCapacity_creal32_T(b_cpu_c, &b_gpu_c, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          nvtxMarkA("#conv2_kernel60#" MW_AT_LINE);
          conv2_kernel60<<<grid, block>>>(gpu_expanded, cv_im, b_OH - 1,
                                          b_gpu_c);
        }
      }
      i = cpu_c->size[0] * cpu_c->size[1];
      cpu_c->size[0] = 1;
      cpu_c->size[1] = b_cpu_c->size[0];
      nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
      emxEnsureCapacity_creal32_T(cpu_c, i, &eh_emlrtRTEI);
      i = b_cpu_c->size[0] - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal32_T(cpu_c, gpu_c, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#conv2_kernel56#" MW_AT_LINE);
        conv2_kernel56<<<grid, block>>>(b_gpu_c, i, *gpu_c, cpu_c->size[0U]);
      }
      *c_outdatedOnGpu = false;
      *c_outdatedOnCpu = true;
    }
  } else if (cpu_b->size[0] > cpu_a->size[0]) {
    nvtxMarkA("#conv2NonSeparable#" MW_AT_LINE);
    conv2NonSeparable(cpu_b, b_outdatedOnCpu, gpu_b, b_outdatedOnGpu,
                      (emxArray_creal32_T *)cpu_a, &gpu_a, &a_outdatedOnGpu,
                      cpu_c, c_outdatedOnCpu, gpu_c, c_outdatedOnGpu);
  } else {
    int32_T i;
    int32_T mc;
    int32_T nc;
    boolean_T validLaunchParams;
    if ((cpu_a->size[0] == 0) || (cpu_b->size[0] == 0)) {
      mc = cpu_a->size[0] + cpu_b->size[0];
    } else {
      mc = (cpu_a->size[0] + cpu_b->size[0]) - 1;
    }
    if (cpu_a->size[1] == 0) {
      nc = 1;
    } else {
      nc = cpu_a->size[1];
    }
    i = cpu_c->size[0] * cpu_c->size[1];
    cpu_c->size[0] = mc;
    cpu_c->size[1] = nc;
    nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
    emxEnsureCapacity_creal32_T(cpu_c, i, &ah_emlrtRTEI);
    i = mc * nc - 1;
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
    nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal32_T(cpu_c, gpu_c, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#conv2_kernel61#" MW_AT_LINE);
      conv2_kernel61<<<grid, block>>>(i, *gpu_c);
    }
    *c_outdatedOnGpu = false;
    *c_outdatedOnCpu = true;
    if ((cpu_a->size[0] == 0) || (cpu_a->size[1] == 0) ||
        (cpu_b->size[0] == 0)) {
      i = cpu_c->size[0] * cpu_c->size[1];
      cpu_c->size[0] = mc;
      cpu_c->size[1] = nc;
      nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
      emxEnsureCapacity_creal32_T(cpu_c, i, &ah_emlrtRTEI);
      i = mc * nc - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal32_T(cpu_c, gpu_c, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#conv2_kernel62#" MW_AT_LINE);
        conv2_kernel62<<<grid, block>>>(i, *gpu_c);
      }
    } else if ((cpu_a->size[0] == 1) && (cpu_a->size[1] == 1) &&
               (cpu_b->size[0] == 1)) {
      real32_T cpu_cv_re;
      if (*b_outdatedOnCpu) {
        nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LINE);
        gpuEmxMemcpyGpuToCpu_real32_T(cpu_b, gpu_b);
      }
      *b_outdatedOnCpu = false;
      cpu_cv_re = cpu_b->data[0];
      nvtxMarkA("#conv2_kernel63#" MW_AT_LINE);
      conv2_kernel63<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(cpu_cv_re,
                                                              *gpu_b_data);
      i = c_cpu_a->size[0];
      c_cpu_a->size[0] = 1;
      nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
      emxEnsureCapacity_creal32_T(c_cpu_a, i, &ch_emlrtRTEI);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal32_T(cpu_a, &gpu_a, false);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal32_T(c_cpu_a, &c_gpu_a, true);
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_creal32_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_a, cpu_a);
      nvtxMarkA("#conv2_kernel64#" MW_AT_LINE);
      conv2_kernel64<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
          gpu_a, *gpu_b_data, c_gpu_a);
      i = cpu_c->size[0] * cpu_c->size[1];
      cpu_c->size[0] = mc;
      cpu_c->size[1] = nc;
      nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
      emxEnsureCapacity_creal32_T(cpu_c, i, &ah_emlrtRTEI);
      i = mc * nc - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal32_T(cpu_c, gpu_c, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#conv2_kernel65#" MW_AT_LINE);
        conv2_kernel65<<<grid, block>>>(c_gpu_a, i, *gpu_c);
      }
    } else {
      int32_T iv1[2];
      int32_T OW;
      int32_T b_OH;
      int32_T offsetH;
      uint32_T OH;
      boolean_T a_outdatedOnCpu;
      boolean_T c_needsGpuEnsureCapacity;
      OH = (static_cast<uint32_T>(cpu_a->size[0]) +
            static_cast<uint32_T>(cpu_b->size[0])) -
           1U;
      OW = cpu_a->size[1];
      if (OH > 2147483647U) {
        OH = 2147483647U;
      }
      b_OH = static_cast<int32_T>(OH);
      offsetH = static_cast<int32_T>(
                    std::floor(static_cast<real_T>(cpu_b->size[0]) / 2.0)) +
                static_cast<int32_T>(std::floor(
                    (static_cast<real_T>(cpu_b->size[0]) - 1.0) / 2.0));
      if (cpu_b->size[0] > MAX_int32_T - static_cast<int32_T>(OH)) {
        mc = MAX_int32_T;
      } else {
        mc = static_cast<int32_T>(OH) + cpu_b->size[0];
      }
      i = b_cpu_expanded->size[0] * b_cpu_expanded->size[1];
      b_cpu_expanded->size[0] = mc - 1;
      nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
      emxEnsureCapacity_creal32_T(b_cpu_expanded, i, &dh_emlrtRTEI);
      if (cpu_a->size[1] > 2147483646) {
        mc = MAX_int32_T;
      } else {
        mc = cpu_a->size[1] + 1;
      }
      i = b_cpu_expanded->size[0] * b_cpu_expanded->size[1];
      b_cpu_expanded->size[1] = mc - 1;
      nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
      emxEnsureCapacity_creal32_T(b_cpu_expanded, i, &dh_emlrtRTEI);
      i = ((static_cast<int32_T>(OH) + cpu_b->size[0]) - 1) * cpu_a->size[1] -
          1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal32_T(b_cpu_expanded, &b_gpu_expanded, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#conv2_kernel66#" MW_AT_LINE);
        conv2_kernel66<<<grid, block>>>(i, b_gpu_expanded);
      }
      nc = cpu_a->size[0];
      i = b_cpu_y->size[0] * b_cpu_y->size[1];
      b_cpu_y->size[0] = 1;
      b_cpu_y->size[1] = cpu_a->size[0];
      nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
      emxEnsureCapacity_int32_T(b_cpu_y, i, &fh_emlrtRTEI);
      b_cpu_y->data[0] = 1;
      mc = 1;
      profileLoopStart("conv2_loop_1", __LINE__, (nc - 2) + 1, "");
      for (int32_T k{0}; k <= nc - 2; k++) {
        mc++;
        b_cpu_y->data[k + 1] = mc;
      }
      profileLoopEnd();
      i = cpu_iv1->size[0];
      cpu_iv1->size[0] = b_cpu_y->size[1];
      nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
      emxEnsureCapacity_int32_T(cpu_iv1, i, &dh_emlrtRTEI);
      i = b_cpu_y->size[1] - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_int32_T(b_cpu_y, &b_gpu_y, false);
      nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_int32_T(cpu_iv1, &gpu_iv1, true);
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_int32_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_y, b_cpu_y);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#conv2_kernel67#" MW_AT_LINE);
        conv2_kernel67<<<grid, block>>>(offsetH, b_gpu_y, i, gpu_iv1);
      }
      nc = cpu_a->size[1];
      i = c_cpu_y->size[0] * c_cpu_y->size[1];
      c_cpu_y->size[0] = 1;
      c_cpu_y->size[1] = cpu_a->size[1];
      nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
      emxEnsureCapacity_int32_T(c_cpu_y, i, &fh_emlrtRTEI);
      c_cpu_y->data[0] = 1;
      mc = 1;
      profileLoopStart("conv2_loop_2", __LINE__, (nc - 2) + 1, "");
      for (int32_T k{0}; k <= nc - 2; k++) {
        mc++;
        c_cpu_y->data[k + 1] = mc;
      }
      profileLoopEnd();
      i = cpu_iv2->size[0];
      cpu_iv2->size[0] = c_cpu_y->size[1];
      nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
      emxEnsureCapacity_int32_T(cpu_iv2, i, &dh_emlrtRTEI);
      i = c_cpu_y->size[1] - 1;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_int32_T(c_cpu_y, &c_gpu_y, false);
      nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_int32_T(cpu_iv2, &gpu_iv2, true);
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_int32_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_int32_T(&c_gpu_y, c_cpu_y);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#conv2_kernel68#" MW_AT_LINE);
        conv2_kernel68<<<grid, block>>>(c_gpu_y, i, gpu_iv2);
      }
      iv1[0] = cpu_iv1->size[0];
      iv1[1] = cpu_iv2->size[0];
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      mwGetLaunchParameters1D(computeNumIters(iv1[1] - 1, iv1[0] - 1), &grid,
                              &block, 2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_creal32_T(cpu_a, &gpu_a, false);
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_creal32_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_a, cpu_a);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#conv2_kernel69#" MW_AT_LINE);
        conv2_kernel69<<<grid, block>>>(gpu_a, iv1[0], gpu_iv2, gpu_iv1,
                                        iv1[0] - 1, iv1[1] - 1, b_gpu_expanded,
                                        b_cpu_expanded->size[0U]);
      }
      nc = cpu_b->size[0];
      i = cpu_rows->size[0] * cpu_rows->size[1];
      cpu_rows->size[0] = 1;
      cpu_rows->size[1] = cpu_b->size[0];
      nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
      emxEnsureCapacity_int32_T(cpu_rows, i, &fh_emlrtRTEI);
      cpu_rows->data[0] = 0;
      a_outdatedOnCpu = true;
      a_outdatedOnGpu = true;
      mc = 0;
      profileLoopStart("conv2_loop_3", __LINE__, (nc - 2) + 1, "");
      for (int32_T k{0}; k <= nc - 2; k++) {
        mc++;
        cpu_rows->data[k + 1] = mc;
      }
      profileLoopEnd();
      i = cpu_c->size[0] * cpu_c->size[1];
      cpu_c->size[0] = static_cast<int32_T>(OH);
      cpu_c->size[1] = cpu_a->size[1];
      nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
      emxEnsureCapacity_creal32_T(cpu_c, i, &dh_emlrtRTEI);
      c_needsGpuEnsureCapacity = true;
      mc = cpu_b->size[0];
      profileLoopStart("conv2_loop_4", __LINE__, (OW - 1) + 1, "");
      for (offsetH = 0; offsetH < OW; offsetH++) {
        profileLoopStart("conv2_loop_5", __LINE__, (b_OH - 1) + 1, "");
        for (int32_T k{0}; k < b_OH; k++) {
          real32_T cpu_cv_re;
          real32_T cv_im;
          boolean_T newIm_outdatedOnCpu;
          i = cpu_newIm->size[0];
          cpu_newIm->size[0] = cpu_rows->size[1];
          nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
          emxEnsureCapacity_creal32_T(cpu_newIm, i, &dh_emlrtRTEI);
          i = cpu_rows->size[1] - 1;
          nvtxMarkA("#computeNumIters#" MW_AT_LINE);
          mwGetLaunchParameters1D(computeNumIters(i), &grid, &block,
                                  2147483647U);
          if (a_outdatedOnGpu) {
            nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
            gpuEmxEnsureCapacity_int32_T(cpu_rows, &gpu_rows, !a_outdatedOnCpu);
          }
          a_outdatedOnGpu = false;
          nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
          gpuEmxEnsureCapacity_creal32_T(cpu_newIm, &gpu_newIm, true);
          if (a_outdatedOnCpu) {
            nvtxMarkA("#gpuEmxMemcpyCpuToGpu_int32_T#" MW_AT_LINE);
            gpuEmxMemcpyCpuToGpu_int32_T(&gpu_rows, cpu_rows);
          }
          a_outdatedOnCpu = false;
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            nvtxMarkA("#conv2_kernel70#" MW_AT_LINE);
            conv2_kernel70<<<grid, block>>>(offsetH, b_gpu_expanded, k,
                                            gpu_rows, i, gpu_newIm,
                                            b_cpu_expanded->size[0U]);
          }
          newIm_outdatedOnCpu = true;
          cpu_cv_re = 0.0F;
          cv_im = 0.0F;
          profileLoopStart("conv2_loop_6", __LINE__, (mc - 1) + 1, "");
          for (nc = 0; nc < mc; nc++) {
            if (newIm_outdatedOnCpu) {
              nvtxMarkA("#gpuEmxMemcpyGpuToCpu_creal32_T#" MW_AT_LINE);
              gpuEmxMemcpyGpuToCpu_creal32_T(cpu_newIm, &gpu_newIm);
            }
            if (*b_outdatedOnCpu) {
              nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real32_T#" MW_AT_LINE);
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_b, gpu_b);
            }
            cpu_cv_re +=
                cpu_newIm->data[nc].re * cpu_b->data[(cpu_b->size[0] - nc) - 1];
            newIm_outdatedOnCpu = false;
            *b_outdatedOnCpu = false;
            cv_im +=
                cpu_newIm->data[nc].im * cpu_b->data[(cpu_b->size[0] - nc) - 1];
          }
          profileLoopEnd();
          if (c_needsGpuEnsureCapacity) {
            nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
            gpuEmxEnsureCapacity_creal32_T(cpu_c, gpu_c, true);
          }
          nvtxMarkA("#conv2_kernel71#" MW_AT_LINE);
          conv2_kernel71<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
              cpu_cv_re, offsetH, k, *gpu_c, cpu_c->size[0U]);
          c_needsGpuEnsureCapacity = false;
          nvtxMarkA("#conv2_kernel72#" MW_AT_LINE);
          conv2_kernel72<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
              cv_im, offsetH, k, *gpu_c, cpu_c->size[0U]);
        }
        profileLoopEnd();
      }
      profileLoopEnd();
    }
  }
  nvtxMarkA("#emxFree_creal32_T#" MW_AT_LINE);
  emxFree_creal32_T(&c_cpu_a);
  nvtxMarkA("#emxFree_creal32_T#" MW_AT_LINE);
  emxFree_creal32_T(&cpu_newIm);
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&cpu_rows);
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&cpu_iv2);
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&c_cpu_y);
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&cpu_iv1);
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&cpu_iv);
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&b_cpu_y);
  nvtxMarkA("#emxFree_creal32_T#" MW_AT_LINE);
  emxFree_creal32_T(&b_cpu_expanded);
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&cpu_y);
  nvtxMarkA("#emxFree_creal32_T#" MW_AT_LINE);
  emxFree_creal32_T(&cpu_expanded);
  nvtxMarkA("#emxFree_creal32_T#" MW_AT_LINE);
  emxFree_creal32_T(&b_cpu_a);
  nvtxMarkA("#emxFree_creal32_T#" MW_AT_LINE);
  emxFree_creal32_T(&b_cpu_c);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#gpuEmxFree_creal32_T#" MW_AT_LINE);
  gpuEmxFree_creal32_T(&gpu_a);
  nvtxMarkA("#gpuEmxFree_creal32_T#" MW_AT_LINE);
  gpuEmxFree_creal32_T(&b_gpu_c);
  nvtxMarkA("#gpuEmxFree_creal32_T#" MW_AT_LINE);
  gpuEmxFree_creal32_T(&b_gpu_a);
  nvtxMarkA("#gpuEmxFree_creal32_T#" MW_AT_LINE);
  gpuEmxFree_creal32_T(&gpu_expanded);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&gpu_y);
  nvtxMarkA("#gpuEmxFree_creal32_T#" MW_AT_LINE);
  gpuEmxFree_creal32_T(&b_gpu_expanded);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&b_gpu_y);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&gpu_iv);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&gpu_iv1);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&c_gpu_y);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&gpu_iv2);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&gpu_rows);
  nvtxMarkA("#gpuEmxFree_creal32_T#" MW_AT_LINE);
  gpuEmxFree_creal32_T(&gpu_newIm);
  nvtxMarkA("#gpuEmxFree_creal32_T#" MW_AT_LINE);
  gpuEmxFree_creal32_T(&c_gpu_a);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaFree#" MW_AT_LINE);
  checkCudaError(mwCudaFree(*gpu_b_data), __FILE__, __LINE__);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaFree#" MW_AT_LINE);
  checkCudaError(mwCudaFree(gpu_f), __FILE__, __LINE__);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaFree#" MW_AT_LINE);
  checkCudaError(mwCudaFree(gpu_cv_re), __FILE__, __LINE__);
  nvtxRangePop();
}

} // namespace coder

// End of code generation (conv2.cu)
