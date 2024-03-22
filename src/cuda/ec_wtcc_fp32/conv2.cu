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
#include "ec_wtcc_data.h"
#include "ec_wtcc_emxutil.h"
#include "ec_wtcc_mexutil.h"
#include "ec_wtcc_types.h"
#include "rt_nonfinite.h"
#include "MWCUBLASUtils.hpp"
#include "MWCudaDimUtility.hpp"
#include "MWCudaMemoryFunctions.hpp"
#include "MWErrorCodeUtils.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include <cmath>

// Variable Definitions
static emlrtRTEInfo wf_emlrtRTEI{
    56,                                                               // lineNo
    5,                                                                // colNo
    "conv2",                                                          // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/conv2.m" // pName
};

static emlrtRTEInfo xf_emlrtRTEI{
    47,                                                               // lineNo
    9,                                                                // colNo
    "conv2",                                                          // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/conv2.m" // pName
};

static emlrtRTEInfo ag_emlrtRTEI{
    49,                                                               // lineNo
    9,                                                                // colNo
    "conv2",                                                          // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/conv2.m" // pName
};

static emlrtRTEInfo
    fg_emlrtRTEI{
        158,      // lineNo
        24,       // colNo
        "mtimes", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+blas/"
        "mtimes.m" // pName
    };

static emlrtRTEInfo gg_emlrtRTEI{
    1,                  // lineNo
    1,                  // colNo
    "gpu_conv2_kernel", // fName
    "/usr/local/MATLAB/R2024a/toolbox/gpucoder/gpucoder/+coder/+internal/"
    "+images/gpu_conv2_kernel.p" // pName
};

static emlrtRTEInfo jg_emlrtRTEI{
    58,                                                               // lineNo
    5,                                                                // colNo
    "conv2",                                                          // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/conv2.m" // pName
};

// Function Declarations
namespace coder {
static void
b_conv2NonSeparable(emxArray_real32_T *cpu_a, boolean_T *a_outdatedOnCpu,
                    emxArray_real32_T *gpu_a, boolean_T *a_outdatedOnGpu,
                    emxArray_real32_T *cpu_b, boolean_T *b_outdatedOnCpu,
                    emxArray_real32_T *gpu_b, boolean_T *b_outdatedOnGpu,
                    emxArray_real32_T *cpu_c, boolean_T *c_outdatedOnCpu,
                    emxArray_real32_T *gpu_c, boolean_T *c_outdatedOnGpu);

static void
c_conv2NonSeparable(emxArray_creal32_T *cpu_a, emxArray_creal32_T *gpu_a,
                    boolean_T *a_outdatedOnGpu, const emxArray_real32_T *b,
                    emxArray_creal32_T *cpu_c, boolean_T *c_outdatedOnCpu,
                    emxArray_creal32_T *gpu_c, boolean_T *c_outdatedOnGpu);

static void
conv2NonSeparable(emxArray_real32_T *cpu_a, emxArray_real32_T *gpu_a,
                  boolean_T *a_outdatedOnGpu, emxArray_real32_T *cpu_b,
                  emxArray_real32_T *gpu_b, boolean_T *b_outdatedOnGpu,
                  emxArray_real32_T *cpu_c, boolean_T *c_outdatedOnCpu,
                  emxArray_real32_T *gpu_c, boolean_T *c_outdatedOnGpu);

} // namespace coder
static __global__ void conv2NonSeparable_kernel121(const int32_T b,
                                                   emxArray_creal32_T c);

static __global__ void conv2NonSeparable_kernel122(const int32_T b,
                                                   emxArray_creal32_T c);

static __global__ void conv2NonSeparable_kernel123(const real32_T cv_re,
                                                   creal32_T b_data[1]);

static __global__ void conv2NonSeparable_kernel124(const emxArray_creal32_T a,
                                                   const creal32_T b_data[1],
                                                   emxArray_creal32_T b_a);

static __global__ void conv2NonSeparable_kernel125(const emxArray_creal32_T a,
                                                   const int32_T iv,
                                                   emxArray_creal32_T c);

static __global__ void conv2NonSeparable_kernel126(const int32_T OH,
                                                   emxArray_creal32_T expanded);

static __global__ void conv2NonSeparable_kernel127(const int32_T offsetH,
                                                   const emxArray_int32_T y,
                                                   const int32_T b_y,
                                                   emxArray_int32_T iv);

static __global__ void conv2NonSeparable_kernel128(const emxArray_int32_T y,
                                                   const int32_T b_y,
                                                   emxArray_int32_T iv1);

static __global__ void conv2NonSeparable_kernel129(
    const emxArray_creal32_T a, const int32_T iv_dim0,
    const emxArray_int32_T iv1, const emxArray_int32_T iv, const int32_T b_iv,
    const int32_T c_iv, emxArray_creal32_T expanded, int32_T expanded_dim0);

static __global__ void
conv2NonSeparable_kernel130(const int32_T offsetH,
                            const emxArray_creal32_T expanded, const int32_T k,
                            const emxArray_int32_T rows, const int32_T b_rows,
                            emxArray_creal32_T newIm, int32_T expanded_dim0);

static __global__ void conv2NonSeparable_kernel131(const real32_T cv_re,
                                                   const int32_T offsetH,
                                                   const int32_T k,
                                                   emxArray_creal32_T c,
                                                   int32_T c_dim0);

static __global__ void conv2NonSeparable_kernel132(const real32_T cv_im,
                                                   const int32_T offsetH,
                                                   const int32_T k,
                                                   emxArray_creal32_T c,
                                                   int32_T c_dim0);

static __global__ void conv2NonSeparable_kernel59(const int32_T b,
                                                  emxArray_real32_T c);

static __global__ void conv2NonSeparable_kernel60(const int32_T b,
                                                  emxArray_real32_T c);

static __global__ void conv2NonSeparable_kernel61(const emxArray_real32_T c,
                                                  const int32_T b,
                                                  emxArray_real32_T b_c);

static __global__ void conv2NonSeparable_kernel62(const int32_T OH,
                                                  emxArray_real32_T expanded);

static __global__ void conv2NonSeparable_kernel63(const int32_T offsetH,
                                                  const emxArray_int32_T y,
                                                  const int32_T b_y,
                                                  emxArray_int32_T iv);

static __global__ void conv2NonSeparable_kernel64(const emxArray_int32_T y,
                                                  const int32_T b_y,
                                                  emxArray_int32_T iv1);

static __global__ void conv2NonSeparable_kernel65(
    const emxArray_real32_T a, const int32_T iv_dim0,
    const emxArray_int32_T iv1, const emxArray_int32_T iv, const int32_T b_iv,
    const int32_T c_iv, emxArray_real32_T expanded, int32_T expanded_dim0);

static __global__ void conv2NonSeparable_kernel66(
    const emxArray_real32_T expanded, const emxArray_int32_T rows,
    const emxArray_real32_T b, const int32_T c, const int32_T d,
    emxArray_real32_T b_c, int32_T b_dim0, int32_T expanded_dim0,
    int32_T c_dim0);

static __global__ void conv2NonSeparable_kernel67(const int32_T b,
                                                  emxArray_real32_T c);

static __global__ void conv2NonSeparable_kernel68(const int32_T OH,
                                                  emxArray_real32_T expanded);

static __global__ void conv2NonSeparable_kernel69(const int32_T offsetH,
                                                  const emxArray_int32_T y,
                                                  const int32_T b_y,
                                                  emxArray_int32_T iv);

static __global__ void conv2NonSeparable_kernel70(const emxArray_real32_T a,
                                                  const emxArray_int32_T iv,
                                                  const int32_T b,
                                                  emxArray_real32_T expanded);

static __global__ void
conv2NonSeparable_kernel71(const emxArray_real32_T expanded,
                           const emxArray_int32_T rows,
                           const emxArray_real32_T b, const int32_T c,
                           emxArray_real32_T b_c, int32_T b_dim0);

static __global__ void conv2_kernel104(const emxArray_creal32_T a,
                                       const int32_T b_a,
                                       emxArray_creal32_T c_a, int32_T a_dim0);

static __global__ void conv2_kernel105(const int32_T a, emxArray_creal32_T c);

static __global__ void conv2_kernel106(const emxArray_creal32_T a,
                                       const real32_T b, real32_T *f1,
                                       real32_T *f);

static __global__ void conv2_kernel107(const real32_T *f, const real32_T *f1,
                                       emxArray_creal32_T c);

static __global__ void conv2_kernel108(const emxArray_creal32_T c,
                                       const int32_T b_c,
                                       emxArray_creal32_T c_c, int32_T c_dim0);

static __global__ void conv2_kernel109(const int32_T a,
                                       emxArray_creal32_T expanded);

static __global__ void conv2_kernel110(const emxArray_int32_T y,
                                       const int32_T b_y, emxArray_int32_T iv);

static __global__ void conv2_kernel111(const emxArray_creal32_T a,
                                       const emxArray_int32_T iv,
                                       const int32_T b,
                                       emxArray_creal32_T expanded);

static __global__ void conv2_kernel112(const emxArray_creal32_T expanded,
                                       const real32_T b, const int32_T c,
                                       emxArray_creal32_T b_c);

static __global__ void conv2_kernel113(const int32_T b, emxArray_creal32_T c);

static __global__ void conv2_kernel114(const int32_T b, emxArray_creal32_T c);

static __global__ void conv2_kernel115(const real32_T f, creal32_T b_data[1]);

static __global__ void conv2_kernel116(const emxArray_creal32_T a,
                                       const creal32_T b_data[1],
                                       emxArray_creal32_T c);

static __global__ void conv2_kernel117(const int32_T OH,
                                       emxArray_real32_T expanded);

static __global__ void conv2_kernel118(const int32_T offsetH,
                                       const emxArray_int32_T y,
                                       const int32_T b_y, emxArray_int32_T iv1);

static __global__ void
conv2_kernel119(const emxArray_real32_T b, const int32_T mc,
                const emxArray_int32_T iv1, const int32_T c,
                emxArray_real32_T expanded, int32_T expanded_dim0);

static __global__ void
conv2_kernel120(const emxArray_real32_T expanded, const emxArray_int32_T cols,
                const emxArray_int32_T rows, const emxArray_creal32_T a,
                const int32_T b, const int32_T c, emxArray_creal32_T b_c,
                int32_T a_dim0, int32_T a_dim1, int32_T expanded_dim0,
                int32_T c_dim0);

static __global__ void conv2_kernel133(const int32_T b, emxArray_creal32_T c);

static __global__ void conv2_kernel134(const int32_T OH,
                                       emxArray_real32_T expanded);

static __global__ void conv2_kernel135(const int32_T offsetH,
                                       const emxArray_int32_T y,
                                       const int32_T b_y, emxArray_int32_T iv1);

static __global__ void conv2_kernel136(const emxArray_real32_T b,
                                       const emxArray_int32_T iv1,
                                       const int32_T c,
                                       emxArray_real32_T expanded);

static __global__ void conv2_kernel137(const emxArray_real32_T expanded,
                                       const emxArray_int32_T rows,
                                       const emxArray_creal32_T a,
                                       const int32_T b, emxArray_creal32_T c,
                                       int32_T a_dim0);

static __global__ void conv2_kernel138(const int32_T b, emxArray_creal32_T c);

static __global__ void conv2_kernel139(const int32_T OH,
                                       emxArray_creal32_T expanded);

static __global__ void conv2_kernel140(const int32_T offsetH,
                                       const emxArray_int32_T y,
                                       const int32_T b_y, emxArray_int32_T iv);

static __global__ void conv2_kernel141(const emxArray_creal32_T a,
                                       const emxArray_int32_T iv,
                                       const int32_T b,
                                       emxArray_creal32_T expanded);

static __global__ void conv2_kernel142(const emxArray_creal32_T expanded,
                                       const int32_T offsetH,
                                       const emxArray_int32_T rows,
                                       const int32_T b_rows,
                                       emxArray_creal32_T newIm);

static __global__ void conv2_kernel143(const real32_T cv_im,
                                       const real32_T cv_re,
                                       const int32_T offsetH,
                                       emxArray_creal32_T c);

static __global__ void conv2_kernel44(const emxArray_real32_T a,
                                      const int32_T b_a, emxArray_real32_T c_a,
                                      int32_T a_dim0);

static __global__ void conv2_kernel45(const int32_T a, emxArray_real32_T c);

static __global__ void conv2_kernel46(const real32_T b,
                                      const emxArray_real32_T a,
                                      emxArray_real32_T c);

static __global__ void conv2_kernel47(const emxArray_real32_T c,
                                      const int32_T b_c, emxArray_real32_T c_c,
                                      int32_T c_dim0);

static __global__ void conv2_kernel48(const int32_T a,
                                      emxArray_real32_T expanded);

static __global__ void conv2_kernel49(const emxArray_int32_T y,
                                      const int32_T b_y, emxArray_int32_T iv);

static __global__ void conv2_kernel50(const emxArray_real32_T a,
                                      const emxArray_int32_T iv,
                                      const int32_T b,
                                      emxArray_real32_T expanded);

static __global__ void conv2_kernel51(const real32_T b,
                                      const emxArray_real32_T expanded,
                                      const int32_T c, emxArray_real32_T b_c);

static __global__ void conv2_kernel52(const int32_T b, emxArray_real32_T c);

static __global__ void conv2_kernel53(const int32_T b, emxArray_real32_T c);

static __global__ void conv2_kernel54(const emxArray_real32_T a,
                                      const emxArray_real32_T b,
                                      emxArray_real32_T c);

static __global__ void conv2_kernel55(const int32_T OH,
                                      emxArray_real32_T expanded);

static __global__ void conv2_kernel56(const int32_T offsetH,
                                      const emxArray_int32_T y,
                                      const int32_T b_y, emxArray_int32_T iv1);

static __global__ void
conv2_kernel57(const emxArray_real32_T b, const int32_T mc,
               const emxArray_int32_T iv1, const int32_T c,
               emxArray_real32_T expanded, int32_T expanded_dim0);

static __global__ void
conv2_kernel58(const emxArray_real32_T expanded, const emxArray_int32_T cols,
               const emxArray_int32_T rows, const emxArray_real32_T a,
               const int32_T b, const int32_T c, emxArray_real32_T b_c,
               int32_T a_dim0, int32_T a_dim1, int32_T expanded_dim0,
               int32_T c_dim0);

static void cublasCheck(cublasStatus_t errCode, const char_T *file,
                        uint32_T b_line);

