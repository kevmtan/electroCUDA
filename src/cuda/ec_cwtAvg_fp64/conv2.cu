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
#include "ec_cwtAvg_data.h"
#include "ec_cwtAvg_emxutil.h"
#include "ec_cwtAvg_mexutil.h"
#include "ec_cwtAvg_types.h"
#include "rt_nonfinite.h"
#include "MWCUBLASUtils.hpp"
#include "MWCudaDimUtility.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include <cmath>

// Variable Definitions
static emlrtRTEInfo kf_emlrtRTEI{
    75,                                                               // lineNo
    5,                                                                // colNo
    "conv2",                                                          // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/conv2.m" // pName
};

static emlrtRTEInfo
    lf_emlrtRTEI{
        158,      // lineNo
        24,       // colNo
        "mtimes", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+blas/"
        "mtimes.m" // pName
    };

static emlrtRTEInfo mf_emlrtRTEI{
    1,                  // lineNo
    1,                  // colNo
    "gpu_conv2_kernel", // fName
    "/usr/local/MATLAB/R2024a/toolbox/gpucoder/gpucoder/+coder/+internal/"
    "+images/gpu_conv2_kernel.p" // pName
};

// Function Declarations
static __global__ void conv2NonSeparable_kernel35(const int32_T b,
                                                  emxArray_real_T c);

static __global__ void conv2NonSeparable_kernel36(const emxArray_real_T c,
                                                  const int32_T b,
                                                  emxArray_real_T b_c);

static __global__ void conv2NonSeparable_kernel37(const int32_T OH,
                                                  emxArray_real_T expanded);

static __global__ void conv2NonSeparable_kernel38(const int32_T offsetH,
                                                  const emxArray_int32_T y,
                                                  const int32_T b_y,
                                                  emxArray_int32_T iv);

static __global__ void conv2NonSeparable_kernel39(const emxArray_real_T a,
                                                  const emxArray_int32_T iv,
                                                  const int32_T b,
                                                  emxArray_real_T expanded);

static __global__ void
conv2NonSeparable_kernel40(const emxArray_real_T expanded,
                           const emxArray_int32_T rows, const emxArray_real_T b,
                           const int32_T c, emxArray_real_T b_c,
                           int32_T b_dim0);

