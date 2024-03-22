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
#include "ec_cwt_data.h"
#include "ec_cwt_emxutil.h"
#include "ec_cwt_mexutil.h"
#include "ec_cwt_types.h"
#include "rt_nonfinite.h"
#include "MWCUBLASUtils.hpp"
#include "MWCudaDimUtility.hpp"
#include "MWErrorCodeUtils.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include <cmath>

// Variable Definitions
static emlrtRTEInfo lf_emlrtRTEI{
    49,                                                               // lineNo
    31,                                                               // colNo
    "conv2",                                                          // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/conv2.m" // pName
};

static emlrtRTEInfo mf_emlrtRTEI{
    56,                                                               // lineNo
    5,                                                                // colNo
    "conv2",                                                          // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/conv2.m" // pName
};

static emlrtRTEInfo nf_emlrtRTEI{
    47,                                                               // lineNo
    9,                                                                // colNo
    "conv2",                                                          // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/conv2.m" // pName
};

static emlrtRTEInfo of_emlrtRTEI{
    75,                                                               // lineNo
    5,                                                                // colNo
    "conv2",                                                          // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/conv2.m" // pName
};

static emlrtRTEInfo pf_emlrtRTEI{
    49,                                                               // lineNo
    9,                                                                // colNo
    "conv2",                                                          // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/conv2.m" // pName
};

static emlrtRTEInfo qf_emlrtRTEI{
    1,                 // lineNo
    1,                 // colNo
    "stencil_codegen", // fName
    "/usr/local/MATLAB/R2024a/toolbox/gpucoder/gpucoder/+gpucoder/+internal/"
    "stencil_codegen.p" // pName
};

static emlrtRTEInfo rf_emlrtRTEI{
    172,                                                          // lineNo
    20,                                                           // colNo
    "colon",                                                      // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/ops/colon.m" // pName
};

static emlrtRTEInfo sf_emlrtRTEI{
    49,                                                               // lineNo
    13,                                                               // colNo
    "conv2",                                                          // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/conv2.m" // pName
};

static emlrtRTEInfo tf_emlrtRTEI{
    82,                                                           // lineNo
    9,                                                            // colNo
    "colon",                                                      // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/ops/colon.m" // pName
};

static emlrtRTEInfo
    uf_emlrtRTEI{
        158,      // lineNo
        24,       // colNo
        "mtimes", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+blas/"
        "mtimes.m" // pName
    };

static emlrtRTEInfo vf_emlrtRTEI{
    1,                  // lineNo
    1,                  // colNo
    "gpu_conv2_kernel", // fName
    "/usr/local/MATLAB/R2024a/toolbox/gpucoder/gpucoder/+coder/+internal/"
    "+images/gpu_conv2_kernel.p" // pName
};

// Function Declarations
namespace coder {
static void
b_conv2NonSeparable(emxArray_real_T *cpu_a, boolean_T *a_outdatedOnCpu,
                    emxArray_real_T *gpu_a, boolean_T *a_outdatedOnGpu,
                    emxArray_real_T *cpu_b, boolean_T *b_outdatedOnCpu,
                    emxArray_real_T *gpu_b, boolean_T *b_outdatedOnGpu,
                    emxArray_real_T *cpu_c, boolean_T *c_outdatedOnCpu,
                    emxArray_real_T *gpu_c, boolean_T *c_outdatedOnGpu);

static void
conv2NonSeparable(emxArray_real_T *cpu_a, emxArray_real_T *gpu_a,
                  boolean_T *a_outdatedOnGpu, emxArray_real_T *cpu_b,
                  emxArray_real_T *gpu_b, boolean_T *b_outdatedOnGpu,
                  emxArray_real_T *cpu_c, boolean_T *c_outdatedOnCpu,
                  emxArray_real_T *gpu_c, boolean_T *c_outdatedOnGpu);

} // namespace coder
static __global__ void conv2NonSeparable_kernel43(const int32_T b,
                                                  emxArray_real_T c);

static __global__ void conv2NonSeparable_kernel44(const int32_T b,
                                                  emxArray_real_T c);

static __global__ void conv2NonSeparable_kernel45(const emxArray_real_T c,
                                                  const int32_T b,
                                                  emxArray_real_T b_c);

static __global__ void conv2NonSeparable_kernel46(const int32_T OH,
                                                  emxArray_real_T expanded);

static __global__ void conv2NonSeparable_kernel47(const int32_T offsetH,
                                                  const emxArray_int32_T y,
                                                  const int32_T b_y,
                                                  emxArray_int32_T iv);

static __global__ void conv2NonSeparable_kernel48(const emxArray_int32_T y,
                                                  const int32_T b_y,
                                                  emxArray_int32_T iv1);

static __global__ void conv2NonSeparable_kernel49(
    const emxArray_real_T a, const int32_T iv_dim0, const emxArray_int32_T iv1,
    const emxArray_int32_T iv, const int32_T b_iv, const int32_T c_iv,
    emxArray_real_T expanded, int32_T expanded_dim0);

static __global__ void conv2NonSeparable_kernel50(
    const emxArray_real_T expanded, const emxArray_int32_T rows,
    const emxArray_real_T b, const int32_T c, const int32_T d,
    emxArray_real_T b_c, int32_T b_dim0, int32_T expanded_dim0, int32_T c_dim0);

static __global__ void conv2NonSeparable_kernel51(const int32_T b,
                                                  emxArray_real_T c);

static __global__ void conv2NonSeparable_kernel52(const int32_T OH,
                                                  emxArray_real_T expanded);

static __global__ void conv2NonSeparable_kernel53(const int32_T offsetH,
                                                  const emxArray_int32_T y,
                                                  const int32_T b_y,
                                                  emxArray_int32_T iv);

static __global__ void conv2NonSeparable_kernel54(const emxArray_real_T a,
                                                  const emxArray_int32_T iv,
                                                  const int32_T b,
                                                  emxArray_real_T expanded);

static __global__ void
conv2NonSeparable_kernel55(const emxArray_real_T expanded,
                           const emxArray_int32_T rows, const emxArray_real_T b,
                           const int32_T c, emxArray_real_T b_c,
                           int32_T b_dim0);