// Function Definitions
//
//
namespace coder {
static void
b_conv2NonSeparable(emxArray_real32_T *cpu_a, boolean_T *a_outdatedOnCpu,
                    emxArray_real32_T *gpu_a, boolean_T *a_outdatedOnGpu,
                    emxArray_real32_T *cpu_b, boolean_T *b_outdatedOnCpu,
                    emxArray_real32_T *gpu_b, boolean_T *b_outdatedOnGpu,
                    emxArray_real32_T *cpu_c, boolean_T *c_outdatedOnCpu,
                    emxArray_real32_T *gpu_c, boolean_T *c_outdatedOnGpu)
{
  dim3 block;
  dim3 grid;
  emxArray_int32_T gpu_iv;
  emxArray_int32_T gpu_rows;
  emxArray_int32_T gpu_y;
  emxArray_int32_T *cpu_iv;
  emxArray_int32_T *cpu_rows;
  emxArray_int32_T *cpu_y;
  emxArray_real32_T gpu_expanded;
  emxArray_real32_T *cpu_expanded;
  int32_T k;
  int32_T mc;
  boolean_T validLaunchParams;
  gpuEmxReset_int32_T(&gpu_rows);
  gpuEmxReset_int32_T(&gpu_iv);
  gpuEmxReset_int32_T(&gpu_y);
  gpuEmxReset_real32_T(&gpu_expanded);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  if ((cpu_a->size[0] == 0) || (cpu_b->size[0] == 0)) {
    mc = cpu_a->size[0] + cpu_b->size[0];
  } else {
    mc = (cpu_a->size[0] + cpu_b->size[0]) - 1;
  }
  k = cpu_c->size[0];
  cpu_c->size[0] = mc;
  emxEnsureCapacity_real32_T(cpu_c, k, &yf_emlrtRTEI);
  mwGetLaunchParameters1D(computeNumIters(mc - 1), &grid, &block, 2147483647U);
  gpuEmxEnsureCapacity_real32_T(cpu_c, gpu_c, true);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    conv2NonSeparable_kernel67<<<grid, block>>>(mc - 1, *gpu_c);
  }
  *c_outdatedOnGpu = false;
  *c_outdatedOnCpu = true;
  emxInit_real32_T(&cpu_expanded, 1, &bg_emlrtRTEI, true);
  emxInit_int32_T(&cpu_y, 2, &eg_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv, 1, &bg_emlrtRTEI, true);
  emxInit_int32_T(&cpu_rows, 2, &bg_emlrtRTEI, true);
  if ((cpu_a->size[0] != 0) && (cpu_b->size[0] != 0)) {
    if ((cpu_a->size[0] == 1) && (cpu_b->size[0] == 1)) {
      real32_T b;
      if (*b_outdatedOnCpu) {
        gpuEmxMemcpyGpuToCpu_real32_T(cpu_b, gpu_b);
      }
      *b_outdatedOnCpu = false;
      b = cpu_b->data[0];
      k = cpu_c->size[0];
      cpu_c->size[0] = 1;
      emxEnsureCapacity_real32_T(cpu_c, k, &yf_emlrtRTEI);
      if (*a_outdatedOnCpu) {
        gpuEmxMemcpyGpuToCpu_real32_T(cpu_a, gpu_a);
      }
      *a_outdatedOnCpu = false;
      cpu_c->data[0] = cpu_a->data[0] * b;
      *c_outdatedOnCpu = false;
      *c_outdatedOnGpu = true;
    } else {
      real_T blockDims_idx_0;
      int32_T b_OH;
      int32_T n;
      int32_T offsetH;
      uint32_T OH;
      int8_T threadDims_idx_0;
      OH = (static_cast<uint32_T>(cpu_a->size[0]) +
            static_cast<uint32_T>(cpu_b->size[0])) -
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
      emxEnsureCapacity_real32_T(cpu_expanded, k, &bg_emlrtRTEI);
      mc = (static_cast<int32_T>(OH) + cpu_b->size[0]) - 2;
      mwGetLaunchParameters1D(computeNumIters(mc), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real32_T(cpu_expanded, &gpu_expanded, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2NonSeparable_kernel68<<<grid, block>>>(mc, gpu_expanded);
      }
      n = cpu_a->size[0];
      k = cpu_y->size[0] * cpu_y->size[1];
      cpu_y->size[0] = 1;
      cpu_y->size[1] = cpu_a->size[0];
      emxEnsureCapacity_int32_T(cpu_y, k, &cg_emlrtRTEI);
      cpu_y->data[0] = 1;
      mc = 1;
      for (k = 0; k <= n - 2; k++) {
        mc++;
        cpu_y->data[k + 1] = mc;
      }
      k = cpu_iv->size[0];
      cpu_iv->size[0] = cpu_y->size[1];
      emxEnsureCapacity_int32_T(cpu_iv, k, &bg_emlrtRTEI);
      mc = cpu_y->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(mc), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_int32_T(cpu_y, &gpu_y, false);
      gpuEmxEnsureCapacity_int32_T(cpu_iv, &gpu_iv, true);
      gpuEmxMemcpyCpuToGpu_int32_T(&gpu_y, cpu_y);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2NonSeparable_kernel69<<<grid, block>>>(offsetH, gpu_y, mc, gpu_iv);
      }
      mc = cpu_iv->size[0];
      mwGetLaunchParameters1D(computeNumIters(mc - 1), &grid, &block,
                              2147483647U);
      gpuEmxEnsureCapacity_real32_T(cpu_a, gpu_a, !*a_outdatedOnGpu);
      if (*a_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(gpu_a, cpu_a);
      }
      *a_outdatedOnGpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2NonSeparable_kernel70<<<grid, block>>>(*gpu_a, gpu_iv, mc - 1,
                                                    gpu_expanded);
      }
      n = cpu_b->size[0];
      k = cpu_rows->size[0] * cpu_rows->size[1];
      cpu_rows->size[0] = 1;
      cpu_rows->size[1] = cpu_b->size[0];
      emxEnsureCapacity_int32_T(cpu_rows, k, &cg_emlrtRTEI);
      cpu_rows->data[0] = 0;
      mc = 0;
      for (k = 0; k <= n - 2; k++) {
        mc++;
        cpu_rows->data[k + 1] = mc;
      }
      k = cpu_c->size[0];
      cpu_c->size[0] = static_cast<int32_T>(OH);
      emxEnsureCapacity_real32_T(cpu_c, k, &bg_emlrtRTEI);
      if (blockDims_idx_0 < 4.294967296E+9) {
        OH = static_cast<uint32_T>(blockDims_idx_0);
      } else {
        OH = MAX_uint32_T;
      }
      mwApplyLaunchParameters(
          computeNumIters(b_OH - 1), dim3(OH, 1U, 1U),
          dim3(static_cast<uint32_T>(threadDims_idx_0), 1U, 1U), &grid, &block);
      gpuEmxEnsureCapacity_int32_T(cpu_rows, &gpu_rows, false);
      gpuEmxEnsureCapacity_real32_T(cpu_b, gpu_b, !*b_outdatedOnGpu);
      gpuEmxEnsureCapacity_real32_T(cpu_c, gpu_c, true);
      gpuEmxMemcpyCpuToGpu_int32_T(&gpu_rows, cpu_rows);
      if (*b_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(gpu_b, cpu_b);
      }
      *b_outdatedOnGpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2NonSeparable_kernel71<<<grid, block>>>(
            gpu_expanded, gpu_rows, *gpu_b, b_OH - 1, *gpu_c, cpu_b->size[0U]);
      }
    }
  }
  emxFree_int32_T(&cpu_rows);
  emxFree_int32_T(&cpu_iv);
  emxFree_int32_T(&cpu_y);
  emxFree_real32_T(&cpu_expanded);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  gpuEmxFree_real32_T(&gpu_expanded);
  gpuEmxFree_int32_T(&gpu_y);
  gpuEmxFree_int32_T(&gpu_iv);
  gpuEmxFree_int32_T(&gpu_rows);
}

//
//
static void
c_conv2NonSeparable(emxArray_creal32_T *cpu_a, emxArray_creal32_T *gpu_a,
                    boolean_T *a_outdatedOnGpu, const emxArray_real32_T *b,
                    emxArray_creal32_T *cpu_c, boolean_T *c_outdatedOnCpu,
                    emxArray_creal32_T *gpu_c, boolean_T *c_outdatedOnGpu)
{
  dim3 block;
  dim3 grid;
  emxArray_creal32_T b_gpu_a;
  emxArray_creal32_T gpu_expanded;
  emxArray_creal32_T gpu_newIm;
  emxArray_creal32_T *b_cpu_a;
  emxArray_creal32_T *cpu_expanded;
  emxArray_creal32_T *cpu_newIm;
  emxArray_int32_T b_gpu_y;
  emxArray_int32_T gpu_iv;
  emxArray_int32_T gpu_iv1;
  emxArray_int32_T gpu_rows;
  emxArray_int32_T gpu_y;
  emxArray_int32_T *b_cpu_y;
  emxArray_int32_T *cpu_iv;
  emxArray_int32_T *cpu_iv1;
  emxArray_int32_T *cpu_rows;
  emxArray_int32_T *cpu_y;
  creal32_T(*gpu_b_data)[1];
  int32_T i;
  int32_T mc;
  int32_T nc;
  boolean_T validLaunchParams;
  checkCudaError(mwCudaMalloc(&gpu_b_data, 8UL), __FILE__, __LINE__);
  gpuEmxReset_creal32_T(&b_gpu_a);
  gpuEmxReset_creal32_T(&gpu_newIm);
  gpuEmxReset_int32_T(&gpu_rows);
  gpuEmxReset_int32_T(&gpu_iv1);
  gpuEmxReset_int32_T(&b_gpu_y);
  gpuEmxReset_int32_T(&gpu_iv);
  gpuEmxReset_int32_T(&gpu_y);
  gpuEmxReset_creal32_T(&gpu_expanded);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  if ((cpu_a->size[0] == 0) || (b->size[0] == 0)) {
    mc = cpu_a->size[0] + b->size[0];
  } else {
    mc = (cpu_a->size[0] + b->size[0]) - 1;
  }
  if (cpu_a->size[1] == 0) {
    nc = 1;
  } else {
    nc = cpu_a->size[1];
  }
  i = cpu_c->size[0] * cpu_c->size[1];
  cpu_c->size[0] = mc;
  cpu_c->size[1] = nc;
  emxEnsureCapacity_creal32_T(cpu_c, i, &yf_emlrtRTEI);
  i = mc * nc - 1;
  mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
  gpuEmxEnsureCapacity_creal32_T(cpu_c, gpu_c, true);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    conv2NonSeparable_kernel121<<<grid, block>>>(i, *gpu_c);
  }
  emxInit_creal32_T(&cpu_expanded, 2, &bg_emlrtRTEI, true);
  emxInit_int32_T(&cpu_y, 2, &eg_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv, 1, &bg_emlrtRTEI, true);
  emxInit_int32_T(&b_cpu_y, 2, &eg_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv1, 1, &bg_emlrtRTEI, true);
  emxInit_int32_T(&cpu_rows, 2, &bg_emlrtRTEI, true);
  emxInit_creal32_T(&cpu_newIm, 1, &bg_emlrtRTEI, true);
  emxInit_creal32_T(&b_cpu_a, 1, &ig_emlrtRTEI, true);
  if ((cpu_a->size[0] == 0) || (cpu_a->size[1] == 0) || (b->size[0] == 0)) {
    i = cpu_c->size[0] * cpu_c->size[1];
    cpu_c->size[0] = mc;
    cpu_c->size[1] = nc;
    emxEnsureCapacity_creal32_T(cpu_c, i, &yf_emlrtRTEI);
    i = mc * nc - 1;
    mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_creal32_T(cpu_c, gpu_c, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      conv2NonSeparable_kernel122<<<grid, block>>>(i, *gpu_c);
    }
  } else if ((cpu_a->size[0] == 1) && (cpu_a->size[1] == 1) &&
             (b->size[0] == 1)) {
    real32_T cv_re;
    cv_re = b->data[0];
    conv2NonSeparable_kernel123<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
        cv_re, *gpu_b_data);
    i = b_cpu_a->size[0];
    b_cpu_a->size[0] = 1;
    emxEnsureCapacity_creal32_T(b_cpu_a, i, &ig_emlrtRTEI);
    gpuEmxEnsureCapacity_creal32_T(cpu_a, gpu_a, !*a_outdatedOnGpu);
    gpuEmxEnsureCapacity_creal32_T(b_cpu_a, &b_gpu_a, true);
    if (*a_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_creal32_T(gpu_a, cpu_a);
    }
    *a_outdatedOnGpu = false;
    conv2NonSeparable_kernel124<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
        *gpu_a, *gpu_b_data, b_gpu_a);
    i = cpu_c->size[0] * cpu_c->size[1];
    cpu_c->size[0] = mc;
    cpu_c->size[1] = nc;
    emxEnsureCapacity_creal32_T(cpu_c, i, &yf_emlrtRTEI);
    i = mc * nc - 1;
    mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_creal32_T(cpu_c, gpu_c, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      conv2NonSeparable_kernel125<<<grid, block>>>(b_gpu_a, i, *gpu_c);
    }
  } else {
    int32_T iv[2];
    int32_T OW;
    int32_T b_OH;
    int32_T offsetH;
    uint32_T OH;
    boolean_T c_needsGpuEnsureCapacity;
    boolean_T rows_needsGpuEnsureCapacity;
    boolean_T rows_outdatedOnGpu;
    OH = (static_cast<uint32_T>(cpu_a->size[0]) +
          static_cast<uint32_T>(b->size[0])) -
         1U;
    OW = cpu_a->size[1];
    if (OH > 2147483647U) {
      OH = 2147483647U;
    }
    b_OH = static_cast<int32_T>(OH);
    offsetH = static_cast<int32_T>(
                  std::floor(static_cast<real_T>(b->size[0]) / 2.0)) +
              static_cast<int32_T>(
                  std::floor((static_cast<real_T>(b->size[0]) - 1.0) / 2.0));
    if (b->size[0] > MAX_int32_T - static_cast<int32_T>(OH)) {
      mc = MAX_int32_T;
    } else {
      mc = static_cast<int32_T>(OH) + b->size[0];
    }
    i = cpu_expanded->size[0] * cpu_expanded->size[1];
    cpu_expanded->size[0] = mc - 1;
    emxEnsureCapacity_creal32_T(cpu_expanded, i, &bg_emlrtRTEI);
    if (cpu_a->size[1] > 2147483646) {
      mc = MAX_int32_T;
    } else {
      mc = cpu_a->size[1] + 1;
    }
    i = cpu_expanded->size[0] * cpu_expanded->size[1];
    cpu_expanded->size[1] = mc - 1;
    emxEnsureCapacity_creal32_T(cpu_expanded, i, &bg_emlrtRTEI);
    i = ((static_cast<int32_T>(OH) + b->size[0]) - 1) * cpu_a->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_creal32_T(cpu_expanded, &gpu_expanded, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      conv2NonSeparable_kernel126<<<grid, block>>>(i, gpu_expanded);
    }
    nc = cpu_a->size[0];
    i = cpu_y->size[0] * cpu_y->size[1];
    cpu_y->size[0] = 1;
    cpu_y->size[1] = cpu_a->size[0];
    emxEnsureCapacity_int32_T(cpu_y, i, &cg_emlrtRTEI);
    cpu_y->data[0] = 1;
    mc = 1;
    for (int32_T k{0}; k <= nc - 2; k++) {
      mc++;
      cpu_y->data[k + 1] = mc;
    }
    i = cpu_iv->size[0];
    cpu_iv->size[0] = cpu_y->size[1];
    emxEnsureCapacity_int32_T(cpu_iv, i, &bg_emlrtRTEI);
    i = cpu_y->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_int32_T(cpu_y, &gpu_y, false);
    gpuEmxEnsureCapacity_int32_T(cpu_iv, &gpu_iv, true);
    gpuEmxMemcpyCpuToGpu_int32_T(&gpu_y, cpu_y);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      conv2NonSeparable_kernel127<<<grid, block>>>(offsetH, gpu_y, i, gpu_iv);
    }
    nc = cpu_a->size[1];
    i = b_cpu_y->size[0] * b_cpu_y->size[1];
    b_cpu_y->size[0] = 1;
    b_cpu_y->size[1] = cpu_a->size[1];
    emxEnsureCapacity_int32_T(b_cpu_y, i, &cg_emlrtRTEI);
    b_cpu_y->data[0] = 1;
    mc = 1;
    for (int32_T k{0}; k <= nc - 2; k++) {
      mc++;
      b_cpu_y->data[k + 1] = mc;
    }
    i = cpu_iv1->size[0];
    cpu_iv1->size[0] = b_cpu_y->size[1];
    emxEnsureCapacity_int32_T(cpu_iv1, i, &bg_emlrtRTEI);
    i = b_cpu_y->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_int32_T(b_cpu_y, &b_gpu_y, false);
    gpuEmxEnsureCapacity_int32_T(cpu_iv1, &gpu_iv1, true);
    gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_y, b_cpu_y);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      conv2NonSeparable_kernel128<<<grid, block>>>(b_gpu_y, i, gpu_iv1);
    }
    iv[0] = cpu_iv->size[0];
    iv[1] = cpu_iv1->size[0];
    mwGetLaunchParameters1D(computeNumIters(iv[1] - 1, iv[0] - 1), &grid,
                            &block, 2147483647U);
    gpuEmxEnsureCapacity_creal32_T(cpu_a, gpu_a, !*a_outdatedOnGpu);
    if (*a_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_creal32_T(gpu_a, cpu_a);
    }
    *a_outdatedOnGpu = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      conv2NonSeparable_kernel129<<<grid, block>>>(
          *gpu_a, iv[0], gpu_iv1, gpu_iv, iv[0] - 1, iv[1] - 1, gpu_expanded,
          cpu_expanded->size[0U]);
    }
    nc = b->size[0];
    i = cpu_rows->size[0] * cpu_rows->size[1];
    cpu_rows->size[0] = 1;
    cpu_rows->size[1] = b->size[0];
    emxEnsureCapacity_int32_T(cpu_rows, i, &cg_emlrtRTEI);
    cpu_rows->data[0] = 0;
    rows_outdatedOnGpu = true;
    rows_needsGpuEnsureCapacity = true;
    mc = 0;
    for (int32_T k{0}; k <= nc - 2; k++) {
      mc++;
      cpu_rows->data[k + 1] = mc;
    }
    i = cpu_c->size[0] * cpu_c->size[1];
    cpu_c->size[0] = static_cast<int32_T>(OH);
    cpu_c->size[1] = cpu_a->size[1];
    emxEnsureCapacity_creal32_T(cpu_c, i, &bg_emlrtRTEI);
    c_needsGpuEnsureCapacity = true;
    mc = b->size[0];
    for (offsetH = 0; offsetH < OW; offsetH++) {
      for (int32_T k{0}; k < b_OH; k++) {
        real32_T cv_im;
        real32_T cv_re;
        boolean_T newIm_outdatedOnCpu;
        i = cpu_newIm->size[0];
        cpu_newIm->size[0] = cpu_rows->size[1];
        emxEnsureCapacity_creal32_T(cpu_newIm, i, &bg_emlrtRTEI);
        i = cpu_rows->size[1] - 1;
        mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
        if (rows_needsGpuEnsureCapacity) {
          gpuEmxEnsureCapacity_int32_T(cpu_rows, &gpu_rows,
                                       !rows_outdatedOnGpu);
        }
        rows_needsGpuEnsureCapacity = false;
        gpuEmxEnsureCapacity_creal32_T(cpu_newIm, &gpu_newIm, true);
        if (rows_outdatedOnGpu) {
          gpuEmxMemcpyCpuToGpu_int32_T(&gpu_rows, cpu_rows);
        }
        rows_outdatedOnGpu = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          conv2NonSeparable_kernel130<<<grid, block>>>(offsetH, gpu_expanded, k,
                                                       gpu_rows, i, gpu_newIm,
                                                       cpu_expanded->size[0U]);
        }
        newIm_outdatedOnCpu = true;
        cv_re = 0.0F;
        cv_im = 0.0F;
        for (nc = 0; nc < mc; nc++) {
          if (newIm_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_creal32_T(cpu_newIm, &gpu_newIm);
          }
          cv_re += cpu_newIm->data[nc].re * b->data[(b->size[0] - nc) - 1];
          newIm_outdatedOnCpu = false;
          cv_im += cpu_newIm->data[nc].im * b->data[(b->size[0] - nc) - 1];
        }
        if (c_needsGpuEnsureCapacity) {
          gpuEmxEnsureCapacity_creal32_T(cpu_c, gpu_c, true);
        }
        conv2NonSeparable_kernel131<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
            cv_re, offsetH, k, *gpu_c, cpu_c->size[0U]);
        c_needsGpuEnsureCapacity = false;
        conv2NonSeparable_kernel132<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
            cv_im, offsetH, k, *gpu_c, cpu_c->size[0U]);
      }
    }
  }
  emxFree_creal32_T(&b_cpu_a);
  emxFree_creal32_T(&cpu_newIm);
  emxFree_int32_T(&cpu_rows);
  emxFree_int32_T(&cpu_iv1);
  emxFree_int32_T(&b_cpu_y);
  emxFree_int32_T(&cpu_iv);
  emxFree_int32_T(&cpu_y);
  emxFree_creal32_T(&cpu_expanded);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  gpuEmxFree_creal32_T(&gpu_expanded);
  gpuEmxFree_int32_T(&gpu_y);
  gpuEmxFree_int32_T(&gpu_iv);
  gpuEmxFree_int32_T(&b_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv1);
  gpuEmxFree_int32_T(&gpu_rows);
  gpuEmxFree_creal32_T(&gpu_newIm);
  gpuEmxFree_creal32_T(&b_gpu_a);
  checkCudaError(mwCudaFree(*gpu_b_data), __FILE__, __LINE__);
  *c_outdatedOnCpu = true;
  *c_outdatedOnGpu = false;
}