// Function Definitions
static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel35(
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

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel36(
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

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel37(
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

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel38(
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

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel39(
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
    int32_T i2;
    i2 = static_cast<int32_T>(idx);
    expanded.data[iv.data[i2]] = a.data[i2];
  }
}

static __global__ __launch_bounds__(1024, 1) void conv2NonSeparable_kernel40(
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
    orow = static_cast<int32_T>(idx % (static_cast<uint64_T>(c) + 1UL));
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

//
//
namespace coder {
void conv2NonSeparable(const emxArray_real_T *cpu_a, emxArray_real_T *cpu_b,
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
  emxArray_real_T b_gpu_c;
  emxArray_real_T gpu_a;
  emxArray_real_T gpu_expanded;
  emxArray_real_T *b_cpu_c;
  emxArray_real_T *cpu_expanded;
  int32_T k;
  int32_T mc;
  boolean_T validLaunchParams;
  gpuEmxReset_int32_T(&gpu_rows);
  gpuEmxReset_int32_T(&gpu_iv);
  gpuEmxReset_int32_T(&gpu_y);
  gpuEmxReset_real_T(&gpu_expanded);
  gpuEmxReset_real_T(&b_gpu_c);
  gpuEmxReset_real_T(&gpu_a);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  if ((cpu_a->size[0] == 0) || (cpu_b->size[0] == 0)) {
    mc = cpu_a->size[0] + cpu_b->size[0];
  } else {
    mc = (cpu_a->size[0] + cpu_b->size[0]) - 1;
  }
  k = cpu_c->size[0] * cpu_c->size[1];
  cpu_c->size[0] = mc;
  cpu_c->size[1] = 1;
  emxEnsureCapacity_real_T(cpu_c, k, &kf_emlrtRTEI);
  mwGetLaunchParameters1D(computeNumIters(mc - 1), &grid, &block, 2147483647U);
  gpuEmxEnsureCapacity_real_T(cpu_c, gpu_c, true);
  validLaunchParams = mwValidateLaunchParameters(grid, block);
  if (validLaunchParams) {
    conv2NonSeparable_kernel35<<<grid, block>>>(mc - 1, *gpu_c);
  }
  emxInit_real_T(&b_cpu_c, 1, &mf_emlrtRTEI, true);
  emxInit_real_T(&cpu_expanded, 2, &kd_emlrtRTEI, true);
  emxInit_int32_T(&cpu_y, 2, &sd_emlrtRTEI, true);
  emxInit_int32_T(&cpu_iv, 1, &kd_emlrtRTEI, true);
  emxInit_int32_T(&cpu_rows, 2, &kd_emlrtRTEI, true);
  if ((cpu_a->size[0] != 0) && (cpu_b->size[0] != 0)) {
    if ((cpu_a->size[0] == 1) && (cpu_b->size[0] == 1)) {
      real_T alpha1;
      real_T beta1;
      k = b_cpu_c->size[0];
      b_cpu_c->size[0] = 1;
      emxEnsureCapacity_real_T(b_cpu_c, k, &lf_emlrtRTEI);
      alpha1 = 1.0;
      beta1 = 0.0;
      gpuEmxEnsureCapacity_real_T(cpu_a, &gpu_a, false);
      gpuEmxEnsureCapacity_real_T(cpu_b, gpu_b, !*b_outdatedOnGpu);
      gpuEmxEnsureCapacity_real_T(b_cpu_c, &b_gpu_c, true);
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_a, cpu_a);
      if (*b_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real_T(gpu_b, cpu_b);
      }
      *b_outdatedOnGpu = false;
      cublasCheck(cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                              1, 1, 1, (double *)&alpha1,
                              (double *)&gpu_a.data[0], 1,
                              (double *)&gpu_b->data[0], 1, (double *)&beta1,
                              (double *)&b_gpu_c.data[0], 1),
                  __FILE__, __LINE__);
      k = cpu_c->size[0] * cpu_c->size[1];
      cpu_c->size[0] = mc;
      cpu_c->size[1] = 1;
      emxEnsureCapacity_real_T(cpu_c, k, &kf_emlrtRTEI);
      mwGetLaunchParameters1D(computeNumIters(mc - 1), &grid, &block,
                              2147483647U);
      gpuEmxEnsureCapacity_real_T(cpu_c, gpu_c, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2NonSeparable_kernel36<<<grid, block>>>(b_gpu_c, mc - 1, *gpu_c);
      }
    } else {
      real_T blockDims[3];
      int32_T b_OH;
      int32_T n;
      int32_T offsetH;
      uint32_T OH;
      int8_T threadDims[3];
      OH = (static_cast<uint32_T>(cpu_a->size[0]) +
            static_cast<uint32_T>(cpu_b->size[0])) -
           1U;
      mc = static_cast<int32_T>(std::fmin(32.0, static_cast<real_T>(OH)));
      blockDims[0] = std::floor(
          (static_cast<real_T>(OH) + (static_cast<real_T>(mc) - 1.0)) /
          static_cast<real_T>(mc));
      threadDims[0] = static_cast<int8_T>(mc);
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
      cpu_expanded->size[1] = 1;
      emxEnsureCapacity_real_T(cpu_expanded, k, &kd_emlrtRTEI);
      mc = (static_cast<int32_T>(OH) + cpu_b->size[0]) - 2;
      mwGetLaunchParameters1D(computeNumIters(mc), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_real_T(cpu_expanded, &gpu_expanded, true);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2NonSeparable_kernel37<<<grid, block>>>(mc, gpu_expanded);
      }
      n = cpu_a->size[0];
      k = cpu_y->size[0] * cpu_y->size[1];
      cpu_y->size[0] = 1;
      cpu_y->size[1] = cpu_a->size[0];
      emxEnsureCapacity_int32_T(cpu_y, k, &ld_emlrtRTEI);
      cpu_y->data[0] = 1;
      mc = 1;
      for (k = 0; k <= n - 2; k++) {
        mc++;
        cpu_y->data[k + 1] = mc;
      }
      k = cpu_iv->size[0];
      cpu_iv->size[0] = cpu_y->size[1];
      emxEnsureCapacity_int32_T(cpu_iv, k, &kd_emlrtRTEI);
      mc = cpu_y->size[1] - 1;
      mwGetLaunchParameters1D(computeNumIters(mc), &grid, &block, 2147483647U);
      gpuEmxEnsureCapacity_int32_T(cpu_y, &gpu_y, false);
      gpuEmxEnsureCapacity_int32_T(cpu_iv, &gpu_iv, true);
      gpuEmxMemcpyCpuToGpu_int32_T(&gpu_y, cpu_y);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2NonSeparable_kernel38<<<grid, block>>>(offsetH, gpu_y, mc, gpu_iv);
      }
      mc = cpu_iv->size[0];
      mwGetLaunchParameters1D(computeNumIters(mc - 1), &grid, &block,
                              2147483647U);
      gpuEmxEnsureCapacity_real_T(cpu_a, &gpu_a, false);
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_a, cpu_a);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        conv2NonSeparable_kernel39<<<grid, block>>>(gpu_a, gpu_iv, mc - 1,
                                                    gpu_expanded);
      }
      n = cpu_b->size[0];
      k = cpu_rows->size[0] * cpu_rows->size[1];
      cpu_rows->size[0] = 1;
      cpu_rows->size[1] = cpu_b->size[0];
      emxEnsureCapacity_int32_T(cpu_rows, k, &ld_emlrtRTEI);
      cpu_rows->data[0] = 0;
      mc = 0;
      for (k = 0; k <= n - 2; k++) {
        mc++;
        cpu_rows->data[k + 1] = mc;
      }
      k = cpu_c->size[0] * cpu_c->size[1];
      cpu_c->size[0] = static_cast<int32_T>(OH);
      cpu_c->size[1] = 1;
      emxEnsureCapacity_real_T(cpu_c, k, &kd_emlrtRTEI);
      if (blockDims[0] < 4.294967296E+9) {
        OH = static_cast<uint32_T>(blockDims[0]);
      } else {
        OH = MAX_uint32_T;
      }
      mwApplyLaunchParameters(
          computeNumIters(0, b_OH - 1), dim3(OH, 1U, 1U),
          dim3(static_cast<uint32_T>(threadDims[0]), 1U, 1U), &grid, &block);
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
        conv2NonSeparable_kernel40<<<grid, block>>>(
            gpu_expanded, gpu_rows, *gpu_b, b_OH - 1, *gpu_c, cpu_b->size[0U]);
      }
    }
  }
  emxFree_int32_T(&cpu_rows);
  emxFree_int32_T(&cpu_iv);
  emxFree_int32_T(&cpu_y);
  emxFree_real_T(&cpu_expanded);
  emxFree_real_T(&b_cpu_c);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  gpuEmxFree_real_T(&gpu_a);
  gpuEmxFree_real_T(&b_gpu_c);
  gpuEmxFree_real_T(&gpu_expanded);
  gpuEmxFree_int32_T(&gpu_y);
  gpuEmxFree_int32_T(&gpu_iv);
  gpuEmxFree_int32_T(&gpu_rows);
  *c_outdatedOnCpu = true;
  *c_outdatedOnGpu = false;
}

} // namespace coder

// End of code generation (conv2.cu)