static __global__ void conv2_kernel28(const emxArray_real_T a,
                                      const int32_T b_a, emxArray_real_T c_a,
                                      int32_T a_dim0);

static __global__ void conv2_kernel29(const int32_T a, emxArray_real_T c);

static __global__ void conv2_kernel30(const real_T b, const emxArray_real_T a,
                                      emxArray_real_T c);

static __global__ void conv2_kernel31(const emxArray_real_T c,
                                      const int32_T b_c, emxArray_real_T c_c,
                                      int32_T c_dim0);

static __global__ void conv2_kernel32(const int32_T a,
                                      emxArray_real_T expanded);

static __global__ void conv2_kernel33(const emxArray_int32_T y,
                                      const int32_T b_y, emxArray_int32_T iv);

static __global__ void conv2_kernel34(const emxArray_real_T a,
                                      const emxArray_int32_T iv,
                                      const int32_T b,
                                      emxArray_real_T expanded);

static __global__ void conv2_kernel35(const real_T b,
                                      const emxArray_real_T expanded,
                                      const int32_T c, emxArray_real_T b_c);

static __global__ void conv2_kernel36(const int32_T b, emxArray_real_T c);

static __global__ void conv2_kernel37(const int32_T b, emxArray_real_T c);

static __global__ void conv2_kernel38(const emxArray_real_T a,
                                      const emxArray_real_T b,
                                      emxArray_real_T c);

static __global__ void conv2_kernel39(const int32_T OH,
                                      emxArray_real_T expanded);

static __global__ void conv2_kernel40(const int32_T offsetH,
                                      const emxArray_int32_T y,
                                      const int32_T b_y, emxArray_int32_T iv1);

static __global__ void conv2_kernel41(const emxArray_real_T b, const int32_T mc,
                                      const emxArray_int32_T iv1,
                                      const int32_T c, emxArray_real_T expanded,
                                      int32_T expanded_dim0);

static __global__ void conv2_kernel42(const emxArray_real_T expanded,
                                      const emxArray_int32_T cols,
                                      const emxArray_int32_T rows,
                                      const emxArray_real_T a, const int32_T b,
                                      const int32_T c, emxArray_real_T b_c,
                                      int32_T a_dim0, int32_T a_dim1,
                                      int32_T expanded_dim0, int32_T c_dim0);

static void cublasCheck(cublasStatus_t errCode, const char_T *file,
                        uint32_T b_line);