//
//
static void
conv2NonSeparable(emxArray_real32_T *cpu_a, emxArray_real32_T *gpu_a,
                  boolean_T *a_outdatedOnGpu, emxArray_real32_T *cpu_b,
                  emxArray_real32_T *gpu_b, boolean_T *b_outdatedOnGpu,
                  emxArray_real32_T *cpu_c, boolean_T *c_outdatedOnCpu,
                  emxArray_real32_T *gpu_c, boolean_T *c_outdatedOnGpu)
{
  dim3 block;
  dim3 grid;
  emxArray_int32_T b_gpu_y;
  emxArray_int32_T gpu_iv;
  emxArray_int32_T gpu_iv1;
  emxArray_int32_T gpu_rows;
  emxArray_int32_T gpu_y;
  emxArray_int32_T *b_cpu_y;
  emxArray_int32_T *cpu_iv;
  emxArray_int32_T *cpu_iv1;
  emxArray_int32_T *cpu_rows;
  emxArray_int32_T *cpu_y;
  emxArray_real32_T b_gpu_c;
  emxArray_real32_T gpu_expanded;
  emxArray_real32_T *b_cpu_c;
  emxArray_real32_T *cpu_expanded;
  int32_T k;
  int32_T mc;
  int32_T nc;
  boolean_T validLaunchParams;
  gpuEmxReset_int32_T(&gpu_rows);
  gpuEmxReset_int32_T(&gpu_iv1);
  gpuEmxReset_int32_T(&b_gpu_y);
  gpuEmxReset_int32_T(&gpu_iv);
  gpuEmxReset_int32_T(&gpu_y);
  gpuEmxReset_real32_T(&gpu_expanded);
  gpuEmxReset_real32_T(&b_gpu_c);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
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
  k = cpu_c->size[0] * cpu_c->size[1];
  cpu_c->size[0] = mc;
  cpu_c->size[1] = nc;
  emxEnsureCapacity_real32_T(cpu_c, k, &yf_emlrtRTEI);
  k = mc * nc - 1;
  mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
  gpuEmxEnsureCapacity_real32_T(cpu_c, gpu_c, true);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    conv2NonSeparable_kernel59<<<grid, block>>>(k, *gpu_c);
  }
  emxInit_real32_T(&b_cpu_c, 1, &gg_emlrtRTEI, true);
  emxInit_real32_T(&cpu_expanded, 2, &bg_emlrtRTEI, true);
  emxInit_int32_T(&cpu_y, 2, &eg_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv, 1, &bg_emlrtRTEI, true);
  emxInit_int32_T(&b_cpu_y, 2, &eg_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv1, 1, &bg_emlrtRTEI, true);
  emxInit_int32_T(&cpu_rows, 2, &bg_emlrtRTEI, true);
  if ((cpu_a->size[0] == 0) || (cpu_a->size[1] == 0) || (cpu_b->size[0] == 0)) {
    k = cpu_c->size[0] * cpu_c->size[1];
    cpu_c->size[0] = mc;
    cpu_c->size[1] = nc;
    emxEnsureCapacity_real32_T(cpu_c, k, &yf_emlrtRTEI);
    k = mc * nc - 1;
    mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real32_T(cpu_c, gpu_c, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      conv2NonSeparable_kernel60<<<grid, block>>>(k, *gpu_c);
    }
  } else if ((cpu_a->size[0] == 1) && (cpu_a->size[1] == 1) &&
             (cpu_b->size[0] == 1)) {
    real32_T alpha1;
    real32_T beta1;
    k = b_cpu_c->size[0];
    b_cpu_c->size[0] = 1;
    emxEnsureCapacity_real32_T(b_cpu_c, k, &fg_emlrtRTEI);
    alpha1 = 1.0F;
    beta1 = 0.0F;
    gpuEmxEnsureCapacity_real32_T(cpu_a, gpu_a, !*a_outdatedOnGpu);
    gpuEmxEnsureCapacity_real32_T(cpu_b, gpu_b, !*b_outdatedOnGpu);
    gpuEmxEnsureCapacity_real32_T(b_cpu_c, &b_gpu_c, true);
    if (*a_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real32_T(gpu_a, cpu_a);
    }
    *a_outdatedOnGpu = false;
    if (*b_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real32_T(gpu_b, cpu_b);
    }
    *b_outdatedOnGpu = false;
    cublasCheck(cublasSgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                            1, 1, 1, (float *)&alpha1, (float *)&gpu_a->data[0],
                            1, (float *)&gpu_b->data[0], 1, (float *)&beta1,
                            (float *)&b_gpu_c.data[0], 1),
                __FILE__, __LINE__);
    k = cpu_c->size[0] * cpu_c->size[1];
    cpu_c->size[0] = mc;
    cpu_c->size[1] = nc;
    emxEnsureCapacity_real32_T(cpu_c, k, &yf_emlrtRTEI);
    k = mc * nc - 1;
    mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real32_T(cpu_c, gpu_c, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      conv2NonSeparable_kernel61<<<grid, block>>>(b_gpu_c, k, *gpu_c);
    }
  } else {
    real_T blockDims[3];
    int32_T iv[2];
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
        std::fmin(32.0, (static_cast<real_T>(cpu_a->size[1]) + 1.0) - 1.0));
    blockDims[0] =
        std::floor((static_cast<real_T>(OH) + (static_cast<real_T>(mc) - 1.0)) /
                   static_cast<real_T>(mc));
    blockDims[1] =
        std::floor((static_cast<real_T>(static_cast<uint32_T>(cpu_a->size[1]) +
                                        static_cast<uint32_T>(nc)) -
                    1.0) /
                   static_cast<real_T>(nc));
    threadDims[0] = static_cast<int8_T>(mc);
    threadDims[1] = static_cast<int8_T>(nc);
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
    k = cpu_expanded->size[0] * cpu_expanded->size[1];
    cpu_expanded->size[0] = mc - 1;
    emxEnsureCapacity_real32_T(cpu_expanded, k, &bg_emlrtRTEI);
    if (cpu_a->size[1] > 2147483646) {
      mc = MAX_int32_T;
    } else {
      mc = cpu_a->size[1] + 1;
    }
    k = cpu_expanded->size[0] * cpu_expanded->size[1];
    cpu_expanded->size[1] = mc - 1;
    emxEnsureCapacity_real32_T(cpu_expanded, k, &bg_emlrtRTEI);
    k = ((static_cast<int32_T>(OH) + cpu_b->size[0]) - 1) * cpu_a->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real32_T(cpu_expanded, &gpu_expanded, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      conv2NonSeparable_kernel62<<<grid, block>>>(k, gpu_expanded);
    }
    nc = cpu_a->size[0];
    k = cpu_y->size[0] * cpu_y->size[1];
    cpu_y->size[0] = 1;
    cpu_y->size[1] = cpu_a->size[0];
    emxEnsureCapacity_int32_T(cpu_y, k, &cg_emlrtRTEI);
    cpu_y->data[0] = 1;
    mc = 1;
    for (k = 0; k <= nc - 2; k++) {
      mc++;
      cpu_y->data[k + 1] = mc;
    }
    k = cpu_iv->size[0];
    cpu_iv->size[0] = cpu_y->size[1];
    emxEnsureCapacity_int32_T(cpu_iv, k, &bg_emlrtRTEI);
    k = cpu_y->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_int32_T(cpu_y, &gpu_y, false);
    gpuEmxEnsureCapacity_int32_T(cpu_iv, &gpu_iv, true);
    gpuEmxMemcpyCpuToGpu_int32_T(&gpu_y, cpu_y);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      conv2NonSeparable_kernel63<<<grid, block>>>(offsetH, gpu_y, k, gpu_iv);
    }
    nc = cpu_a->size[1];
    k = b_cpu_y->size[0] * b_cpu_y->size[1];
    b_cpu_y->size[0] = 1;
    b_cpu_y->size[1] = cpu_a->size[1];
    emxEnsureCapacity_int32_T(b_cpu_y, k, &cg_emlrtRTEI);
    b_cpu_y->data[0] = 1;
    mc = 1;
    for (k = 0; k <= nc - 2; k++) {
      mc++;
      b_cpu_y->data[k + 1] = mc;
    }
    k = cpu_iv1->size[0];
    cpu_iv1->size[0] = b_cpu_y->size[1];
    emxEnsureCapacity_int32_T(cpu_iv1, k, &bg_emlrtRTEI);
    k = b_cpu_y->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_int32_T(b_cpu_y, &b_gpu_y, false);
    gpuEmxEnsureCapacity_int32_T(cpu_iv1, &gpu_iv1, true);
    gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_y, b_cpu_y);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      conv2NonSeparable_kernel64<<<grid, block>>>(b_gpu_y, k, gpu_iv1);
    }
    iv[0] = cpu_iv->size[0];
    iv[1] = cpu_iv1->size[0];
    mwGetLaunchParameters1D(computeNumIters(iv[1] - 1, iv[0] - 1), &grid,
                            &block, 2147483647U);
    gpuEmxEnsureCapacity_real32_T(cpu_a, gpu_a, !*a_outdatedOnGpu);
    if (*a_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real32_T(gpu_a, cpu_a);
    }
    *a_outdatedOnGpu = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      conv2NonSeparable_kernel65<<<grid, block>>>(
          *gpu_a, iv[0], gpu_iv1, gpu_iv, iv[0] - 1, iv[1] - 1, gpu_expanded,
          cpu_expanded->size[0U]);
    }
    nc = cpu_b->size[0];
    k = cpu_rows->size[0] * cpu_rows->size[1];
    cpu_rows->size[0] = 1;
    cpu_rows->size[1] = cpu_b->size[0];
    emxEnsureCapacity_int32_T(cpu_rows, k, &cg_emlrtRTEI);
    cpu_rows->data[0] = 0;
    mc = 0;
    for (k = 0; k <= nc - 2; k++) {
      mc++;
      cpu_rows->data[k + 1] = mc;
    }
    k = cpu_c->size[0] * cpu_c->size[1];
    cpu_c->size[0] = static_cast<int32_T>(OH);
    cpu_c->size[1] = cpu_a->size[1];
    emxEnsureCapacity_real32_T(cpu_c, k, &bg_emlrtRTEI);
    if (blockDims[0] < 4.294967296E+9) {
      OH = static_cast<uint32_T>(blockDims[0]);
    } else {
      OH = MAX_uint32_T;
    }
    mwApplyLaunchParameters(computeNumIters(OW - 1, b_OH - 1),
                            dim3(OH, static_cast<uint32_T>(blockDims[1]), 1U),
                            dim3(static_cast<uint32_T>(threadDims[0]),
                                 static_cast<uint32_T>(threadDims[1]), 1U),
                            &grid, &block);
    gpuEmxEnsureCapacity_int32_T(cpu_rows, &gpu_rows, false);
    gpuEmxEnsureCapacity_real32_T(cpu_b, gpu_b, !*b_outdatedOnGpu);
    gpuEmxEnsureCapacity_real32_T(cpu_c, gpu_c, true);
    gpuEmxMemcpyCpuToGpu_int32_T(&gpu_rows, cpu_rows);
    if (*b_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real32_T(gpu_b, cpu_b);
    }
    *b_outdatedOnGpu = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      conv2NonSeparable_kernel66<<<grid, block>>>(
          gpu_expanded, gpu_rows, *gpu_b, b_OH - 1, OW - 1, *gpu_c,
          cpu_b->size[0U], cpu_expanded->size[0U], cpu_c->size[0U]);
    }
  }
  emxFree_int32_T(&cpu_rows);
  emxFree_int32_T(&cpu_iv1);
  emxFree_int32_T(&b_cpu_y);
  emxFree_int32_T(&cpu_iv);
  emxFree_int32_T(&cpu_y);
  emxFree_real32_T(&cpu_expanded);
  emxFree_real32_T(&b_cpu_c);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  gpuEmxFree_real32_T(&b_gpu_c);
  gpuEmxFree_real32_T(&gpu_expanded);
  gpuEmxFree_int32_T(&gpu_y);
  gpuEmxFree_int32_T(&gpu_iv);
  gpuEmxFree_int32_T(&b_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv1);
  gpuEmxFree_int32_T(&gpu_rows);
  *c_outdatedOnCpu = true;
  *c_outdatedOnGpu = false;
}

} // namespace coder
static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel121(
    const int32_T b, emxArray_creal32_T c)
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

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel122(
    const int32_T b, emxArray_creal32_T c)
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

static __global__ __launch_bounds__(32, 1) void conv2NonSeparable_kernel123(
    const real32_T cv_re, creal32_T b_data[1])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    b_data[0].im = 0.0F;
    b_data[0].re = cv_re;
  }
}

static __global__ __launch_bounds__(32, 1) void conv2NonSeparable_kernel124(
    const emxArray_creal32_T a, const creal32_T b_data[1],
    emxArray_creal32_T b_a)
{
  int32_T i;
  i = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (i < 1) {
    real32_T f;
    b_a.data[0].re = 0.0F;
    b_a.data[0].im = 0.0F;
    f = b_data[0].re;
    b_a.data[0].re += a.data[0].re * f - a.data[0].im * 0.0F;
    b_a.data[0].im += a.data[0].re * 0.0F + a.data[0].im * f;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel125(
    const emxArray_creal32_T a, const int32_T iv, emxArray_creal32_T c)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(iv);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    c.data[i1] = a.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel126(
    const int32_T OH, emxArray_creal32_T expanded)
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

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel127(
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
    int32_T i1;
    int32_T q1;
    i1 = static_cast<int32_T>(idx);
    q1 = y.data[i1];
    if ((offsetH > 0) && (q1 > MAX_int32_T - offsetH)) {
      q1 = MAX_int32_T;
    } else {
      q1 += offsetH;
    }
    iv.data[i1] = q1 - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel128(
    const emxArray_int32_T y, const int32_T b_y, emxArray_int32_T iv1)
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
    iv1.data[i1] = y.data[i1] - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel129(
    const emxArray_creal32_T a, const int32_T iv_dim0,
    const emxArray_int32_T iv1, const emxArray_int32_T iv, const int32_T b_iv,
    const int32_T c_iv, emxArray_creal32_T expanded, int32_T expanded_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c_iv) + 1UL) *
                (static_cast<uint64_T>(b_iv) + 1UL) -
            1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    int32_T q1;
    q1 = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_iv) + 1UL));
    i1 = static_cast<int32_T>((idx - static_cast<uint64_T>(q1)) /
                              (static_cast<uint64_T>(b_iv) + 1UL));
    expanded.data[iv.data[q1] + expanded_dim0 * iv1.data[i1]] =
        a.data[q1 + iv_dim0 * i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel130(
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

static __global__ __launch_bounds__(32, 1) void conv2NonSeparable_kernel131(
    const real32_T cv_re, const int32_T offsetH, const int32_T k,
    emxArray_creal32_T c, int32_T c_dim0)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[k + c_dim0 * offsetH].re = cv_re;
  }
}

static __global__ __launch_bounds__(32, 1) void conv2NonSeparable_kernel132(
    const real32_T cv_im, const int32_T offsetH, const int32_T k,
    emxArray_creal32_T c, int32_T c_dim0)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[k + c_dim0 * offsetH].im = cv_im;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel59(
    const int32_T b, emxArray_real32_T c)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i2;
    i2 = static_cast<int32_T>(idx);
    c.data[i2] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel60(
    const int32_T b, emxArray_real32_T c)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i2;
    i2 = static_cast<int32_T>(idx);
    c.data[i2] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel61(
    const emxArray_real32_T c, const int32_T b, emxArray_real32_T b_c)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i2;
    i2 = static_cast<int32_T>(idx);
    b_c.data[i2] = c.data[i2];
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel62(
    const int32_T OH, emxArray_real32_T expanded)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i2;
    i2 = static_cast<int32_T>(idx);
    expanded.data[i2] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel63(
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
    int32_T i2;
    int32_T q1;
    i2 = static_cast<int32_T>(idx);
    q1 = y.data[i2];
    if ((offsetH > 0) && (q1 > MAX_int32_T - offsetH)) {
      q1 = MAX_int32_T;
    } else {
      q1 += offsetH;
    }
    iv.data[i2] = q1 - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel64(
    const emxArray_int32_T y, const int32_T b_y, emxArray_int32_T iv1)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i2;
    i2 = static_cast<int32_T>(idx);
    iv1.data[i2] = y.data[i2] - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel65(
    const emxArray_real32_T a, const int32_T iv_dim0,
    const emxArray_int32_T iv1, const emxArray_int32_T iv, const int32_T b_iv,
    const int32_T c_iv, emxArray_real32_T expanded, int32_T expanded_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c_iv) + 1UL) *
                (static_cast<uint64_T>(b_iv) + 1UL) -
            1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i2;
    int32_T ocol;
    ocol = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_iv) + 1UL));
    i2 = static_cast<int32_T>((idx - static_cast<uint64_T>(ocol)) /
                              (static_cast<uint64_T>(b_iv) + 1UL));
    expanded.data[iv.data[ocol] + expanded_dim0 * iv1.data[i2]] =
        a.data[ocol + iv_dim0 * i2];
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel66(
    const emxArray_real32_T expanded, const emxArray_int32_T rows,
    const emxArray_real32_T b, const int32_T c, const int32_T d,
    emxArray_real32_T b_c, int32_T b_dim0, int32_T expanded_dim0,
    int32_T c_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(d) + 1UL) * (static_cast<uint64_T>(c) + 1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T ocol;
    int32_T orow;
    real32_T b_cv;
    orow = static_cast<int32_T>(idx % (static_cast<uint64_T>(c) + 1UL));
    ocol = static_cast<int32_T>((idx - static_cast<uint64_T>(orow)) /
                                (static_cast<uint64_T>(c) + 1UL));
    b_cv = 0.0F;
    for (int32_T m{0}; m < b_dim0; m++) {
      int32_T q1;
      q1 = rows.data[m];
      if (q1 > 2147483646 - orow) {
        q1 = MAX_int32_T;
      } else {
        q1 = (orow + q1) + 1;
      }
      b_cv += expanded.data[(q1 + expanded_dim0 * ocol) - 1] *
              b.data[(b_dim0 - m) - 1];
    }
    b_c.data[orow + c_dim0 * ocol] = b_cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel67(
    const int32_T b, emxArray_real32_T c)
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
    c.data[orow] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel68(
    const int32_T OH, emxArray_real32_T expanded)
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

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel69(
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

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel70(
    const emxArray_real32_T a, const emxArray_int32_T iv, const int32_T b,
    emxArray_real32_T expanded)
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

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel71(
    const emxArray_real32_T expanded, const emxArray_int32_T rows,
    const emxArray_real32_T b, const int32_T c, emxArray_real32_T b_c,
    int32_T b_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T orow;
    real32_T b_cv;
    orow = static_cast<int32_T>(idx);
    b_cv = 0.0F;
    for (int32_T m{0}; m < b_dim0; m++) {
      int32_T q1;
      q1 = rows.data[m];
      if (q1 > 2147483646 - orow) {
        q1 = MAX_int32_T;
      } else {
        q1 = (orow + q1) + 1;
      }
      b_cv += expanded.data[q1 - 1] * b.data[(b_dim0 - m) - 1];
    }
    b_c.data[orow] = b_cv;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2_kernel104(
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
    int32_T qY;
    qY = static_cast<int32_T>(idx);
    c_a.data[qY] = a.data[a_dim0 * qY];
  }
}

static __global__
    __launch_bounds__(1024, 1) void conv2_kernel105(const int32_T a,
                                                    emxArray_creal32_T c)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(a);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T qY;
    qY = static_cast<int32_T>(idx);
    c.data[qY].re = 0.0F;
    c.data[qY].im = 0.0F;
  }
}

static __global__ __launch_bounds__(32, 1) void conv2_kernel106(
    const emxArray_creal32_T a, const real32_T b, real32_T *f1, real32_T *f)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    *f = b * a.data[0].re;
    *f1 = b * a.data[0].im;
  }
}

static __global__ __launch_bounds__(32, 1) void conv2_kernel107(
    const real32_T *f, const real32_T *f1, emxArray_creal32_T c)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[0].im = *f1;
    c.data[0].re = *f;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2_kernel108(
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
    int32_T qY;
    qY = static_cast<int32_T>(idx);
    c_c.data[c_dim0 * qY] = c.data[qY];
  }
}

static __global__
    __launch_bounds__(1024, 1) void conv2_kernel109(const int32_T a,
                                                    emxArray_creal32_T expanded)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(a);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T qY;
    qY = static_cast<int32_T>(idx);
    expanded.data[qY].re = 0.0F;
    expanded.data[qY].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2_kernel110(
    const emxArray_int32_T y, const int32_T b_y, emxArray_int32_T iv)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T qY;
    qY = static_cast<int32_T>(idx);
    iv.data[qY] = y.data[qY] - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2_kernel111(
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
    int32_T qY;
    qY = static_cast<int32_T>(idx);
    expanded.data[iv.data[qY]] = a.data[qY];
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2_kernel112(
    const emxArray_creal32_T expanded, const real32_T b, const int32_T c,
    emxArray_creal32_T b_c)
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
    b_c.data[orow].re = b * expanded.data[orow].re;
    b_c.data[orow].im = b * expanded.data[orow].im;
  }
}

static __global__
    __launch_bounds__(1024, 1) void conv2_kernel113(const int32_T b,
                                                    emxArray_creal32_T c)
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

static __global__
    __launch_bounds__(1024, 1) void conv2_kernel114(const int32_T b,
                                                    emxArray_creal32_T c)
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

static __global__ __launch_bounds__(32,
                                    1) void conv2_kernel115(const real32_T f,
                                                            creal32_T b_data[1])
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    b_data[0].im = 0.0F;
    b_data[0].re = f;
  }
}

static __global__ __launch_bounds__(32, 1) void conv2_kernel116(
    const emxArray_creal32_T a, const creal32_T b_data[1], emxArray_creal32_T c)
{
  int32_T k;
  k = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (k < 1) {
    creal32_T b;
    b.re = b_data[0].re * a.data[0].re - 0.0F * a.data[0].im;
    b.im = b_data[0].re * a.data[0].im + 0.0F * a.data[0].re;
    c.data[0] = b;
  }
}

static __global__
    __launch_bounds__(1024, 1) void conv2_kernel117(const int32_T OH,
                                                    emxArray_real32_T expanded)
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