// Function Definitions
//
//
namespace coder {
static void
b_conv2NonSeparable(emxArray_real_T *cpu_a, boolean_T *a_outdatedOnCpu,
                    emxArray_real_T *gpu_a, boolean_T *a_outdatedOnGpu,
                    emxArray_real_T *cpu_b, boolean_T *b_outdatedOnCpu,
                    emxArray_real_T *gpu_b, boolean_T *b_outdatedOnGpu,
                    emxArray_real_T *cpu_c, boolean_T *c_outdatedOnCpu,
                    emxArray_real_T *gpu_c, boolean_T *c_outdatedOnGpu)
{
  dim3 block;
  dim3 grid;
  emxArray_int32_T gpu_iv;
  emxArray_int32_T gpu_rows;
  emxArray_int32_T gpu_y;
  emxArray_int32_T *cpu_iv;
  emxArray_int32_T *cpu_rows;
  emxArray_int32_T *cpu_y;
  emxArray_real_T gpu_expanded;
  emxArray_real_T *cpu_expanded;
  int32_T k;
  int32_T mc;
  boolean_T validLaunchParams;
  gpuEmxReset_int32_T(&gpu_rows);
  gpuEmxReset_int32_T(&gpu_iv);
  gpuEmxReset_int32_T(&gpu_y);
  gpuEmxReset_real_T(&gpu_expanded);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  if ((cpu_a->size[0] == 0) || (cpu_b->size[0] == 0)) {
    mc = cpu_a->size[0] + cpu_b->size[0];
  } else {
    mc = (cpu_a->size[0] + cpu_b->size[0]) - 1;
  }
  k = cpu_c->size[0];
  cpu_c->size[0] = mc;
  emxEnsureCapacity_real_T(cpu_c, k, &of_emlrtRTEI);
  mwGetLaunchParameters1D(computeNumIters(mc - 1), &grid, &block, 2147483647U);
  gpuEmxEnsureCapacity_real_T(cpu_c, gpu_c, true);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    conv2NonSeparable_kernel51<<<grid, block>>>(mc - 1, *gpu_c);
  }
  *c_outdatedOnGpu = false;
  *c_outdatedOnCpu = true;
  emxInit_real_T(&cpu_expanded, 1, &qf_emlrtRTEI, true);
  emxInit_int32_T(&cpu_y, 2, &tf_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv, 1, &qf_emlrtRTEI, true);
  emxInit_int32_T(&cpu_rows, 2, &qf_emlrtRTEI, true);
  if ((cpu_a->size[0] != 0) && (cpu_b->size[0] != 0)) {
    if ((cpu_a->size[0] == 1) && (cpu_b->size[0] == 1)) {
      real_T blockDims_idx_0;
      if (*b_outdatedOnCpu) {
        gpuEmxMemcpyGpuToCpu_real_T(cpu_b, gpu_b);
      }
      *b_outdatedOnCpu = false;
      blockDims_idx_0 = cpu_b->data[0];
      k = cpu_c->size[0];
      cpu_c->size[0] = 1;
      emxEnsureCapacity_real_T(cpu_c, k, &of_emlrtRTEI);
      if (*a_outdatedOnCpu) {
        gpuEmxMemcpyGpuToCpu_real_T(cpu_a, gpu_a);
      }
      *a_outdatedOnCpu = false;
      cpu_c->data[0] = cpu_a->data[0] * blockDims_idx_0;
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
      emxEnsureCapacity_real_T(cpu_expanded, k, &qf_emlrtRTEI);
      mc = (static_cast<int32_T>(OH) + cpu_b->size[0]) - 2;
      mwGetLaunchParameters1D(computeNumIters(mc), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(cpu_expanded, &gpu_expanded, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2NonSeparable_kernel52<<<grid, block>>>(mc, gpu_expanded);
      }
      n = cpu_a->size[0];
      k = cpu_y->size[0] * cpu_y->size[1];
      cpu_y->size[0] = 1;
      cpu_y->size[1] = cpu_a->size[0];
      emxEnsureCapacity_int32_T(cpu_y, k, &rf_emlrtRTEI);
      cpu_y->data[0] = 1;
      mc = 1;
      for (k = 0; k <= n - 2; k++) {
        mc++;
        cpu_y->data[k + 1] = mc;
      }
      k = cpu_iv->size[0];
      cpu_iv->size[0] = cpu_y->size[1];
      emxEnsureCapacity_int32_T(cpu_iv, k, &qf_emlrtRTEI);
      mc = cpu_y->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(mc), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_int32_T(cpu_y, &gpu_y, false);
      gpuEmxEnsureCapacity_int32_T(cpu_iv, &gpu_iv, true);
      gpuEmxMemcpyCpuToGpu_int32_T(&gpu_y, cpu_y);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2NonSeparable_kernel53<<<grid, block>>>(offsetH, gpu_y, mc, gpu_iv);
      }
      mc = cpu_iv->size[0];
      mwGetLaunchParameters1D(computeNumIters(mc - 1), &grid, &block,
                              2147483647U);
      gpuEmxEnsureCapacity_real_T(cpu_a, gpu_a, !*a_outdatedOnGpu);
      if (*a_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real_T(gpu_a, cpu_a);
      }
      *a_outdatedOnGpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2NonSeparable_kernel54<<<grid, block>>>(*gpu_a, gpu_iv, mc - 1,
                                                    gpu_expanded);
      }
      n = cpu_b->size[0];
      k = cpu_rows->size[0] * cpu_rows->size[1];
      cpu_rows->size[0] = 1;
      cpu_rows->size[1] = cpu_b->size[0];
      emxEnsureCapacity_int32_T(cpu_rows, k, &rf_emlrtRTEI);
      cpu_rows->data[0] = 0;
      mc = 0;
      for (k = 0; k <= n - 2; k++) {
        mc++;
        cpu_rows->data[k + 1] = mc;
      }
      k = cpu_c->size[0];
      cpu_c->size[0] = static_cast<int32_T>(OH);
      emxEnsureCapacity_real_T(cpu_c, k, &qf_emlrtRTEI);
      if (blockDims_idx_0 < 4.294967296E+9) {
        OH = static_cast<uint32_T>(blockDims_idx_0);
      } else {
        OH = MAX_uint32_T;
      }
      mwApplyLaunchParameters(
          computeNumIters(b_OH - 1), dim3(OH, 1U, 1U),
          dim3(static_cast<uint32_T>(threadDims_idx_0), 1U, 1U), &grid, &block);
      gpuEmxEnsureCapacity_int32_T(cpu_rows, &gpu_rows, false);
      gpuEmxEnsureCapacity_real_T(cpu_b, gpu_b, !*b_outdatedOnGpu);
      gpuEmxEnsureCapacity_real_T(cpu_c, gpu_c, true);
      gpuEmxMemcpyCpuToGpu_int32_T(&gpu_rows, cpu_rows);
      if (*b_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real_T(gpu_b, cpu_b);
      }
      *b_outdatedOnGpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2NonSeparable_kernel55<<<grid, block>>>(
            gpu_expanded, gpu_rows, *gpu_b, b_OH - 1, *gpu_c, cpu_b->size[0U]);
      }
    }
  }
  emxFree_int32_T(&cpu_rows);
  emxFree_int32_T(&cpu_iv);
  emxFree_int32_T(&cpu_y);
  emxFree_real_T(&cpu_expanded);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  gpuEmxFree_real_T(&gpu_expanded);
  gpuEmxFree_int32_T(&gpu_y);
  gpuEmxFree_int32_T(&gpu_iv);
  gpuEmxFree_int32_T(&gpu_rows);
}