static __global__ __launch_bounds__(1024, 1) void conv2_kernel118(
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
    int32_T q1;
    int32_T qY;
    qY = static_cast<int32_T>(idx);
    q1 = y.data[qY];
    if ((offsetH > 0) && (q1 > MAX_int32_T - offsetH)) {
      q1 = MAX_int32_T;
    } else {
      q1 += offsetH;
    }
    iv1.data[qY] = q1 - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2_kernel119(
    const emxArray_real32_T b, const int32_T mc, const emxArray_int32_T iv1,
    const int32_T c, emxArray_real32_T expanded, int32_T expanded_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T qY;
    qY = static_cast<int32_T>(idx);
    expanded.data[iv1.data[qY] + expanded_dim0 * mc] = b.data[qY];
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2_kernel120(
    const emxArray_real32_T expanded, const emxArray_int32_T cols,
    const emxArray_int32_T rows, const emxArray_creal32_T a, const int32_T b,
    const int32_T c, emxArray_creal32_T b_c, int32_T a_dim0, int32_T a_dim1,
    int32_T expanded_dim0, int32_T c_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(c) + 1UL) * (static_cast<uint64_T>(b) + 1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    creal32_T b_cv;
    int32_T ocol;
    int32_T orow;
    orow = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    ocol = static_cast<int32_T>((idx - static_cast<uint64_T>(orow)) /
                                (static_cast<uint64_T>(b) + 1UL));
    b_cv.re = 0.0F;
    b_cv.im = 0.0F;
    for (int32_T n{0}; n < a_dim1; n++) {
      for (int32_T m{0}; m < a_dim0; m++) {
        creal32_T b_b;
        int32_T q1;
        int32_T qY;
        b_b = a.data[((a_dim0 - m) + a_dim0 * ((a_dim1 - n) - 1)) - 1];
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
        b_cv.re += expanded.data[(qY + expanded_dim0 * (q1 - 1)) - 1] * b_b.re;
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
        b_cv.im += expanded.data[(qY + expanded_dim0 * (q1 - 1)) - 1] * b_b.im;
      }
    }
    b_c.data[orow + c_dim0 * ocol] = b_cv;
  }
}

static __global__
    __launch_bounds__(1024, 1) void conv2_kernel133(const int32_T b,
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
    __launch_bounds__(1024, 1) void conv2_kernel134(const int32_T OH,
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

static __global__ __launch_bounds__(1024, 1) void conv2_kernel135(
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

static __global__ __launch_bounds__(1024, 1) void conv2_kernel136(
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

static __global__ __launch_bounds__(1024, 1) void conv2_kernel137(
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

static __global__
    __launch_bounds__(1024, 1) void conv2_kernel138(const int32_T b,
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
    __launch_bounds__(1024, 1) void conv2_kernel139(const int32_T OH,
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

static __global__ __launch_bounds__(1024, 1) void conv2_kernel140(
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

static __global__ __launch_bounds__(1024, 1) void conv2_kernel141(
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

static __global__ __launch_bounds__(1024, 1) void conv2_kernel142(
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

static __global__ __launch_bounds__(32, 1) void conv2_kernel143(
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

static __global__ __launch_bounds__(1024, 1) void conv2_kernel44(
    const emxArray_real32_T a, const int32_T b_a, emxArray_real32_T c_a,
    int32_T a_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_a);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T ocol;
    ocol = static_cast<int32_T>(idx);
    c_a.data[ocol] = a.data[a_dim0 * ocol];
  }
}

static __global__ __launch_bounds__(1024,
                                    1) void conv2_kernel45(const int32_T a,
                                                           emxArray_real32_T c)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(a);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T ocol;
    ocol = static_cast<int32_T>(idx);
    c.data[ocol] = 0.0F;
  }
}

static __global__ __launch_bounds__(32, 1) void conv2_kernel46(
    const real32_T b, const emxArray_real32_T a, emxArray_real32_T c)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[0] = a.data[0] * b;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2_kernel47(
    const emxArray_real32_T c, const int32_T b_c, emxArray_real32_T c_c,
    int32_T c_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_c);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T ocol;
    ocol = static_cast<int32_T>(idx);
    c_c.data[c_dim0 * ocol] = c.data[ocol];
  }
}

static __global__
    __launch_bounds__(1024, 1) void conv2_kernel48(const int32_T a,
                                                   emxArray_real32_T expanded)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(a);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T ocol;
    ocol = static_cast<int32_T>(idx);
    expanded.data[ocol] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2_kernel49(
    const emxArray_int32_T y, const int32_T b_y, emxArray_int32_T iv)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T ocol;
    ocol = static_cast<int32_T>(idx);
    iv.data[ocol] = y.data[ocol] - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2_kernel50(
    const emxArray_real32_T a, const emxArray_int32_T iv, const int32_T b,
    emxArray_real32_T expanded)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T ocol;
    ocol = static_cast<int32_T>(idx);
    expanded.data[iv.data[ocol]] = a.data[ocol];
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2_kernel51(
    const real32_T b, const emxArray_real32_T expanded, const int32_T c,
    emxArray_real32_T b_c)
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
    b_c.data[orow] = expanded.data[orow] * b;
  }
}

static __global__ __launch_bounds__(1024,
                                    1) void conv2_kernel52(const int32_T b,
                                                           emxArray_real32_T c)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T ocol;
    ocol = static_cast<int32_T>(idx);
    c.data[ocol] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024,
                                    1) void conv2_kernel53(const int32_T b,
                                                           emxArray_real32_T c)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T ocol;
    ocol = static_cast<int32_T>(idx);
    c.data[ocol] = 0.0F;
  }
}

static __global__ __launch_bounds__(32, 1) void conv2_kernel54(
    const emxArray_real32_T a, const emxArray_real32_T b, emxArray_real32_T c)
{
  int32_T k;
  k = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (k < 1) {
    real32_T b_cv;
    b_cv = b.data[0] * a.data[0];
    c.data[0] = b_cv;
  }
}

static __global__
    __launch_bounds__(1024, 1) void conv2_kernel55(const int32_T OH,
                                                   emxArray_real32_T expanded)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(OH);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T ocol;
    ocol = static_cast<int32_T>(idx);
    expanded.data[ocol] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2_kernel56(
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
    int32_T ocol;
    int32_T q1;
    ocol = static_cast<int32_T>(idx);
    q1 = y.data[ocol];
    if ((offsetH > 0) && (q1 > MAX_int32_T - offsetH)) {
      q1 = MAX_int32_T;
    } else {
      q1 += offsetH;
    }
    iv1.data[ocol] = q1 - 1;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2_kernel57(
    const emxArray_real32_T b, const int32_T mc, const emxArray_int32_T iv1,
    const int32_T c, emxArray_real32_T expanded, int32_T expanded_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T ocol;
    ocol = static_cast<int32_T>(idx);
    expanded.data[iv1.data[ocol] + expanded_dim0 * mc] = b.data[ocol];
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2_kernel58(
    const emxArray_real32_T expanded, const emxArray_int32_T cols,
    const emxArray_int32_T rows, const emxArray_real32_T a, const int32_T b,
    const int32_T c, emxArray_real32_T b_c, int32_T a_dim0, int32_T a_dim1,
    int32_T expanded_dim0, int32_T c_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(c) + 1UL) * (static_cast<uint64_T>(b) + 1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T ocol;
    int32_T orow;
    real32_T b_cv;
    orow = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    ocol = static_cast<int32_T>((idx - static_cast<uint64_T>(orow)) /
                                (static_cast<uint64_T>(b) + 1UL));
    b_cv = 0.0F;
    for (int32_T n{0}; n < a_dim1; n++) {
      for (int32_T m{0}; m < a_dim0; m++) {
        int32_T q1;
        int32_T qY;
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
        b_cv += expanded.data[(qY + expanded_dim0 * (q1 - 1)) - 1] *
                a.data[((a_dim0 - m) + a_dim0 * ((a_dim1 - n) - 1)) - 1];
      }
    }
    b_c.data[orow + c_dim0 * ocol] = b_cv;
  }
}

static void cublasCheck(cublasStatus_t errCode, const char_T *file,
                        uint32_T b_line)
{
  const char *errName;
  const char *errString;
  if (errCode != CUBLAS_STATUS_SUCCESS) {
    cublasGetErrorName(errCode, &errName);
    cublasGetErrorString(errCode, &errString);
    raiseCudaError(errCode, file, b_line, errName, errString);
  }
}

//
//
namespace coder {
void b_conv2(const emxArray_real32_T *cpu_a, emxArray_real32_T *cpu_b,
             boolean_T *b_outdatedOnCpu, emxArray_real32_T *gpu_b,
             boolean_T *b_outdatedOnGpu, emxArray_real32_T *cpu_c,
             boolean_T *c_outdatedOnCpu, emxArray_real32_T *gpu_c,
             boolean_T *c_outdatedOnGpu)
{
  emxArray_real32_T gpu_a;
  boolean_T a_outdatedOnCpu;
  boolean_T a_outdatedOnGpu;
  gpuEmxReset_real32_T(&gpu_a);
  a_outdatedOnCpu = false;
  a_outdatedOnGpu = true;
  if ((cpu_a->size[0] == 1) && (cpu_b->size[0] == 1)) {
    int32_T i;
    i = cpu_c->size[0];
    cpu_c->size[0] = 1;
    emxEnsureCapacity_real32_T(cpu_c, i, &ag_emlrtRTEI);
    if (*b_outdatedOnCpu) {
      gpuEmxMemcpyGpuToCpu_real32_T(cpu_b, gpu_b);
    }
    *b_outdatedOnCpu = false;
    cpu_c->data[0] = cpu_a->data[0] * cpu_b->data[0];
    *c_outdatedOnCpu = false;
    *c_outdatedOnGpu = true;
  } else if (cpu_b->size[0] > cpu_a->size[0]) {
    b_conv2NonSeparable(cpu_b, b_outdatedOnCpu, gpu_b, b_outdatedOnGpu,
                        (emxArray_real32_T *)cpu_a, &a_outdatedOnCpu, &gpu_a,
                        &a_outdatedOnGpu, cpu_c, c_outdatedOnCpu, gpu_c,
                        c_outdatedOnGpu);
  } else {
    b_conv2NonSeparable((emxArray_real32_T *)cpu_a, &a_outdatedOnCpu, &gpu_a,
                        &a_outdatedOnGpu, cpu_b, b_outdatedOnCpu, gpu_b,
                        b_outdatedOnGpu, cpu_c, c_outdatedOnCpu, gpu_c,
                        c_outdatedOnGpu);
  }
  gpuEmxFree_real32_T(&gpu_a);
}

//
//
void c_conv2(const emxArray_creal32_T *cpu_a, emxArray_real32_T *cpu_b,
             boolean_T *b_outdatedOnCpu, emxArray_real32_T *gpu_b,
             boolean_T *b_outdatedOnGpu, emxArray_creal32_T *cpu_c,
             boolean_T *c_outdatedOnCpu, emxArray_creal32_T *gpu_c,
             boolean_T *c_outdatedOnGpu)
{
  dim3 block;
  dim3 grid;
  emxArray_creal32_T b_gpu_a;
  emxArray_creal32_T b_gpu_c;
  emxArray_creal32_T gpu_a;
  emxArray_creal32_T gpu_expanded;
  emxArray_creal32_T *b_cpu_a;
  emxArray_creal32_T *b_cpu_c;
  emxArray_creal32_T *cpu_expanded;
  emxArray_int32_T b_gpu_y;
  emxArray_int32_T gpu_cols;
  emxArray_int32_T gpu_iv;
  emxArray_int32_T gpu_iv1;
  emxArray_int32_T gpu_rows;
  emxArray_int32_T gpu_y;
  emxArray_int32_T *b_cpu_y;
  emxArray_int32_T *cpu_cols;
  emxArray_int32_T *cpu_iv;
  emxArray_int32_T *cpu_iv1;
  emxArray_int32_T *cpu_rows;
  emxArray_int32_T *cpu_y;
  emxArray_real32_T b_gpu_expanded;
  emxArray_real32_T *b_cpu_expanded;
  creal32_T(*gpu_b_data)[1];
  real32_T *gpu_f;
  real32_T *gpu_f1;
  boolean_T a_outdatedOnGpu;
  checkCudaError(mwCudaMalloc(&gpu_f1, 4UL), __FILE__, __LINE__);
  checkCudaError(mwCudaMalloc(&gpu_f, 4UL), __FILE__, __LINE__);
  checkCudaError(mwCudaMalloc(&gpu_b_data, 8UL), __FILE__, __LINE__);
  gpuEmxReset_int32_T(&gpu_cols);
  gpuEmxReset_int32_T(&gpu_rows);
  gpuEmxReset_int32_T(&gpu_iv1);
  gpuEmxReset_int32_T(&gpu_iv);
  gpuEmxReset_int32_T(&b_gpu_y);
  gpuEmxReset_real32_T(&b_gpu_expanded);
  gpuEmxReset_int32_T(&gpu_y);
  gpuEmxReset_creal32_T(&gpu_expanded);
  gpuEmxReset_creal32_T(&b_gpu_a);
  gpuEmxReset_creal32_T(&b_gpu_c);
  gpuEmxReset_creal32_T(&gpu_a);
  a_outdatedOnGpu = true;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_creal32_T(&b_cpu_c, 1, &dg_emlrtRTEI, true);
  emxInit_creal32_T(&b_cpu_a, 1, &vf_emlrtRTEI, true);
  emxInit_creal32_T(&cpu_expanded, 1, &bg_emlrtRTEI, true);
  emxInit_int32_T(&cpu_y, 2, &eg_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_expanded, 2, &bg_emlrtRTEI, true);
  emxInit_int32_T(&b_cpu_y, 2, &eg_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv, 1, &bg_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv1, 1, &bg_emlrtRTEI, true);
  emxInit_int32_T(&cpu_rows, 2, &bg_emlrtRTEI, true);
  emxInit_int32_T(&cpu_cols, 2, &bg_emlrtRTEI, true);
  if ((cpu_a->size[0] == 1) && (cpu_b->size[0] == 1)) {
    if (cpu_a->size[1] < 1) {
      int32_T k;
      k = cpu_c->size[0] * cpu_c->size[1];
      cpu_c->size[0] = 1;
      cpu_c->size[1] = 1;
      emxEnsureCapacity_creal32_T(cpu_c, k, &xf_emlrtRTEI);
      cpu_c->data[0].im = 0.0F;
      cpu_c->data[0].re = 0.0F;
      *c_outdatedOnCpu = false;
      *c_outdatedOnGpu = true;
    } else {
      int32_T k;
      real32_T cpu_f;
      boolean_T validLaunchParams;
      k = b_cpu_a->size[0];
      b_cpu_a->size[0] = cpu_a->size[1];
      emxEnsureCapacity_creal32_T(b_cpu_a, k, &vf_emlrtRTEI);
      k = cpu_a->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_creal32_T(cpu_a, &gpu_a, false);
      gpuEmxEnsureCapacity_creal32_T(b_cpu_a, &b_gpu_a, true);
      gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_a, cpu_a);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2_kernel104<<<grid, block>>>(gpu_a, k, b_gpu_a, cpu_a->size[0U]);
      }
      if (*b_outdatedOnCpu) {
        gpuEmxMemcpyGpuToCpu_real32_T(cpu_b, gpu_b);
      }
      *b_outdatedOnCpu = false;
      cpu_f = cpu_b->data[0];
      k = b_cpu_c->size[0];
      b_cpu_c->size[0] = b_cpu_a->size[0];
      emxEnsureCapacity_creal32_T(b_cpu_c, k, &yf_emlrtRTEI);
      k = b_cpu_a->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_creal32_T(b_cpu_c, &b_gpu_c, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2_kernel105<<<grid, block>>>(k, b_gpu_c);
      }
      if (b_cpu_a->size[0] == 1) {
        cpu_f = cpu_b->data[0];
        k = b_cpu_c->size[0];
        b_cpu_c->size[0] = 1;
        emxEnsureCapacity_creal32_T(b_cpu_c, k, &yf_emlrtRTEI);
        conv2_kernel106<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(b_gpu_a, cpu_f,
                                                                 gpu_f1, gpu_f);
        gpuEmxEnsureCapacity_creal32_T(b_cpu_c, &b_gpu_c, true);
        conv2_kernel107<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_f, gpu_f1,
                                                                 b_gpu_c);
      } else {
        int32_T b_OH;
        int32_T mc;
        int32_T nc;
        int32_T offsetH;
        int8_T threadDims[3];
        nc = static_cast<int32_T>(std::fmin(
            32.0, (static_cast<real_T>(b_cpu_a->size[0]) + 1.0) - 1.0));
        offsetH = static_cast<int32_T>(std::floor(
            (static_cast<real_T>(static_cast<uint32_T>(b_cpu_a->size[0]) +
                                 static_cast<uint32_T>(nc)) -
             1.0) /
            static_cast<real_T>(nc)));
        threadDims[0] = static_cast<int8_T>(nc);
        b_OH = b_cpu_a->size[0];
        if (b_cpu_a->size[0] > 2147483646) {
          mc = MAX_int32_T;
        } else {
          mc = b_cpu_a->size[0] + 1;
        }
        k = cpu_expanded->size[0];
        cpu_expanded->size[0] = mc - 1;
        emxEnsureCapacity_creal32_T(cpu_expanded, k, &bg_emlrtRTEI);
        k = b_cpu_a->size[0] - 1;
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        gpuEmxEnsureCapacity_creal32_T(cpu_expanded, &gpu_expanded, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          conv2_kernel109<<<grid, block>>>(k, gpu_expanded);
        }
        nc = b_cpu_a->size[0];
        k = cpu_y->size[0] * cpu_y->size[1];
        cpu_y->size[0] = 1;
        cpu_y->size[1] = b_cpu_a->size[0];
        emxEnsureCapacity_int32_T(cpu_y, k, &cg_emlrtRTEI);
        cpu_y->data[0] = 1;
        mc = 1;
        for (k = 0; k <= nc - 2; k++) {
          mc++;
          cpu_y->data[k + 1] = mc;
        }
        k = cpu_iv->size[0];
        cpu_iv->size[0] = cpu_y->size[1];
        emxEnsureCapacity_int32_T(cpu_iv, k, &bg_emlrtRTEI);
        k = cpu_y->size[1] - 1;
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        gpuEmxEnsureCapacity_int32_T(cpu_y, &gpu_y, false);
        gpuEmxEnsureCapacity_int32_T(cpu_iv, &gpu_iv, true);
        gpuEmxMemcpyCpuToGpu_int32_T(&gpu_y, cpu_y);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          conv2_kernel110<<<grid, block>>>(gpu_y, k, gpu_iv);
        }
        nc = cpu_iv->size[0];
        mwGetLaunchParameters1D(computeNumIters(nc - 1), &grid, &block,
                                2147483647U);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          conv2_kernel111<<<grid, block>>>(b_gpu_a, gpu_iv, nc - 1,
                                           gpu_expanded);
        }
        k = b_cpu_c->size[0];
        b_cpu_c->size[0] = b_cpu_a->size[0];
        emxEnsureCapacity_creal32_T(b_cpu_c, k, &bg_emlrtRTEI);
        mwApplyLaunchParameters(
            computeNumIters(b_OH - 1),
            dim3(static_cast<uint32_T>(offsetH), 1U, 1U),
            dim3(static_cast<uint32_T>(threadDims[0]), 1U, 1U), &grid, &block);
        gpuEmxEnsureCapacity_creal32_T(b_cpu_c, &b_gpu_c, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          conv2_kernel112<<<grid, block>>>(gpu_expanded, cpu_f, b_OH - 1,
                                           b_gpu_c);
        }
      }
      k = cpu_c->size[0] * cpu_c->size[1];
      cpu_c->size[0] = 1;
      cpu_c->size[1] = b_cpu_c->size[0];
      emxEnsureCapacity_creal32_T(cpu_c, k, &ag_emlrtRTEI);
      k = b_cpu_c->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_creal32_T(cpu_c, gpu_c, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2_kernel108<<<grid, block>>>(b_gpu_c, k, *gpu_c, cpu_c->size[0U]);
      }
      *c_outdatedOnGpu = false;
      *c_outdatedOnCpu = true;
    }
  } else if (cpu_b->size[0] > cpu_a->size[0]) {
    int32_T k;
    int32_T mc;
    int32_T nc;
    boolean_T validLaunchParams;
    if (cpu_a->size[0] == 0) {
      mc = cpu_b->size[0];
    } else {
      mc = (cpu_b->size[0] + cpu_a->size[0]) - 1;
    }
    if (cpu_a->size[1] == 0) {
      nc = 1;
    } else {
      nc = cpu_a->size[1];
    }
    k = cpu_c->size[0] * cpu_c->size[1];
    cpu_c->size[0] = mc;
    cpu_c->size[1] = nc;
    emxEnsureCapacity_creal32_T(cpu_c, k, &wf_emlrtRTEI);
    k = mc * nc - 1;
    mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_creal32_T(cpu_c, gpu_c, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      conv2_kernel113<<<grid, block>>>(k, *gpu_c);
    }
    if ((cpu_a->size[0] == 0) || (cpu_a->size[1] == 0)) {
      k = cpu_c->size[0] * cpu_c->size[1];
      cpu_c->size[0] = mc;
      cpu_c->size[1] = nc;
      emxEnsureCapacity_creal32_T(cpu_c, k, &wf_emlrtRTEI);
      k = mc * nc - 1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_creal32_T(cpu_c, gpu_c, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2_kernel114<<<grid, block>>>(k, *gpu_c);
      }
      *c_outdatedOnGpu = false;
      *c_outdatedOnCpu = true;
    } else if ((cpu_b->size[0] == 1) &&
               ((cpu_a->size[0] == 1) && (cpu_a->size[1] == 1))) {
      real32_T cpu_f;
      if (*b_outdatedOnCpu) {
        gpuEmxMemcpyGpuToCpu_real32_T(cpu_b, gpu_b);
      }
      *b_outdatedOnCpu = false;
      cpu_f = cpu_b->data[0];
      conv2_kernel115<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(cpu_f,
                                                               *gpu_b_data);
      k = cpu_c->size[0] * cpu_c->size[1];
      cpu_c->size[0] = 1;
      cpu_c->size[1] = 1;
      emxEnsureCapacity_creal32_T(cpu_c, k, &wf_emlrtRTEI);
      gpuEmxEnsureCapacity_creal32_T(cpu_a, &gpu_a, false);
      gpuEmxEnsureCapacity_creal32_T(cpu_c, gpu_c, true);
      gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_a, cpu_a);
      conv2_kernel116<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
          gpu_a, *gpu_b_data, *gpu_c);
      *c_outdatedOnGpu = false;
      *c_outdatedOnCpu = true;
    } else {
      real_T blockDims[3];
      int32_T OW;
      int32_T b_OH;
      int32_T offsetH;
      uint32_T OH;
      int8_T threadDims[3];
      OH = (static_cast<uint32_T>(cpu_b->size[0]) +
            static_cast<uint32_T>(cpu_a->size[0])) -
           1U;
      nc = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
      mc = static_cast<int32_T>(
          std::fmin(32.0, (static_cast<real_T>(cpu_a->size[1]) + 1.0) - 1.0));
      blockDims[0] = std::floor(
          (static_cast<real_T>(OH) + (static_cast<real_T>(nc) - 1.0)) /
          static_cast<real_T>(nc));
      blockDims[1] = std::floor(
          (static_cast<real_T>(static_cast<uint32_T>(cpu_a->size[1]) +
                               static_cast<uint32_T>(mc)) -
           1.0) /
          static_cast<real_T>(mc));
      threadDims[0] = static_cast<int8_T>(nc);
      threadDims[1] = static_cast<int8_T>(mc);
      OW = cpu_a->size[1];
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
      k = b_cpu_expanded->size[0] * b_cpu_expanded->size[1];
      b_cpu_expanded->size[0] = mc - 1;
      emxEnsureCapacity_real32_T(b_cpu_expanded, k, &bg_emlrtRTEI);
      if (cpu_a->size[1] > MAX_int32_T - cpu_a->size[1]) {
        mc = MAX_int32_T;
      } else {
        mc = cpu_a->size[1] + cpu_a->size[1];
      }
      k = b_cpu_expanded->size[0] * b_cpu_expanded->size[1];
      b_cpu_expanded->size[1] = mc - 1;
      emxEnsureCapacity_real32_T(b_cpu_expanded, k, &bg_emlrtRTEI);
      k = ((static_cast<int32_T>(OH) + cpu_a->size[0]) - 1) *
              ((cpu_a->size[1] + cpu_a->size[1]) - 1) -
          1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real32_T(b_cpu_expanded, &b_gpu_expanded, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2_kernel117<<<grid, block>>>(k, b_gpu_expanded);
      }
      nc = cpu_b->size[0];
      k = b_cpu_y->size[0] * b_cpu_y->size[1];
      b_cpu_y->size[0] = 1;
      b_cpu_y->size[1] = cpu_b->size[0];
      emxEnsureCapacity_int32_T(b_cpu_y, k, &cg_emlrtRTEI);
      b_cpu_y->data[0] = 1;
      mc = 1;
      for (k = 0; k <= nc - 2; k++) {
        mc++;
        b_cpu_y->data[k + 1] = mc;
      }
      k = cpu_iv1->size[0];
      cpu_iv1->size[0] = b_cpu_y->size[1];
      emxEnsureCapacity_int32_T(cpu_iv1, k, &bg_emlrtRTEI);
      k = b_cpu_y->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_int32_T(b_cpu_y, &b_gpu_y, false);
      gpuEmxEnsureCapacity_int32_T(cpu_iv1, &gpu_iv1, true);
      gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_y, b_cpu_y);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2_kernel118<<<grid, block>>>(offsetH, b_gpu_y, k, gpu_iv1);
      }
      mc = static_cast<int32_T>(
               std::floor(static_cast<real_T>(cpu_a->size[1]) / 2.0)) +
           static_cast<int32_T>(
               std::floor((static_cast<real_T>(cpu_a->size[1]) - 1.0) / 2.0));
      nc = cpu_iv1->size[0];
      mwGetLaunchParameters1D(computeNumIters(nc - 1), &grid, &block,
                              2147483647U);
      gpuEmxEnsureCapacity_real32_T(cpu_b, gpu_b, !*b_outdatedOnGpu);
      if (*b_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(gpu_b, cpu_b);
      }
      *b_outdatedOnGpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2_kernel119<<<grid, block>>>(*gpu_b, mc, gpu_iv1, nc - 1,
                                         b_gpu_expanded,
                                         b_cpu_expanded->size[0U]);
      }
      nc = cpu_a->size[0];
      k = cpu_rows->size[0] * cpu_rows->size[1];
      cpu_rows->size[0] = 1;
      cpu_rows->size[1] = cpu_a->size[0];
      emxEnsureCapacity_int32_T(cpu_rows, k, &cg_emlrtRTEI);
      cpu_rows->data[0] = 0;
      mc = 0;
      for (k = 0; k <= nc - 2; k++) {
        mc++;
        cpu_rows->data[k + 1] = mc;
      }
      nc = cpu_a->size[1];
      k = cpu_cols->size[0] * cpu_cols->size[1];
      cpu_cols->size[0] = 1;
      cpu_cols->size[1] = cpu_a->size[1];
      emxEnsureCapacity_int32_T(cpu_cols, k, &cg_emlrtRTEI);
      cpu_cols->data[0] = 0;
      mc = 0;
      for (k = 0; k <= nc - 2; k++) {
        mc++;
        cpu_cols->data[k + 1] = mc;
      }
      k = cpu_c->size[0] * cpu_c->size[1];
      cpu_c->size[0] = static_cast<int32_T>(OH);
      cpu_c->size[1] = cpu_a->size[1];
      emxEnsureCapacity_creal32_T(cpu_c, k, &bg_emlrtRTEI);
      if (blockDims[0] < 4.294967296E+9) {
        OH = static_cast<uint32_T>(blockDims[0]);
      } else {
        OH = MAX_uint32_T;
      }
      mwApplyLaunchParameters(computeNumIters(OW - 1, b_OH - 1),
                              dim3(OH, static_cast<uint32_T>(blockDims[1]), 1U),
                              dim3(static_cast<uint32_T>(threadDims[0]),
                                   static_cast<uint32_T>(threadDims[1]), 1U),
                              &grid, &block);
      gpuEmxEnsureCapacity_int32_T(cpu_cols, &gpu_cols, false);
      gpuEmxEnsureCapacity_int32_T(cpu_rows, &gpu_rows, false);
      gpuEmxEnsureCapacity_creal32_T(cpu_a, &gpu_a, false);
      gpuEmxEnsureCapacity_creal32_T(cpu_c, gpu_c, true);
      gpuEmxMemcpyCpuToGpu_int32_T(&gpu_cols, cpu_cols);
      gpuEmxMemcpyCpuToGpu_int32_T(&gpu_rows, cpu_rows);
      gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_a, cpu_a);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2_kernel120<<<grid, block>>>(
            b_gpu_expanded, gpu_cols, gpu_rows, gpu_a, b_OH - 1, OW - 1, *gpu_c,
            cpu_a->size[0U], cpu_a->size[1U], b_cpu_expanded->size[0U],
            cpu_c->size[0U]);
      }
      *c_outdatedOnGpu = false;
      *c_outdatedOnCpu = true;
    }
  } else {
    if (*b_outdatedOnCpu) {
      gpuEmxMemcpyGpuToCpu_real32_T(cpu_b, gpu_b);
    }
    *b_outdatedOnCpu = false;
    c_conv2NonSeparable((emxArray_creal32_T *)cpu_a, &gpu_a, &a_outdatedOnGpu,
                        cpu_b, cpu_c, c_outdatedOnCpu, gpu_c, c_outdatedOnGpu);
  }
  emxFree_int32_T(&cpu_cols);
  emxFree_int32_T(&cpu_rows);
  emxFree_int32_T(&cpu_iv1);
  emxFree_int32_T(&cpu_iv);
  emxFree_int32_T(&b_cpu_y);
  emxFree_real32_T(&b_cpu_expanded);
  emxFree_int32_T(&cpu_y);
  emxFree_creal32_T(&cpu_expanded);
  emxFree_creal32_T(&b_cpu_a);
  emxFree_creal32_T(&b_cpu_c);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  gpuEmxFree_creal32_T(&gpu_a);
  gpuEmxFree_creal32_T(&b_gpu_c);
  gpuEmxFree_creal32_T(&b_gpu_a);
  gpuEmxFree_creal32_T(&gpu_expanded);
  gpuEmxFree_int32_T(&gpu_y);
  gpuEmxFree_real32_T(&b_gpu_expanded);
  gpuEmxFree_int32_T(&b_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv);
  gpuEmxFree_int32_T(&gpu_iv1);
  gpuEmxFree_int32_T(&gpu_rows);
  gpuEmxFree_int32_T(&gpu_cols);
  checkCudaError(mwCudaFree(*gpu_b_data), __FILE__, __LINE__);
  checkCudaError(mwCudaFree(gpu_f), __FILE__, __LINE__);
  checkCudaError(mwCudaFree(gpu_f1), __FILE__, __LINE__);
}

//
//
void conv2(const emxArray_real32_T *cpu_a, emxArray_real32_T *cpu_b,
           boolean_T *b_outdatedOnCpu, emxArray_real32_T *gpu_b,
           boolean_T *b_outdatedOnGpu, emxArray_real32_T *cpu_c,
           boolean_T *c_outdatedOnCpu, emxArray_real32_T *gpu_c,
           boolean_T *c_outdatedOnGpu)
{
  dim3 block;
  dim3 grid;
  emxArray_int32_T b_gpu_y;
  emxArray_int32_T gpu_cols;
  emxArray_int32_T gpu_iv;
  emxArray_int32_T gpu_iv1;
  emxArray_int32_T gpu_rows;
  emxArray_int32_T gpu_y;
  emxArray_int32_T *b_cpu_y;
  emxArray_int32_T *cpu_cols;
  emxArray_int32_T *cpu_iv;
  emxArray_int32_T *cpu_iv1;
  emxArray_int32_T *cpu_rows;
  emxArray_int32_T *cpu_y;
  emxArray_real32_T b_gpu_a;
  emxArray_real32_T b_gpu_c;
  emxArray_real32_T b_gpu_expanded;
  emxArray_real32_T gpu_a;
  emxArray_real32_T gpu_expanded;
  emxArray_real32_T *b_cpu_a;
  emxArray_real32_T *b_cpu_c;
  emxArray_real32_T *b_cpu_expanded;
  emxArray_real32_T *cpu_expanded;
  boolean_T a_outdatedOnGpu;
  gpuEmxReset_int32_T(&gpu_cols);
  gpuEmxReset_int32_T(&gpu_rows);
  gpuEmxReset_int32_T(&gpu_iv1);
  gpuEmxReset_int32_T(&gpu_iv);
  gpuEmxReset_int32_T(&b_gpu_y);
  gpuEmxReset_real32_T(&b_gpu_expanded);
  gpuEmxReset_int32_T(&gpu_y);
  gpuEmxReset_real32_T(&gpu_expanded);
  gpuEmxReset_real32_T(&b_gpu_a);
  gpuEmxReset_real32_T(&b_gpu_c);
  gpuEmxReset_real32_T(&gpu_a);
  a_outdatedOnGpu = true;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real32_T(&b_cpu_c, 1, &dg_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_a, 1, &vf_emlrtRTEI, true);
  emxInit_real32_T(&cpu_expanded, 1, &bg_emlrtRTEI, true);
  emxInit_int32_T(&cpu_y, 2, &eg_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_expanded, 2, &bg_emlrtRTEI, true);
  emxInit_int32_T(&b_cpu_y, 2, &eg_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv, 1, &bg_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv1, 1, &bg_emlrtRTEI, true);
  emxInit_int32_T(&cpu_rows, 2, &bg_emlrtRTEI, true);
  emxInit_int32_T(&cpu_cols, 2, &bg_emlrtRTEI, true);
  if ((cpu_a->size[0] == 1) && (cpu_b->size[0] == 1)) {
    if (cpu_a->size[1] < 1) {
      int32_T k;
      k = cpu_c->size[0] * cpu_c->size[1];
      cpu_c->size[0] = 1;
      cpu_c->size[1] = 1;
      emxEnsureCapacity_real32_T(cpu_c, k, &xf_emlrtRTEI);
      cpu_c->data[0] = 0.0F;
      *c_outdatedOnCpu = false;
      *c_outdatedOnGpu = true;
    } else {
      int32_T k;
      real32_T b;
      boolean_T validLaunchParams;
      k = b_cpu_a->size[0];
      b_cpu_a->size[0] = cpu_a->size[1];
      emxEnsureCapacity_real32_T(b_cpu_a, k, &vf_emlrtRTEI);
      k = cpu_a->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real32_T(cpu_a, &gpu_a, false);
      gpuEmxEnsureCapacity_real32_T(b_cpu_a, &b_gpu_a, true);
      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_a, cpu_a);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2_kernel44<<<grid, block>>>(gpu_a, k, b_gpu_a, cpu_a->size[0U]);
      }
      if (*b_outdatedOnCpu) {
        gpuEmxMemcpyGpuToCpu_real32_T(cpu_b, gpu_b);
      }
      *b_outdatedOnCpu = false;
      b = cpu_b->data[0];
      k = b_cpu_c->size[0];
      b_cpu_c->size[0] = b_cpu_a->size[0];
      emxEnsureCapacity_real32_T(b_cpu_c, k, &yf_emlrtRTEI);
      k = b_cpu_a->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real32_T(b_cpu_c, &b_gpu_c, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2_kernel45<<<grid, block>>>(k, b_gpu_c);
      }
      if (b_cpu_a->size[0] == 1) {
        b = cpu_b->data[0];
        k = b_cpu_c->size[0];
        b_cpu_c->size[0] = 1;
        emxEnsureCapacity_real32_T(b_cpu_c, k, &yf_emlrtRTEI);
        gpuEmxEnsureCapacity_real32_T(b_cpu_c, &b_gpu_c, true);
        conv2_kernel46<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(b, b_gpu_a,
                                                                b_gpu_c);
      } else {
        int32_T b_OH;
        int32_T mc;
        int32_T nc;
        int32_T offsetH;
        int8_T threadDims[3];
        nc = static_cast<int32_T>(std::fmin(
            32.0, (static_cast<real_T>(b_cpu_a->size[0]) + 1.0) - 1.0));
        offsetH = static_cast<int32_T>(std::floor(
            (static_cast<real_T>(static_cast<uint32_T>(b_cpu_a->size[0]) +
                                 static_cast<uint32_T>(nc)) -
             1.0) /
            static_cast<real_T>(nc)));
        threadDims[0] = static_cast<int8_T>(nc);
        b_OH = b_cpu_a->size[0];
        if (b_cpu_a->size[0] > 2147483646) {
          mc = MAX_int32_T;
        } else {
          mc = b_cpu_a->size[0] + 1;
        }
        k = cpu_expanded->size[0];
        cpu_expanded->size[0] = mc - 1;
        emxEnsureCapacity_real32_T(cpu_expanded, k, &bg_emlrtRTEI);
        k = b_cpu_a->size[0] - 1;
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        gpuEmxEnsureCapacity_real32_T(cpu_expanded, &gpu_expanded, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          conv2_kernel48<<<grid, block>>>(k, gpu_expanded);
        }
        nc = b_cpu_a->size[0];
        k = cpu_y->size[0] * cpu_y->size[1];
        cpu_y->size[0] = 1;
        cpu_y->size[1] = b_cpu_a->size[0];
        emxEnsureCapacity_int32_T(cpu_y, k, &cg_emlrtRTEI);
        cpu_y->data[0] = 1;
        mc = 1;
        for (k = 0; k <= nc - 2; k++) {
          mc++;
          cpu_y->data[k + 1] = mc;
        }
        k = cpu_iv->size[0];
        cpu_iv->size[0] = cpu_y->size[1];
        emxEnsureCapacity_int32_T(cpu_iv, k, &bg_emlrtRTEI);
        k = cpu_y->size[1] - 1;
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        gpuEmxEnsureCapacity_int32_T(cpu_y, &gpu_y, false);
        gpuEmxEnsureCapacity_int32_T(cpu_iv, &gpu_iv, true);
        gpuEmxMemcpyCpuToGpu_int32_T(&gpu_y, cpu_y);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          conv2_kernel49<<<grid, block>>>(gpu_y, k, gpu_iv);
        }
        nc = cpu_iv->size[0];
        mwGetLaunchParameters1D(computeNumIters(nc - 1), &grid, &block,
                                2147483647U);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          conv2_kernel50<<<grid, block>>>(b_gpu_a, gpu_iv, nc - 1,
                                          gpu_expanded);
        }
        k = b_cpu_c->size[0];
        b_cpu_c->size[0] = b_cpu_a->size[0];
        emxEnsureCapacity_real32_T(b_cpu_c, k, &bg_emlrtRTEI);
        mwApplyLaunchParameters(
            computeNumIters(b_OH - 1),
            dim3(static_cast<uint32_T>(offsetH), 1U, 1U),
            dim3(static_cast<uint32_T>(threadDims[0]), 1U, 1U), &grid, &block);
        gpuEmxEnsureCapacity_real32_T(b_cpu_c, &b_gpu_c, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          conv2_kernel51<<<grid, block>>>(b, gpu_expanded, b_OH - 1, b_gpu_c);
        }
      }
      k = cpu_c->size[0] * cpu_c->size[1];
      cpu_c->size[0] = 1;
      cpu_c->size[1] = b_cpu_c->size[0];
      emxEnsureCapacity_real32_T(cpu_c, k, &ag_emlrtRTEI);
      k = b_cpu_c->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real32_T(cpu_c, gpu_c, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2_kernel47<<<grid, block>>>(b_gpu_c, k, *gpu_c, cpu_c->size[0U]);
      }
      *c_outdatedOnGpu = false;
      *c_outdatedOnCpu = true;
    }
  } else if (cpu_b->size[0] > cpu_a->size[0]) {
    int32_T k;
    int32_T mc;
    int32_T nc;
    boolean_T validLaunchParams;
    if (cpu_a->size[0] == 0) {
      mc = cpu_b->size[0];
    } else {
      mc = (cpu_b->size[0] + cpu_a->size[0]) - 1;
    }
    if (cpu_a->size[1] == 0) {
      nc = 1;
    } else {
      nc = cpu_a->size[1];
    }
    k = cpu_c->size[0] * cpu_c->size[1];
    cpu_c->size[0] = mc;
    cpu_c->size[1] = nc;
    emxEnsureCapacity_real32_T(cpu_c, k, &wf_emlrtRTEI);
    k = mc * nc - 1;
    mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real32_T(cpu_c, gpu_c, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      conv2_kernel52<<<grid, block>>>(k, *gpu_c);
    }
    if ((cpu_a->size[0] == 0) || (cpu_a->size[1] == 0)) {
      k = cpu_c->size[0] * cpu_c->size[1];
      cpu_c->size[0] = mc;
      cpu_c->size[1] = nc;
      emxEnsureCapacity_real32_T(cpu_c, k, &wf_emlrtRTEI);
      k = mc * nc - 1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real32_T(cpu_c, gpu_c, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2_kernel53<<<grid, block>>>(k, *gpu_c);
      }
      *c_outdatedOnGpu = false;
      *c_outdatedOnCpu = true;
    } else if ((cpu_b->size[0] == 1) &&
               ((cpu_a->size[0] == 1) && (cpu_a->size[1] == 1))) {
      k = cpu_c->size[0] * cpu_c->size[1];
      cpu_c->size[0] = 1;
      cpu_c->size[1] = 1;
      emxEnsureCapacity_real32_T(cpu_c, k, &wf_emlrtRTEI);
      gpuEmxEnsureCapacity_real32_T(cpu_a, &gpu_a, false);
      gpuEmxEnsureCapacity_real32_T(cpu_b, gpu_b, !*b_outdatedOnGpu);
      gpuEmxEnsureCapacity_real32_T(cpu_c, gpu_c, true);
      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_a, cpu_a);
      if (*b_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(gpu_b, cpu_b);
      }
      *b_outdatedOnGpu = false;
      conv2_kernel54<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_a, *gpu_b,
                                                              *gpu_c);
      *c_outdatedOnGpu = false;
      *c_outdatedOnCpu = true;
    } else {
      real_T blockDims[3];
      int32_T OW;
      int32_T b_OH;
      int32_T offsetH;
      uint32_T OH;
      int8_T threadDims[3];
      OH = (static_cast<uint32_T>(cpu_b->size[0]) +
            static_cast<uint32_T>(cpu_a->size[0])) -
           1U;
      nc = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
      mc = static_cast<int32_T>(
          std::fmin(32.0, (static_cast<real_T>(cpu_a->size[1]) + 1.0) - 1.0));
      blockDims[0] = std::floor(
          (static_cast<real_T>(OH) + (static_cast<real_T>(nc) - 1.0)) /
          static_cast<real_T>(nc));
      blockDims[1] = std::floor(
          (static_cast<real_T>(static_cast<uint32_T>(cpu_a->size[1]) +
                               static_cast<uint32_T>(mc)) -
           1.0) /
          static_cast<real_T>(mc));
      threadDims[0] = static_cast<int8_T>(nc);
      threadDims[1] = static_cast<int8_T>(mc);
      OW = cpu_a->size[1];
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
      k = b_cpu_expanded->size[0] * b_cpu_expanded->size[1];
      b_cpu_expanded->size[0] = mc - 1;
      emxEnsureCapacity_real32_T(b_cpu_expanded, k, &bg_emlrtRTEI);
      if (cpu_a->size[1] > MAX_int32_T - cpu_a->size[1]) {
        mc = MAX_int32_T;
      } else {
        mc = cpu_a->size[1] + cpu_a->size[1];
      }
      k = b_cpu_expanded->size[0] * b_cpu_expanded->size[1];
      b_cpu_expanded->size[1] = mc - 1;
      emxEnsureCapacity_real32_T(b_cpu_expanded, k, &bg_emlrtRTEI);
      k = ((static_cast<int32_T>(OH) + cpu_a->size[0]) - 1) *
              ((cpu_a->size[1] + cpu_a->size[1]) - 1) -
          1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real32_T(b_cpu_expanded, &b_gpu_expanded, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2_kernel55<<<grid, block>>>(k, b_gpu_expanded);
      }
      nc = cpu_b->size[0];
      k = b_cpu_y->size[0] * b_cpu_y->size[1];
      b_cpu_y->size[0] = 1;
      b_cpu_y->size[1] = cpu_b->size[0];
      emxEnsureCapacity_int32_T(b_cpu_y, k, &cg_emlrtRTEI);
      b_cpu_y->data[0] = 1;
      mc = 1;
      for (k = 0; k <= nc - 2; k++) {
        mc++;
        b_cpu_y->data[k + 1] = mc;
      }
      k = cpu_iv1->size[0];
      cpu_iv1->size[0] = b_cpu_y->size[1];
      emxEnsureCapacity_int32_T(cpu_iv1, k, &bg_emlrtRTEI);
      k = b_cpu_y->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_int32_T(b_cpu_y, &b_gpu_y, false);
      gpuEmxEnsureCapacity_int32_T(cpu_iv1, &gpu_iv1, true);
      gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_y, b_cpu_y);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2_kernel56<<<grid, block>>>(offsetH, b_gpu_y, k, gpu_iv1);
      }
      mc = static_cast<int32_T>(
               std::floor(static_cast<real_T>(cpu_a->size[1]) / 2.0)) +
           static_cast<int32_T>(
               std::floor((static_cast<real_T>(cpu_a->size[1]) - 1.0) / 2.0));
      nc = cpu_iv1->size[0];
      mwGetLaunchParameters1D(computeNumIters(nc - 1), &grid, &block,
                              2147483647U);
      gpuEmxEnsureCapacity_real32_T(cpu_b, gpu_b, !*b_outdatedOnGpu);
      if (*b_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(gpu_b, cpu_b);
      }
      *b_outdatedOnGpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2_kernel57<<<grid, block>>>(*gpu_b, mc, gpu_iv1, nc - 1,
                                        b_gpu_expanded,
                                        b_cpu_expanded->size[0U]);
      }
      nc = cpu_a->size[0];
      k = cpu_rows->size[0] * cpu_rows->size[1];
      cpu_rows->size[0] = 1;
      cpu_rows->size[1] = cpu_a->size[0];
      emxEnsureCapacity_int32_T(cpu_rows, k, &cg_emlrtRTEI);
      cpu_rows->data[0] = 0;
      mc = 0;
      for (k = 0; k <= nc - 2; k++) {
        mc++;
        cpu_rows->data[k + 1] = mc;
      }
      nc = cpu_a->size[1];
      k = cpu_cols->size[0] * cpu_cols->size[1];
      cpu_cols->size[0] = 1;
      cpu_cols->size[1] = cpu_a->size[1];
      emxEnsureCapacity_int32_T(cpu_cols, k, &cg_emlrtRTEI);
      cpu_cols->data[0] = 0;
      mc = 0;
      for (k = 0; k <= nc - 2; k++) {
        mc++;
        cpu_cols->data[k + 1] = mc;
      }
      k = cpu_c->size[0] * cpu_c->size[1];
      cpu_c->size[0] = static_cast<int32_T>(OH);
      cpu_c->size[1] = cpu_a->size[1];
      emxEnsureCapacity_real32_T(cpu_c, k, &bg_emlrtRTEI);
      if (blockDims[0] < 4.294967296E+9) {
        OH = static_cast<uint32_T>(blockDims[0]);
      } else {
        OH = MAX_uint32_T;
      }
      mwApplyLaunchParameters(computeNumIters(OW - 1, b_OH - 1),
                              dim3(OH, static_cast<uint32_T>(blockDims[1]), 1U),
                              dim3(static_cast<uint32_T>(threadDims[0]),
                                   static_cast<uint32_T>(threadDims[1]), 1U),
                              &grid, &block);
      gpuEmxEnsureCapacity_int32_T(cpu_cols, &gpu_cols, false);
      gpuEmxEnsureCapacity_int32_T(cpu_rows, &gpu_rows, false);
      gpuEmxEnsureCapacity_real32_T(cpu_a, &gpu_a, false);
      gpuEmxEnsureCapacity_real32_T(cpu_c, gpu_c, true);
      gpuEmxMemcpyCpuToGpu_int32_T(&gpu_cols, cpu_cols);
      gpuEmxMemcpyCpuToGpu_int32_T(&gpu_rows, cpu_rows);
      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_a, cpu_a);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2_kernel58<<<grid, block>>>(
            b_gpu_expanded, gpu_cols, gpu_rows, gpu_a, b_OH - 1, OW - 1, *gpu_c,
            cpu_a->size[0U], cpu_a->size[1U], b_cpu_expanded->size[0U],
            cpu_c->size[0U]);
      }
      *c_outdatedOnGpu = false;
      *c_outdatedOnCpu = true;
    }
  } else {
    conv2NonSeparable((emxArray_real32_T *)cpu_a, &gpu_a, &a_outdatedOnGpu,
                      cpu_b, gpu_b, b_outdatedOnGpu, cpu_c, c_outdatedOnCpu,
                      gpu_c, c_outdatedOnGpu);
  }
  emxFree_int32_T(&cpu_cols);
  emxFree_int32_T(&cpu_rows);
  emxFree_int32_T(&cpu_iv1);
  emxFree_int32_T(&cpu_iv);
  emxFree_int32_T(&b_cpu_y);
  emxFree_real32_T(&b_cpu_expanded);
  emxFree_int32_T(&cpu_y);
  emxFree_real32_T(&cpu_expanded);
  emxFree_real32_T(&b_cpu_a);
  emxFree_real32_T(&b_cpu_c);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  gpuEmxFree_real32_T(&gpu_a);
  gpuEmxFree_real32_T(&b_gpu_c);
  gpuEmxFree_real32_T(&b_gpu_a);
  gpuEmxFree_real32_T(&gpu_expanded);
  gpuEmxFree_int32_T(&gpu_y);
  gpuEmxFree_real32_T(&b_gpu_expanded);
  gpuEmxFree_int32_T(&b_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv);
  gpuEmxFree_int32_T(&gpu_iv1);
  gpuEmxFree_int32_T(&gpu_rows);
  gpuEmxFree_int32_T(&gpu_cols);
}