//
//
static void
conv2NonSeparable(emxArray_real_T *cpu_a, emxArray_real_T *gpu_a,
                  boolean_T *a_outdatedOnGpu, emxArray_real_T *cpu_b,
                  emxArray_real_T *gpu_b, boolean_T *b_outdatedOnGpu,
                  emxArray_real_T *cpu_c, boolean_T *c_outdatedOnCpu,
                  emxArray_real_T *gpu_c, boolean_T *c_outdatedOnGpu)
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
  emxArray_real_T b_gpu_c;
  emxArray_real_T gpu_expanded;
  emxArray_real_T *b_cpu_c;
  emxArray_real_T *cpu_expanded;
  int32_T k;
  int32_T mc;
  int32_T nc;
  boolean_T validLaunchParams;
  gpuEmxReset_int32_T(&gpu_rows);
  gpuEmxReset_int32_T(&gpu_iv1);
  gpuEmxReset_int32_T(&b_gpu_y);
  gpuEmxReset_int32_T(&gpu_iv);
  gpuEmxReset_int32_T(&gpu_y);
  gpuEmxReset_real_T(&gpu_expanded);
  gpuEmxReset_real_T(&b_gpu_c);
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
  emxEnsureCapacity_real_T(cpu_c, k, &of_emlrtRTEI);
  k = mc * nc - 1;
  mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
  gpuEmxEnsureCapacity_real_T(cpu_c, gpu_c, true);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    conv2NonSeparable_kernel43<<<grid, block>>>(k, *gpu_c);
  }
  emxInit_real_T(&b_cpu_c, 1, &vf_emlrtRTEI, true);
  emxInit_real_T(&cpu_expanded, 2, &qf_emlrtRTEI, true);
  emxInit_int32_T(&cpu_y, 2, &tf_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv, 1, &qf_emlrtRTEI, true);
  emxInit_int32_T(&b_cpu_y, 2, &tf_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv1, 1, &qf_emlrtRTEI, true);
  emxInit_int32_T(&cpu_rows, 2, &qf_emlrtRTEI, true);
  if ((cpu_a->size[0] == 0) || (cpu_a->size[1] == 0) || (cpu_b->size[0] == 0)) {
    k = cpu_c->size[0] * cpu_c->size[1];
    cpu_c->size[0] = mc;
    cpu_c->size[1] = nc;
    emxEnsureCapacity_real_T(cpu_c, k, &of_emlrtRTEI);
    k = mc * nc - 1;
    mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real_T(cpu_c, gpu_c, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      conv2NonSeparable_kernel44<<<grid, block>>>(k, *gpu_c);
    }
  } else if ((cpu_a->size[0] == 1) && (cpu_a->size[1] == 1) &&
             (cpu_b->size[0] == 1)) {
    real_T alpha1;
    real_T beta1;
    k = b_cpu_c->size[0];
    b_cpu_c->size[0] = 1;
    emxEnsureCapacity_real_T(b_cpu_c, k, &uf_emlrtRTEI);
    alpha1 = 1.0;
    beta1 = 0.0;
    gpuEmxEnsureCapacity_real_T(cpu_a, gpu_a, !*a_outdatedOnGpu);
    gpuEmxEnsureCapacity_real_T(cpu_b, gpu_b, !*b_outdatedOnGpu);
    gpuEmxEnsureCapacity_real_T(b_cpu_c, &b_gpu_c, true);
    if (*a_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real_T(gpu_a, cpu_a);
    }
    *a_outdatedOnGpu = false;
    if (*b_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real_T(gpu_b, cpu_b);
    }
    *b_outdatedOnGpu = false;
    cublasCheck(cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                            1, 1, 1, (double *)&alpha1,
                            (double *)&gpu_a->data[0], 1,
                            (double *)&gpu_b->data[0], 1, (double *)&beta1,
                            (double *)&b_gpu_c.data[0], 1),
                __FILE__, __LINE__);
    k = cpu_c->size[0] * cpu_c->size[1];
    cpu_c->size[0] = mc;
    cpu_c->size[1] = nc;
    emxEnsureCapacity_real_T(cpu_c, k, &of_emlrtRTEI);
    k = mc * nc - 1;
    mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real_T(cpu_c, gpu_c, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      conv2NonSeparable_kernel45<<<grid, block>>>(b_gpu_c, k, *gpu_c);
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
    emxEnsureCapacity_real_T(cpu_expanded, k, &qf_emlrtRTEI);
    if (cpu_a->size[1] > 2147483646) {
      mc = MAX_int32_T;
    } else {
      mc = cpu_a->size[1] + 1;
    }
    k = cpu_expanded->size[0] * cpu_expanded->size[1];
    cpu_expanded->size[1] = mc - 1;
    emxEnsureCapacity_real_T(cpu_expanded, k, &qf_emlrtRTEI);
    k = ((static_cast<int32_T>(OH) + cpu_b->size[0]) - 1) * cpu_a->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real_T(cpu_expanded, &gpu_expanded, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      conv2NonSeparable_kernel46<<<grid, block>>>(k, gpu_expanded);
    }
    nc = cpu_a->size[0];
    k = cpu_y->size[0] * cpu_y->size[1];
    cpu_y->size[0] = 1;
    cpu_y->size[1] = cpu_a->size[0];
    emxEnsureCapacity_int32_T(cpu_y, k, &rf_emlrtRTEI);
    cpu_y->data[0] = 1;
    mc = 1;
    for (k = 0; k <= nc - 2; k++) {
      mc++;
      cpu_y->data[k + 1] = mc;
    }
    k = cpu_iv->size[0];
    cpu_iv->size[0] = cpu_y->size[1];
    emxEnsureCapacity_int32_T(cpu_iv, k, &qf_emlrtRTEI);
    k = cpu_y->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_int32_T(cpu_y, &gpu_y, false);
    gpuEmxEnsureCapacity_int32_T(cpu_iv, &gpu_iv, true);
    gpuEmxMemcpyCpuToGpu_int32_T(&gpu_y, cpu_y);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      conv2NonSeparable_kernel47<<<grid, block>>>(offsetH, gpu_y, k, gpu_iv);
    }
    nc = cpu_a->size[1];
    k = b_cpu_y->size[0] * b_cpu_y->size[1];
    b_cpu_y->size[0] = 1;
    b_cpu_y->size[1] = cpu_a->size[1];
    emxEnsureCapacity_int32_T(b_cpu_y, k, &rf_emlrtRTEI);
    b_cpu_y->data[0] = 1;
    mc = 1;
    for (k = 0; k <= nc - 2; k++) {
      mc++;
      b_cpu_y->data[k + 1] = mc;
    }
    k = cpu_iv1->size[0];
    cpu_iv1->size[0] = b_cpu_y->size[1];
    emxEnsureCapacity_int32_T(cpu_iv1, k, &qf_emlrtRTEI);
    k = b_cpu_y->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_int32_T(b_cpu_y, &b_gpu_y, false);
    gpuEmxEnsureCapacity_int32_T(cpu_iv1, &gpu_iv1, true);
    gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_y, b_cpu_y);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      conv2NonSeparable_kernel48<<<grid, block>>>(b_gpu_y, k, gpu_iv1);
    }
    iv[0] = cpu_iv->size[0];
    iv[1] = cpu_iv1->size[0];
    mwGetLaunchParameters1D(computeNumIters(iv[1] - 1, iv[0] - 1), &grid,
                            &block, 2147483647U);
    gpuEmxEnsureCapacity_real_T(cpu_a, gpu_a, !*a_outdatedOnGpu);
    if (*a_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real_T(gpu_a, cpu_a);
    }
    *a_outdatedOnGpu = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      conv2NonSeparable_kernel49<<<grid, block>>>(
          *gpu_a, iv[0], gpu_iv1, gpu_iv, iv[0] - 1, iv[1] - 1, gpu_expanded,
          cpu_expanded->size[0U]);
    }
    nc = cpu_b->size[0];
    k = cpu_rows->size[0] * cpu_rows->size[1];
    cpu_rows->size[0] = 1;
    cpu_rows->size[1] = cpu_b->size[0];
    emxEnsureCapacity_int32_T(cpu_rows, k, &rf_emlrtRTEI);
    cpu_rows->data[0] = 0;
    mc = 0;
    for (k = 0; k <= nc - 2; k++) {
      mc++;
      cpu_rows->data[k + 1] = mc;
    }
    k = cpu_c->size[0] * cpu_c->size[1];
    cpu_c->size[0] = static_cast<int32_T>(OH);
    cpu_c->size[1] = cpu_a->size[1];
    emxEnsureCapacity_real_T(cpu_c, k, &qf_emlrtRTEI);
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
    gpuEmxEnsureCapacity_real_T(cpu_b, gpu_b, !*b_outdatedOnGpu);
    gpuEmxEnsureCapacity_real_T(cpu_c, gpu_c, true);
    gpuEmxMemcpyCpuToGpu_int32_T(&gpu_rows, cpu_rows);
    if (*b_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real_T(gpu_b, cpu_b);
    }
    *b_outdatedOnGpu = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      conv2NonSeparable_kernel50<<<grid, block>>>(
          gpu_expanded, gpu_rows, *gpu_b, b_OH - 1, OW - 1, *gpu_c,
          cpu_b->size[0U], cpu_expanded->size[0U], cpu_c->size[0U]);
    }
  }
  emxFree_int32_T(&cpu_rows);
  emxFree_int32_T(&cpu_iv1);
  emxFree_int32_T(&b_cpu_y);
  emxFree_int32_T(&cpu_iv);
  emxFree_int32_T(&cpu_y);
  emxFree_real_T(&cpu_expanded);
  emxFree_real_T(&b_cpu_c);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  gpuEmxFree_real_T(&b_gpu_c);
  gpuEmxFree_real_T(&gpu_expanded);
  gpuEmxFree_int32_T(&gpu_y);
  gpuEmxFree_int32_T(&gpu_iv);
  gpuEmxFree_int32_T(&b_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv1);
  gpuEmxFree_int32_T(&gpu_rows);
  *c_outdatedOnCpu = true;
  *c_outdatedOnGpu = false;
}

} // namespace coder
static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel43(
    const int32_T b, emxArray_real_T c)
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
    c.data[i2] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel44(
    const int32_T b, emxArray_real_T c)
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
    c.data[i2] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel45(
    const emxArray_real_T c, const int32_T b, emxArray_real_T b_c)
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

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel46(
    const int32_T OH, emxArray_real_T expanded)
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
    expanded.data[i2] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel47(
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

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel48(
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

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel49(
    const emxArray_real_T a, const int32_T iv_dim0, const emxArray_int32_T iv1,
    const emxArray_int32_T iv, const int32_T b_iv, const int32_T c_iv,
    emxArray_real_T expanded, int32_T expanded_dim0)
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

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel50(
    const emxArray_real_T expanded, const emxArray_int32_T rows,
    const emxArray_real_T b, const int32_T c, const int32_T d,
    emxArray_real_T b_c, int32_T b_dim0, int32_T expanded_dim0, int32_T c_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(d) + 1UL) * (static_cast<uint64_T>(c) + 1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    real_T b_cv;
    int32_T ocol;
    int32_T orow;
    orow = static_cast<int32_T>(idx % (static_cast<uint64_T>(c) + 1UL));
    ocol = static_cast<int32_T>((idx - static_cast<uint64_T>(orow)) /
                                (static_cast<uint64_T>(c) + 1UL));
    b_cv = 0.0;
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

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel51(
    const int32_T b, emxArray_real_T c)
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
    c.data[orow] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel52(
    const int32_T OH, emxArray_real_T expanded)
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
    expanded.data[orow] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel53(
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

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel54(
    const emxArray_real_T a, const emxArray_int32_T iv, const int32_T b,
    emxArray_real_T expanded)
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

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel55(
    const emxArray_real_T expanded, const emxArray_int32_T rows,
    const emxArray_real_T b, const int32_T c, emxArray_real_T b_c,
    int32_T b_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    real_T b_cv;
    int32_T orow;
    orow = static_cast<int32_T>(idx);
    b_cv = 0.0;
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

static __global__ __launch_bounds__(1024, 1) void conv2_kernel28(
    const emxArray_real_T a, const int32_T b_a, emxArray_real_T c_a,
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
                                    1) void conv2_kernel29(const int32_T a,
                                                           emxArray_real_T c)
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
    c.data[ocol] = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void conv2_kernel30(
    const real_T b, const emxArray_real_T a, emxArray_real_T c)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[0] = a.data[0] * b;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2_kernel31(
    const emxArray_real_T c, const int32_T b_c, emxArray_real_T c_c,
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
    __launch_bounds__(1024, 1) void conv2_kernel32(const int32_T a,
                                                   emxArray_real_T expanded)
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
    expanded.data[ocol] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2_kernel33(
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

static __global__ __launch_bounds__(1024, 1) void conv2_kernel34(
    const emxArray_real_T a, const emxArray_int32_T iv, const int32_T b,
    emxArray_real_T expanded)
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

static __global__ __launch_bounds__(1024, 1) void conv2_kernel35(
    const real_T b, const emxArray_real_T expanded, const int32_T c,
    emxArray_real_T b_c)
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
                                    1) void conv2_kernel36(const int32_T b,
                                                           emxArray_real_T c)
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
    c.data[ocol] = 0.0;
  }
}

static __global__ __launch_bounds__(1024,
                                    1) void conv2_kernel37(const int32_T b,
                                                           emxArray_real_T c)
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
    c.data[ocol] = 0.0;
  }
}

static __global__ __launch_bounds__(32, 1) void conv2_kernel38(
    const emxArray_real_T a, const emxArray_real_T b, emxArray_real_T c)
{
  int32_T k;
  k = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (k < 1) {
    real_T b_cv;
    b_cv = b.data[0] * a.data[0];
    c.data[0] = b_cv;
  }
}

static __global__
    __launch_bounds__(1024, 1) void conv2_kernel39(const int32_T OH,
                                                   emxArray_real_T expanded)
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
    expanded.data[ocol] = 0.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2_kernel40(
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

static __global__ __launch_bounds__(1024, 1) void conv2_kernel41(
    const emxArray_real_T b, const int32_T mc, const emxArray_int32_T iv1,
    const int32_T c, emxArray_real_T expanded, int32_T expanded_dim0)
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

static __global__ __launch_bounds__(1024, 1) void conv2_kernel42(
    const emxArray_real_T expanded, const emxArray_int32_T cols,
    const emxArray_int32_T rows, const emxArray_real_T a, const int32_T b,
    const int32_T c, emxArray_real_T b_c, int32_T a_dim0, int32_T a_dim1,
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
    real_T b_cv;
    int32_T ocol;
    int32_T orow;
    orow = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    ocol = static_cast<int32_T>((idx - static_cast<uint64_T>(orow)) /
                                (static_cast<uint64_T>(b) + 1UL));
    b_cv = 0.0;
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
void b_conv2(const emxArray_real_T *cpu_a, const emxArray_real_T *cpu_b,
             emxArray_real_T *cpu_c, boolean_T *c_outdatedOnCpu,
             emxArray_real_T *gpu_c, boolean_T *c_outdatedOnGpu)
{
  emxArray_real_T gpu_a;
  emxArray_real_T gpu_b;
  boolean_T a_outdatedOnCpu;
  boolean_T a_outdatedOnGpu;
  boolean_T b_outdatedOnCpu;
  boolean_T b_outdatedOnGpu;
  gpuEmxReset_real_T(&gpu_b);
  gpuEmxReset_real_T(&gpu_a);
  b_outdatedOnCpu = false;
  b_outdatedOnGpu = true;
  a_outdatedOnCpu = false;
  a_outdatedOnGpu = true;
  if ((cpu_a->size[0] == 1) && (cpu_b->size[0] == 1)) {
    int32_T i;
    i = cpu_c->size[0];
    cpu_c->size[0] = 1;
    emxEnsureCapacity_real_T(cpu_c, i, &pf_emlrtRTEI);
    cpu_c->data[0] = cpu_a->data[0] * cpu_b->data[0];
    *c_outdatedOnCpu = false;
    *c_outdatedOnGpu = true;
  } else if (cpu_b->size[0] > cpu_a->size[0]) {
    b_conv2NonSeparable((emxArray_real_T *)cpu_b, &b_outdatedOnCpu, &gpu_b,
                        &b_outdatedOnGpu, (emxArray_real_T *)cpu_a,
                        &a_outdatedOnCpu, &gpu_a, &a_outdatedOnGpu, cpu_c,
                        c_outdatedOnCpu, gpu_c, c_outdatedOnGpu);
  } else {
    b_conv2NonSeparable((emxArray_real_T *)cpu_a, &a_outdatedOnCpu, &gpu_a,
                        &a_outdatedOnGpu, (emxArray_real_T *)cpu_b,
                        &b_outdatedOnCpu, &gpu_b, &b_outdatedOnGpu, cpu_c,
                        c_outdatedOnCpu, gpu_c, c_outdatedOnGpu);
  }
  gpuEmxFree_real_T(&gpu_a);
  gpuEmxFree_real_T(&gpu_b);
}

//
//
void conv2(const emxArray_real_T *cpu_a, emxArray_real_T *cpu_b,
           boolean_T *b_outdatedOnCpu, emxArray_real_T *gpu_b,
           boolean_T *b_outdatedOnGpu, emxArray_real_T *cpu_c,
           boolean_T *c_outdatedOnCpu, emxArray_real_T *gpu_c,
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
  emxArray_real_T b_gpu_a;
  emxArray_real_T b_gpu_c;
  emxArray_real_T b_gpu_expanded;
  emxArray_real_T gpu_a;
  emxArray_real_T gpu_expanded;
  emxArray_real_T *b_cpu_a;
  emxArray_real_T *b_cpu_c;
  emxArray_real_T *b_cpu_expanded;
  emxArray_real_T *cpu_expanded;
  boolean_T a_outdatedOnGpu;
  gpuEmxReset_int32_T(&gpu_cols);
  gpuEmxReset_int32_T(&gpu_rows);
  gpuEmxReset_int32_T(&gpu_iv1);
  gpuEmxReset_int32_T(&gpu_iv);
  gpuEmxReset_int32_T(&b_gpu_y);
  gpuEmxReset_real_T(&b_gpu_expanded);
  gpuEmxReset_int32_T(&gpu_y);
  gpuEmxReset_real_T(&gpu_expanded);
  gpuEmxReset_real_T(&b_gpu_a);
  gpuEmxReset_real_T(&b_gpu_c);
  gpuEmxReset_real_T(&gpu_a);
  a_outdatedOnGpu = true;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&b_cpu_c, 1, &sf_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_a, 1, &lf_emlrtRTEI, true);
  emxInit_real_T(&cpu_expanded, 1, &qf_emlrtRTEI, true);
  emxInit_int32_T(&cpu_y, 2, &tf_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_expanded, 2, &qf_emlrtRTEI, true);
  emxInit_int32_T(&b_cpu_y, 2, &tf_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv, 1, &qf_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv1, 1, &qf_emlrtRTEI, true);
  emxInit_int32_T(&cpu_rows, 2, &qf_emlrtRTEI, true);
  emxInit_int32_T(&cpu_cols, 2, &qf_emlrtRTEI, true);
  if ((cpu_a->size[0] == 1) && (cpu_b->size[0] == 1)) {
    if (cpu_a->size[1] < 1) {
      int32_T k;
      k = cpu_c->size[0] * cpu_c->size[1];
      cpu_c->size[0] = 1;
      cpu_c->size[1] = 1;
      emxEnsureCapacity_real_T(cpu_c, k, &nf_emlrtRTEI);
      cpu_c->data[0] = 0.0;
      *c_outdatedOnCpu = false;
      *c_outdatedOnGpu = true;
    } else {
      real_T b;
      int32_T k;
      boolean_T validLaunchParams;
      k = b_cpu_a->size[0];
      b_cpu_a->size[0] = cpu_a->size[1];
      emxEnsureCapacity_real_T(b_cpu_a, k, &lf_emlrtRTEI);
      k = cpu_a->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(cpu_a, &gpu_a, false);
      gpuEmxEnsureCapacity_real_T(b_cpu_a, &b_gpu_a, true);
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_a, cpu_a);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2_kernel28<<<grid, block>>>(gpu_a, k, b_gpu_a, cpu_a->size[0U]);
      }
      if (*b_outdatedOnCpu) {
        gpuEmxMemcpyGpuToCpu_real_T(cpu_b, gpu_b);
      }
      *b_outdatedOnCpu = false;
      b = cpu_b->data[0];
      k = b_cpu_c->size[0];
      b_cpu_c->size[0] = b_cpu_a->size[0];
      emxEnsureCapacity_real_T(b_cpu_c, k, &of_emlrtRTEI);
      k = b_cpu_a->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(b_cpu_c, &b_gpu_c, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2_kernel29<<<grid, block>>>(k, b_gpu_c);
      }
      if (b_cpu_a->size[0] == 1) {
        b = cpu_b->data[0];
        k = b_cpu_c->size[0];
        b_cpu_c->size[0] = 1;
        emxEnsureCapacity_real_T(b_cpu_c, k, &of_emlrtRTEI);
        gpuEmxEnsureCapacity_real_T(b_cpu_c, &b_gpu_c, true);
        conv2_kernel30<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(b, b_gpu_a,
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
        emxEnsureCapacity_real_T(cpu_expanded, k, &qf_emlrtRTEI);
        k = b_cpu_a->size[0] - 1;
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        gpuEmxEnsureCapacity_real_T(cpu_expanded, &gpu_expanded, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          conv2_kernel32<<<grid, block>>>(k, gpu_expanded);
        }
        nc = b_cpu_a->size[0];
        k = cpu_y->size[0] * cpu_y->size[1];
        cpu_y->size[0] = 1;
        cpu_y->size[1] = b_cpu_a->size[0];
        emxEnsureCapacity_int32_T(cpu_y, k, &rf_emlrtRTEI);
        cpu_y->data[0] = 1;
        mc = 1;
        for (k = 0; k <= nc - 2; k++) {
          mc++;
          cpu_y->data[k + 1] = mc;
        }
        k = cpu_iv->size[0];
        cpu_iv->size[0] = cpu_y->size[1];
        emxEnsureCapacity_int32_T(cpu_iv, k, &qf_emlrtRTEI);
        k = cpu_y->size[1] - 1;
        mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
        gpuEmxEnsureCapacity_int32_T(cpu_y, &gpu_y, false);
        gpuEmxEnsureCapacity_int32_T(cpu_iv, &gpu_iv, true);
        gpuEmxMemcpyCpuToGpu_int32_T(&gpu_y, cpu_y);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          conv2_kernel33<<<grid, block>>>(gpu_y, k, gpu_iv);
        }
        nc = cpu_iv->size[0];
        mwGetLaunchParameters1D(computeNumIters(nc - 1), &grid, &block,
                                2147483647U);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          conv2_kernel34<<<grid, block>>>(b_gpu_a, gpu_iv, nc - 1,
                                          gpu_expanded);
        }
        k = b_cpu_c->size[0];
        b_cpu_c->size[0] = b_cpu_a->size[0];
        emxEnsureCapacity_real_T(b_cpu_c, k, &qf_emlrtRTEI);
        mwApplyLaunchParameters(
            computeNumIters(b_OH - 1),
            dim3(static_cast<uint32_T>(offsetH), 1U, 1U),
            dim3(static_cast<uint32_T>(threadDims[0]), 1U, 1U), &grid, &block);
        gpuEmxEnsureCapacity_real_T(b_cpu_c, &b_gpu_c, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          conv2_kernel35<<<grid, block>>>(b, gpu_expanded, b_OH - 1, b_gpu_c);
        }
      }
      k = cpu_c->size[0] * cpu_c->size[1];
      cpu_c->size[0] = 1;
      cpu_c->size[1] = b_cpu_c->size[0];
      emxEnsureCapacity_real_T(cpu_c, k, &pf_emlrtRTEI);
      k = b_cpu_c->size[0] - 1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(cpu_c, gpu_c, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2_kernel31<<<grid, block>>>(b_gpu_c, k, *gpu_c, cpu_c->size[0U]);
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
    emxEnsureCapacity_real_T(cpu_c, k, &mf_emlrtRTEI);
    k = mc * nc - 1;
    mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
    gpuEmxEnsureCapacity_real_T(cpu_c, gpu_c, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      conv2_kernel36<<<grid, block>>>(k, *gpu_c);
    }
    if ((cpu_a->size[0] == 0) || (cpu_a->size[1] == 0)) {
      k = cpu_c->size[0] * cpu_c->size[1];
      cpu_c->size[0] = mc;
      cpu_c->size[1] = nc;
      emxEnsureCapacity_real_T(cpu_c, k, &mf_emlrtRTEI);
      k = mc * nc - 1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(cpu_c, gpu_c, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2_kernel37<<<grid, block>>>(k, *gpu_c);
      }
      *c_outdatedOnGpu = false;
      *c_outdatedOnCpu = true;
    } else if ((cpu_b->size[0] == 1) &&
               ((cpu_a->size[0] == 1) && (cpu_a->size[1] == 1))) {
      k = cpu_c->size[0] * cpu_c->size[1];
      cpu_c->size[0] = 1;
      cpu_c->size[1] = 1;
      emxEnsureCapacity_real_T(cpu_c, k, &mf_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(cpu_a, &gpu_a, false);
      gpuEmxEnsureCapacity_real_T(cpu_b, gpu_b, !*b_outdatedOnGpu);
      gpuEmxEnsureCapacity_real_T(cpu_c, gpu_c, true);
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_a, cpu_a);
      if (*b_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real_T(gpu_b, cpu_b);
      }
      *b_outdatedOnGpu = false;
      conv2_kernel38<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(gpu_a, *gpu_b,
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
      emxEnsureCapacity_real_T(b_cpu_expanded, k, &qf_emlrtRTEI);
      if (cpu_a->size[1] > MAX_int32_T - cpu_a->size[1]) {
        mc = MAX_int32_T;
      } else {
        mc = cpu_a->size[1] + cpu_a->size[1];
      }
      k = b_cpu_expanded->size[0] * b_cpu_expanded->size[1];
      b_cpu_expanded->size[1] = mc - 1;
      emxEnsureCapacity_real_T(b_cpu_expanded, k, &qf_emlrtRTEI);
      k = ((static_cast<int32_T>(OH) + cpu_a->size[0]) - 1) *
              ((cpu_a->size[1] + cpu_a->size[1]) - 1) -
          1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(b_cpu_expanded, &b_gpu_expanded, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2_kernel39<<<grid, block>>>(k, b_gpu_expanded);
      }
      nc = cpu_b->size[0];
      k = b_cpu_y->size[0] * b_cpu_y->size[1];
      b_cpu_y->size[0] = 1;
      b_cpu_y->size[1] = cpu_b->size[0];
      emxEnsureCapacity_int32_T(b_cpu_y, k, &rf_emlrtRTEI);
      b_cpu_y->data[0] = 1;
      mc = 1;
      for (k = 0; k <= nc - 2; k++) {
        mc++;
        b_cpu_y->data[k + 1] = mc;
      }
      k = cpu_iv1->size[0];
      cpu_iv1->size[0] = b_cpu_y->size[1];
      emxEnsureCapacity_int32_T(cpu_iv1, k, &qf_emlrtRTEI);
      k = b_cpu_y->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(k), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_int32_T(b_cpu_y, &b_gpu_y, false);
      gpuEmxEnsureCapacity_int32_T(cpu_iv1, &gpu_iv1, true);
      gpuEmxMemcpyCpuToGpu_int32_T(&b_gpu_y, b_cpu_y);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2_kernel40<<<grid, block>>>(offsetH, b_gpu_y, k, gpu_iv1);
      }
      mc = static_cast<int32_T>(
               std::floor(static_cast<real_T>(cpu_a->size[1]) / 2.0)) +
           static_cast<int32_T>(
               std::floor((static_cast<real_T>(cpu_a->size[1]) - 1.0) / 2.0));
      nc = cpu_iv1->size[0];
      mwGetLaunchParameters1D(computeNumIters(nc - 1), &grid, &block,
                              2147483647U);
      gpuEmxEnsureCapacity_real_T(cpu_b, gpu_b, !*b_outdatedOnGpu);
      if (*b_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real_T(gpu_b, cpu_b);
      }
      *b_outdatedOnGpu = false;
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2_kernel41<<<grid, block>>>(*gpu_b, mc, gpu_iv1, nc - 1,
                                        b_gpu_expanded,
                                        b_cpu_expanded->size[0U]);
      }
      nc = cpu_a->size[0];
      k = cpu_rows->size[0] * cpu_rows->size[1];
      cpu_rows->size[0] = 1;
      cpu_rows->size[1] = cpu_a->size[0];
      emxEnsureCapacity_int32_T(cpu_rows, k, &rf_emlrtRTEI);
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
      emxEnsureCapacity_int32_T(cpu_cols, k, &rf_emlrtRTEI);
      cpu_cols->data[0] = 0;
      mc = 0;
      for (k = 0; k <= nc - 2; k++) {
        mc++;
        cpu_cols->data[k + 1] = mc;
      }
      k = cpu_c->size[0] * cpu_c->size[1];
      cpu_c->size[0] = static_cast<int32_T>(OH);
      cpu_c->size[1] = cpu_a->size[1];
      emxEnsureCapacity_real_T(cpu_c, k, &qf_emlrtRTEI);
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
      gpuEmxEnsureCapacity_real_T(cpu_a, &gpu_a, false);
      gpuEmxEnsureCapacity_real_T(cpu_c, gpu_c, true);
      gpuEmxMemcpyCpuToGpu_int32_T(&gpu_cols, cpu_cols);
      gpuEmxMemcpyCpuToGpu_int32_T(&gpu_rows, cpu_rows);
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_a, cpu_a);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2_kernel42<<<grid, block>>>(
            b_gpu_expanded, gpu_cols, gpu_rows, gpu_a, b_OH - 1, OW - 1, *gpu_c,
            cpu_a->size[0U], cpu_a->size[1U], b_cpu_expanded->size[0U],
            cpu_c->size[0U]);
      }
      *c_outdatedOnGpu = false;
      *c_outdatedOnCpu = true;
    }
  } else {
    conv2NonSeparable((emxArray_real_T *)cpu_a, &gpu_a, &a_outdatedOnGpu, cpu_b,
                      gpu_b, b_outdatedOnGpu, cpu_c, c_outdatedOnCpu, gpu_c,
                      c_outdatedOnGpu);
  }
  emxFree_int32_T(&cpu_cols);
  emxFree_int32_T(&cpu_rows);
  emxFree_int32_T(&cpu_iv1);
  emxFree_int32_T(&cpu_iv);
  emxFree_int32_T(&b_cpu_y);
  emxFree_real_T(&b_cpu_expanded);
  emxFree_int32_T(&cpu_y);
  emxFree_real_T(&cpu_expanded);
  emxFree_real_T(&b_cpu_a);
  emxFree_real_T(&b_cpu_c);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  gpuEmxFree_real_T(&gpu_a);
  gpuEmxFree_real_T(&b_gpu_c);
  gpuEmxFree_real_T(&b_gpu_a);
  gpuEmxFree_real_T(&gpu_expanded);
  gpuEmxFree_int32_T(&gpu_y);
  gpuEmxFree_real_T(&b_gpu_expanded);
  gpuEmxFree_int32_T(&b_gpu_y);
  gpuEmxFree_int32_T(&gpu_iv);
  gpuEmxFree_int32_T(&gpu_iv1);
  gpuEmxFree_int32_T(&gpu_rows);
  gpuEmxFree_int32_T(&gpu_cols);
}

} // namespace coder

// End of code generation (conv2.cu)