//
//
void d_conv2(const emxArray_creal32_T *cpu_a, emxArray_real32_T *cpu_b,
             boolean_T *b_outdatedOnCpu, emxArray_real32_T *gpu_b,
             boolean_T *b_outdatedOnGpu, emxArray_creal32_T *cpu_c,
             boolean_T *c_outdatedOnCpu, emxArray_creal32_T *gpu_c,
             boolean_T *c_outdatedOnGpu)
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
  emxArray_real32_T gpu_expanded;
  emxArray_real32_T *b_cpu_expanded;
  gpuEmxReset_creal32_T(&gpu_newIm);
  gpuEmxReset_int32_T(&gpu_rows);
  gpuEmxReset_int32_T(&b_gpu_rows);
  gpuEmxReset_int32_T(&gpu_iv1);
  gpuEmxReset_int32_T(&gpu_iv);
  gpuEmxReset_int32_T(&gpu_y);
  gpuEmxReset_int32_T(&b_gpu_y);
  gpuEmxReset_real32_T(&gpu_expanded);
  gpuEmxReset_creal32_T(&b_gpu_expanded);
  gpuEmxReset_creal32_T(&gpu_a);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_creal32_T(&cpu_expanded, 1, &bg_emlrtRTEI, true);
  emxInit_real32_T(&b_cpu_expanded, 1, &bg_emlrtRTEI, true);
  emxInit_int32_T(&cpu_y, 2, &eg_emlrtRTEI, true);
  emxInit_int32_T(&b_cpu_y, 2, &eg_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv, 1, &bg_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv1, 1, &bg_emlrtRTEI, true);
  emxInit_int32_T(&cpu_rows, 2, &bg_emlrtRTEI, true);
  emxInit_int32_T(&b_cpu_rows, 2, &bg_emlrtRTEI, true);
  emxInit_creal32_T(&cpu_newIm, 1, &bg_emlrtRTEI, true);
  if ((cpu_a->size[0] == 1) && (cpu_b->size[0] == 1)) {
    int32_T k;
    k = cpu_c->size[0];
    cpu_c->size[0] = 1;
    emxEnsureCapacity_creal32_T(cpu_c, k, &ag_emlrtRTEI);
    if (*b_outdatedOnCpu) {
      gpuEmxMemcpyGpuToCpu_real32_T(cpu_b, gpu_b);
    }
    cpu_c->data[0].re = cpu_b->data[0] * cpu_a->data[0].re;
    *b_outdatedOnCpu = false;
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
    emxEnsureCapacity_creal32_T(cpu_c, k, &wf_emlrtRTEI);
    mwGetLaunchParameters1D(computeNumIters(mc - 1), &grid, &block,
                            2147483647U);
    gpuEmxEnsureCapacity_creal32_T(cpu_c, gpu_c, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      conv2_kernel133<<<grid, block>>>(mc - 1, *gpu_c);
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
        emxEnsureCapacity_creal32_T(cpu_c, k, &wf_emlrtRTEI);
        if (*b_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real32_T(cpu_b, gpu_b);
        }
        cv_im = cpu_b->data[0] * a.re;
        *b_outdatedOnCpu = false;
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
        emxEnsureCapacity_real32_T(b_cpu_expanded, k, &bg_emlrtRTEI);
        k = (static_cast<int32_T>(OH) + cpu_a->size[0]) - 2;
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        gpuEmxEnsureCapacity_real32_T(b_cpu_expanded, &gpu_expanded, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          conv2_kernel134<<<grid, block>>>(k, gpu_expanded);
        }
        n = cpu_b->size[0];
        k = b_cpu_y->size[0] * b_cpu_y->size[1];
        b_cpu_y->size[0] = 1;
        b_cpu_y->size[1] = cpu_b->size[0];
        emxEnsureCapacity_int32_T(b_cpu_y, k, &cg_emlrtRTEI);
        b_cpu_y->data[0] = 1;
        mc = 1;
        for (k = 0; k <= n - 2; k++) {
          mc++;
          b_cpu_y->data[k + 1] = mc;
        }
        k = cpu_iv1->size[0];
        cpu_iv1->size[0] = b_cpu_y->size[1];
        emxEnsureCapacity_int32_T(cpu_iv1, k, &bg_emlrtRTEI);
        k = b_cpu_y->size[1] - 1;
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        gpuEmxEnsureCapacity_int32_T(b_cpu_y, &gpu_y, false);
        gpuEmxEnsureCapacity_int32_T(cpu_iv1, &gpu_iv1, true);
        gpuEmxMemcpyCpuToGpu_int32_T(&gpu_y, b_cpu_y);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          conv2_kernel135<<<grid, block>>>(offsetH, gpu_y, k, gpu_iv1);
        }
        mc = cpu_iv1->size[0];
        mwGetLaunchParameters1D(computeNumIters(mc - 1), &grid, &block,
                                2147483647U);
        gpuEmxEnsureCapacity_real32_T(cpu_b, gpu_b, !*b_outdatedOnGpu);
        if (*b_outdatedOnGpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(gpu_b, cpu_b);
        }
        *b_outdatedOnGpu = false;
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          conv2_kernel136<<<grid, block>>>(*gpu_b, gpu_iv1, mc - 1,
                                           gpu_expanded);
        }
        n = cpu_a->size[0];
        k = b_cpu_rows->size[0] * b_cpu_rows->size[1];
        b_cpu_rows->size[0] = 1;
        b_cpu_rows->size[1] = cpu_a->size[0];
        emxEnsureCapacity_int32_T(b_cpu_rows, k, &cg_emlrtRTEI);
        b_cpu_rows->data[0] = 0;
        mc = 0;
        for (k = 0; k <= n - 2; k++) {
          mc++;
          b_cpu_rows->data[k + 1] = mc;
        }
        k = cpu_c->size[0];
        cpu_c->size[0] = static_cast<int32_T>(OH);
        emxEnsureCapacity_creal32_T(cpu_c, k, &bg_emlrtRTEI);
        if (blockDims_idx_0 < 4.294967296E+9) {
          OH = static_cast<uint32_T>(blockDims_idx_0);
        } else {
          OH = MAX_uint32_T;
        }
        mwApplyLaunchParameters(
            computeNumIters(b_OH - 1), dim3(OH, 1U, 1U),
            dim3(static_cast<uint32_T>(threadDims_idx_0), 1U, 1U), &grid,
            &block);
        gpuEmxEnsureCapacity_int32_T(b_cpu_rows, &gpu_rows, false);
        gpuEmxEnsureCapacity_creal32_T(cpu_a, &gpu_a, false);
        gpuEmxEnsureCapacity_creal32_T(cpu_c, gpu_c, true);
        gpuEmxMemcpyCpuToGpu_int32_T(&gpu_rows, b_cpu_rows);
        gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_a, cpu_a);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          conv2_kernel137<<<grid, block>>>(gpu_expanded, gpu_rows, gpu_a,
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
    emxEnsureCapacity_creal32_T(cpu_c, k, &jg_emlrtRTEI);
    mwGetLaunchParameters1D(computeNumIters(mc - 1), &grid, &block,
                            2147483647U);
    gpuEmxEnsureCapacity_creal32_T(cpu_c, gpu_c, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      conv2_kernel138<<<grid, block>>>(mc - 1, *gpu_c);
    }
    *c_outdatedOnGpu = false;
    *c_outdatedOnCpu = true;
    if ((cpu_a->size[0] != 0) && (cpu_b->size[0] != 0)) {
      if ((cpu_a->size[0] == 1) && (cpu_b->size[0] == 1)) {
        real32_T cv_im;
        real32_T cv_re;
        if (*b_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real32_T(cpu_b, gpu_b);
        }
        *b_outdatedOnCpu = false;
        cv_re = cpu_b->data[0];
        k = cpu_c->size[0];
        cpu_c->size[0] = 1;
        emxEnsureCapacity_creal32_T(cpu_c, k, &jg_emlrtRTEI);
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
        emxEnsureCapacity_creal32_T(cpu_expanded, k, &bg_emlrtRTEI);
        k = (static_cast<int32_T>(OH) + cpu_b->size[0]) - 2;
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        gpuEmxEnsureCapacity_creal32_T(cpu_expanded, &b_gpu_expanded, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          conv2_kernel139<<<grid, block>>>(k, b_gpu_expanded);
        }
        n = cpu_a->size[0];
        k = cpu_y->size[0] * cpu_y->size[1];
        cpu_y->size[0] = 1;
        cpu_y->size[1] = cpu_a->size[0];
        emxEnsureCapacity_int32_T(cpu_y, k, &cg_emlrtRTEI);
        cpu_y->data[0] = 1;
        mc = 1;
        for (k = 0; k <= n - 2; k++) {
          mc++;
          cpu_y->data[k + 1] = mc;
        }
        k = cpu_iv->size[0];
        cpu_iv->size[0] = cpu_y->size[1];
        emxEnsureCapacity_int32_T(cpu_iv, k, &bg_emlrtRTEI);
        k = cpu_y->size[1] - 1;
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        gpuEmxEnsureCapacity_int32_T(cpu_y, &b_gpu_y, false);
        gpuEmxEnsureCapacity_int32_T(cpu_iv, &gpu_iv, true);
        gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_y, cpu_y);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          conv2_kernel140<<<grid, block>>>(offsetH, b_gpu_y, k, gpu_iv);
        }
        mc = cpu_iv->size[0];
        mwGetLaunchParameters1D(computeNumIters(mc - 1), &grid, &block,
                                2147483647U);
        gpuEmxEnsureCapacity_creal32_T(cpu_a, &gpu_a, false);
        gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_a, cpu_a);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          conv2_kernel141<<<grid, block>>>(gpu_a, gpu_iv, mc - 1,
                                           b_gpu_expanded);
        }
        n = cpu_b->size[0];
        k = cpu_rows->size[0] * cpu_rows->size[1];
        cpu_rows->size[0] = 1;
        cpu_rows->size[1] = cpu_b->size[0];
        emxEnsureCapacity_int32_T(cpu_rows, k, &cg_emlrtRTEI);
        cpu_rows->data[0] = 0;
        rows_outdatedOnGpu = true;
        rows_needsGpuEnsureCapacity = true;
        mc = 0;
        for (k = 0; k <= n - 2; k++) {
          mc++;
          cpu_rows->data[k + 1] = mc;
        }
        k = cpu_c->size[0];
        cpu_c->size[0] = static_cast<int32_T>(OH);
        emxEnsureCapacity_creal32_T(cpu_c, k, &bg_emlrtRTEI);
        c_needsGpuEnsureCapacity = true;
        mc = cpu_b->size[0];
        for (offsetH = 0; offsetH < b_OH; offsetH++) {
          real32_T cv_im;
          real32_T cv_re;
          boolean_T newIm_outdatedOnCpu;
          k = cpu_newIm->size[0];
          cpu_newIm->size[0] = cpu_rows->size[1];
          emxEnsureCapacity_creal32_T(cpu_newIm, k, &bg_emlrtRTEI);
          k = cpu_rows->size[1] - 1;
          mwGetLaunchParameters1D(computeNumIters(k), &grid, &block,
                                  2147483647U);
          if (rows_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_int32_T(cpu_rows, &b_gpu_rows,
                                         !rows_outdatedOnGpu);
          }
          rows_needsGpuEnsureCapacity = false;
          gpuEmxEnsureCapacity_creal32_T(cpu_newIm, &gpu_newIm, true);
          if (rows_outdatedOnGpu) {
            gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_rows, cpu_rows);
          }
          rows_outdatedOnGpu = false;
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            conv2_kernel142<<<grid, block>>>(b_gpu_expanded, offsetH,
                                             b_gpu_rows, k, gpu_newIm);
          }
          newIm_outdatedOnCpu = true;
          cv_re = 0.0F;
          cv_im = 0.0F;
          for (n = 0; n < mc; n++) {
            if (newIm_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_creal32_T(cpu_newIm, &gpu_newIm);
            }
            if (*b_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real32_T(cpu_b, gpu_b);
            }
            cv_re +=
                cpu_newIm->data[n].re * cpu_b->data[(cpu_b->size[0] - n) - 1];
            newIm_outdatedOnCpu = false;
            *b_outdatedOnCpu = false;
            cv_im +=
                cpu_newIm->data[n].im * cpu_b->data[(cpu_b->size[0] - n) - 1];
          }
          if (c_needsGpuEnsureCapacity) {
            gpuEmxEnsureCapacity_creal32_T(cpu_c, gpu_c, true);
          }
          c_needsGpuEnsureCapacity = false;
          conv2_kernel143<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
              cv_im, cv_re, offsetH, *gpu_c);
        }
      }
    }
  }
  emxFree_creal32_T(&cpu_newIm);
  emxFree_int32_T(&b_cpu_rows);
  emxFree_int32_T(&cpu_rows);
  emxFree_int32_T(&cpu_iv1);
  emxFree_int32_T(&cpu_iv);
  emxFree_int32_T(&b_cpu_y);
  emxFree_int32_T(&cpu_y);
  emxFree_real32_T(&b_cpu_expanded);
  emxFree_creal32_T(&cpu_expanded);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  gpuEmxFree_creal32_T(&gpu_a);
  gpuEmxFree_creal32_T(&b_gpu_expanded);
  gpuEmxFree_real32_T(&gpu_expanded);
  gpuEmxFree_int32_T(&b_gpu_y);
  gpuEmxFree_int32_T(&gpu_y);
  gpuEmxFree_int32_T(&gpu_iv);
  gpuEmxFree_int32_T(&gpu_iv1);
  gpuEmxFree_int32_T(&b_gpu_rows);
  gpuEmxFree_int32_T(&gpu_rows);
  gpuEmxFree_creal32_T(&gpu_newIm);
}

} // namespace coder

// End of code generation (conv2.cu)
