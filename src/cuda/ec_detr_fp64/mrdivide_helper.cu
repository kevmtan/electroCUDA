//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// mrdivide_helper.cu
//
// Code generation for function 'mrdivide_helper'
//

// Include files
#include "mrdivide_helper.h"
#include "ec_detr_fp_data.h"
#include "ec_detr_fp_emxutil.h"
#include "ec_detr_fp_mexutil.h"
#include "ec_detr_fp_types.h"
#include "rt_nonfinite.h"
#include "MWCUBLASUtils.hpp"
#include "MWCUSOLVERUtils.hpp"
#include "MWCudaDimUtility.hpp"
#include "MWCudaMemoryFunctions.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include "MWLocationStringifyNvtx3.h"
#include "lapacke.h"
#include "math_constants.h"
#include "nvtx3/nvToolsExt.h"
#include <algorithm>
#include <cmath>
#include <cstddef>
#include <cstring>

// Variable Definitions
static emlrtRTEInfo jd_emlrtRTEI{
    31,                // lineNo
    5,                 // colNo
    "mrdivide_helper", // fName
    "/usr/local/MATLAB/R2024b/toolbox/eml/eml/+coder/+internal/"
    "mrdivide_helper.m" // pName
};

static emlrtRTEInfo
    kd_emlrtRTEI{
        1,        // lineNo
        37,       // colNo
        "xgetrf", // fName
        "/usr/local/MATLAB/R2024b/toolbox/eml/eml/+coder/+internal/+lapack/"
        "xgetrf.m" // pName
    };

static emlrtRTEInfo ld_emlrtRTEI{
    44,                // lineNo
    32,                // colNo
    "mrdivide_helper", // fName
    "/usr/local/MATLAB/R2024b/toolbox/eml/eml/+coder/+internal/"
    "mrdivide_helper.m" // pName
};

static emlrtRTEInfo md_emlrtRTEI{
    1,            // lineNo
    1,            // colNo
    "xgetrf_gpu", // fName
    "/usr/local/MATLAB/R2024b/toolbox/gpucoder/gpucoder/+coder/+internal/"
    "+lapack/xgetrf_gpu.p" // pName
};

static emlrtRTEInfo nd_emlrtRTEI{
    44,                // lineNo
    35,                // colNo
    "mrdivide_helper", // fName
    "/usr/local/MATLAB/R2024b/toolbox/eml/eml/+coder/+internal/"
    "mrdivide_helper.m" // pName
};

static emlrtRTEInfo
    od_emlrtRTEI{
        61,       // lineNo
        9,        // colNo
        "xgeqp3", // fName
        "/usr/local/MATLAB/R2024b/toolbox/eml/eml/+coder/+internal/+lapack/"
        "xgeqp3.m" // pName
    };

static emlrtRTEInfo
    pd_emlrtRTEI{
        92,       // lineNo
        22,       // colNo
        "xgeqp3", // fName
        "/usr/local/MATLAB/R2024b/toolbox/eml/eml/+coder/+internal/+lapack/"
        "xgeqp3.m" // pName
    };

static emlrtRTEInfo
    qd_emlrtRTEI{
        105,      // lineNo
        1,        // colNo
        "xgeqp3", // fName
        "/usr/local/MATLAB/R2024b/toolbox/eml/eml/+coder/+internal/+lapack/"
        "xgeqp3.m" // pName
    };

static emlrtRTEInfo rd_emlrtRTEI{
    85,        // lineNo
    1,         // colNo
    "qrsolve", // fName
    "/usr/local/MATLAB/R2024b/toolbox/eml/eml/+coder/+internal/qrsolve.m" // pName
};

static emlrtRTEInfo sd_emlrtRTEI{
    119,       // lineNo
    5,         // colNo
    "qrsolve", // fName
    "/usr/local/MATLAB/R2024b/toolbox/eml/eml/+coder/+internal/qrsolve.m" // pName
};

static emlrtRTEInfo td_emlrtRTEI{
    44,                // lineNo
    5,                 // colNo
    "mrdivide_helper", // fName
    "/usr/local/MATLAB/R2024b/toolbox/eml/eml/+coder/+internal/"
    "mrdivide_helper.m" // pName
};

static emlrtRTEInfo ud_emlrtRTEI{
    44,                // lineNo
    9,                 // colNo
    "mrdivide_helper", // fName
    "/usr/local/MATLAB/R2024b/toolbox/eml/eml/+coder/+internal/"
    "mrdivide_helper.m" // pName
};

static emlrtRTEInfo vd_emlrtRTEI{
    25,                // lineNo
    14,                // colNo
    "mrdivide_helper", // fName
    "/usr/local/MATLAB/R2024b/toolbox/eml/eml/+coder/+internal/"
    "mrdivide_helper.m" // pName
};

// Function Declarations
static void cpuEmxAllocateOrResize_real_T(emxArray_real_T *cpu,
                                          boolean_T needsCopy);

static void gpuEmxMemcpyGpuToCpu_int32_T(emxArray_int32_T *cpu,
                                         emxArray_int32_T *gpu);

static __global__ void mrdiv_kernel31(const int32_T b, const int32_T c,
                                      emxArray_real_T A, int32_T A_dim0);

static __global__ void mrdiv_kernel32(const emxArray_real_T B,
                                      const emxArray_int32_T jpvt,
                                      const int32_T na, emxArray_real_T Y);

// Function Definitions
static void cpuEmxAllocateOrResize_real_T(emxArray_real_T *cpu,
                                          boolean_T needsCopy)
{
  int32_T i;
  int32_T totalSizeCpu;
  void *newData;
  nvtxRangePushA("#fcn#cpuEmxAllocateOrResize_real_T#" MW_AT_LOCATION);
  totalSizeCpu = 1;
  i = 0;
  nvtxRangePushA(
      "#loop#cpuEmxAllocateOrResize_real_T_whileloop_0##" MW_AT_LINE);
  while (i < cpu->numDimensions) {
    totalSizeCpu *= cpu->size[i];
    i++;
  }
  nvtxRangePop();
  if (cpu->allocatedSize < totalSizeCpu) {
    newData =
        emlrtCallocMex(static_cast<uint32_T>(totalSizeCpu), sizeof(real_T));
    needsCopy = (needsCopy && (totalSizeCpu > 0));
    if (needsCopy) {
      std::copy(cpu->data, cpu->data + static_cast<uint32_T>(totalSizeCpu),
                static_cast<real_T *>(newData));
    }
    if (cpu->canFreeData) {
      emlrtFreeMex(cpu->data);
    }
    cpu->data = static_cast<real_T *>(newData);
    cpu->allocatedSize = totalSizeCpu;
    cpu->canFreeData = true;
  }
  nvtxRangePop();
}

static void gpuEmxMemcpyGpuToCpu_int32_T(emxArray_int32_T *cpu,
                                         emxArray_int32_T *gpu)
{
  int32_T actualSize;
  int32_T i;
  nvtxRangePushA("#fcn#gpuEmxMemcpyGpuToCpu_int32_T#" MW_AT_LOCATION);
  actualSize = 1;
  i = 0;
  nvtxRangePushA("#loop#gpuEmxMemcpyGpuToCpu_int32_T_whileloop_0##" MW_AT_LINE);
  while (i < cpu->numDimensions) {
    actualSize *= cpu->size[i];
    i++;
  }
  nvtxRangePop();
  if (gpu->data) {
    nvtxMarkA("#checkCudaError#" MW_AT_LINE);
    nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
    checkCudaError(
        cudaMemcpy(cpu->data, gpu->data,
                   static_cast<uint32_T>(actualSize) * sizeof(int32_T),
                   cudaMemcpyDeviceToHost),
        __FILE__, __LINE__);
  }
  nvtxRangePop();
}

static __global__ __launch_bounds__(1024, 1) void mrdiv_kernel31(
    const int32_T b, const int32_T c, emxArray_real_T A, int32_T A_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(c) + 1UL) * (static_cast<uint64_T>(b) + 1UL) - 1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    int32_T j;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    j = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
                             (static_cast<uint64_T>(b) + 1UL));
    A.data[j * A_dim0 + i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void mrdiv_kernel32(
    const emxArray_real_T B, const emxArray_int32_T jpvt, const int32_T na,
    emxArray_real_T Y)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(na);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    i = static_cast<int32_T>(idx);
    Y.data[jpvt.data[i] - 1] = B.data[i];
  }
}

//
//
namespace coder {
namespace internal {
void mrdiv(emxArray_real_T *cpu_A, boolean_T *A_outdatedOnCpu,
           emxArray_real_T *gpu_A, boolean_T *A_outdatedOnGpu,
           const emxArray_real_T *B)
{
  dim3 block;
  dim3 grid;
  emxArray_int32_T gpu_ipiv_t;
  emxArray_int32_T gpu_jpvt;
  emxArray_int32_T *cpu_ipiv_t;
  emxArray_int32_T *cpu_jpvt;
  emxArray_int32_T *ipiv;
  emxArray_ptrdiff_t *jpvt_t;
  emxArray_real_T b_gpu_A;
  emxArray_real_T c_gpu_A;
  emxArray_real_T gpu_B;
  emxArray_real_T gpu_Y;
  emxArray_real_T gpu_tau;
  emxArray_real_T *b_cpu_A;
  emxArray_real_T *c_cpu_A;
  emxArray_real_T *cpu_B;
  emxArray_real_T *cpu_Y;
  emxArray_real_T *cpu_tau;
  int32_T cpu_minmn;
  int32_T *gpu_minmn;
  boolean_T A_needsCpuEnsureCapacity;
  nvtxRangePushA("#fcn#mrdiv#" MW_AT_LOCATION "#I2003");
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaMalloc#" MW_AT_LINE);
  checkCudaError(mwCudaMalloc(&gpu_minmn, 4UL), __FILE__, __LINE__);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_tau);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&gpu_ipiv_t);
  nvtxMarkA("#gpuEmxReset_int32_T#" MW_AT_LINE);
  gpuEmxReset_int32_T(&gpu_jpvt);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&b_gpu_A);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_B);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&c_gpu_A);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_Y);
  A_needsCpuEnsureCapacity = true;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_Y, 1, &ud_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&b_cpu_A, 2, &vd_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_B, 1, &nd_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&c_cpu_A, 2, &vd_emlrtRTEI, true);
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&ipiv, 2, &vd_emlrtRTEI, true);
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&cpu_jpvt, 2, &vd_emlrtRTEI, true);
  nvtxMarkA("#emxInit_int32_T#" MW_AT_LINE);
  emxInit_int32_T(&cpu_ipiv_t, 1, &md_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_tau, 1, &vd_emlrtRTEI, true);
  nvtxMarkA("#emxInit_ptrdiff_t#" MW_AT_LINE);
  emxInit_ptrdiff_t(&jpvt_t, 1, &qd_emlrtRTEI, true);
  if ((cpu_A->size[1] == 0) || ((B->size[0] == 0) || (B->size[1] == 0))) {
    int32_T i;
    cpu_minmn = B->size[0];
    i = cpu_A->size[0] * cpu_A->size[1];
    cpu_A->size[0] = 1;
    cpu_A->size[1] = B->size[0];
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(cpu_A, i, &jd_emlrtRTEI);
    if (cpu_minmn - 1 >= 0) {
      if (*A_outdatedOnCpu) {
        nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
        gpuEmxMemcpyGpuToCpu_real_T(cpu_A, gpu_A);
      }
      std::memset(&cpu_A->data[0], 0,
                  static_cast<uint32_T>(cpu_minmn) * sizeof(real_T));
      *A_outdatedOnCpu = false;
      *A_outdatedOnGpu = true;
    }
  } else if (B->size[0] == B->size[1]) {
    real_T tol;
    int32_T i;
    boolean_T A_needsGpuEnsureCapacity;
    boolean_T b_A_outdatedOnCpu;
    boolean_T b_A_outdatedOnGpu;
    b_A_outdatedOnGpu = false;
    i = c_cpu_A->size[0] * c_cpu_A->size[1];
    c_cpu_A->size[0] = B->size[0];
    c_cpu_A->size[1] = B->size[1];
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(c_cpu_A, i, &kd_emlrtRTEI);
    profileLoopStart("mrdiv_loop_1", __LINE__,
                     (B->size[0] * B->size[1] - 1) + 1, "");
    for (i = 0; i < B->size[0] * B->size[1]; i++) {
      c_cpu_A->data[i] = B->data[i];
      b_A_outdatedOnGpu = true;
    }
    profileLoopEnd();
    i = cpu_ipiv_t->size[0];
    cpu_ipiv_t->size[0] = B->size[1];
    nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
    emxEnsureCapacity_int32_T(cpu_ipiv_t, i, &md_emlrtRTEI);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(c_cpu_A, &b_gpu_A, !b_A_outdatedOnGpu);
    if (b_A_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, c_cpu_A);
    }
    cusolverDnDgetrf_bufferSize(getCuSolverGlobalHandle(), B->size[1],
                                B->size[1], (double *)&b_gpu_A.data[0],
                                B->size[1], getCuSolverWorkspaceReq());
    setCuSolverWorkspaceTypeSize(8);
    cusolverInitWorkspace();
    A_needsGpuEnsureCapacity = false;
    nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_int32_T(cpu_ipiv_t, &gpu_ipiv_t, true);
    cusolverDnDgetrf(getCuSolverGlobalHandle(), B->size[1], B->size[1],
                     (double *)&b_gpu_A.data[0], B->size[1],
                     static_cast<real_T *>(getCuSolverWorkspaceBuff()),
                     &gpu_ipiv_t.data[0], gpu_minmn);
    b_A_outdatedOnCpu = true;
    b_A_outdatedOnGpu = false;
    i = ipiv->size[0] * ipiv->size[1];
    ipiv->size[0] = 1;
    ipiv->size[1] = cpu_ipiv_t->size[0];
    nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
    emxEnsureCapacity_int32_T(ipiv, i, &md_emlrtRTEI);
    nvtxMarkA("#checkCudaError#" MW_AT_LINE);
    nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
    checkCudaError(
        cudaMemcpy(&cpu_minmn, gpu_minmn, 4UL, cudaMemcpyDeviceToHost),
        __FILE__, __LINE__);
    if (cpu_minmn < 0) {
      int32_T maxmn;
      maxmn = c_cpu_A->size[0];
      cpu_minmn = c_cpu_A->size[1];
      i = c_cpu_A->size[0] * c_cpu_A->size[1];
      c_cpu_A->size[0] = maxmn;
      c_cpu_A->size[1] = cpu_minmn;
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(c_cpu_A, i, &md_emlrtRTEI);
      A_needsGpuEnsureCapacity = true;
      profileLoopStart("mrdiv_loop_6", __LINE__, (maxmn * cpu_minmn - 1) + 1,
                       "");
      for (i = 0; i < maxmn * cpu_minmn; i++) {
        c_cpu_A->data[i] = rtNaN;
        b_A_outdatedOnGpu = true;
      }
      profileLoopEnd();
      maxmn = cpu_ipiv_t->size[0];
      profileLoopStart("mrdiv_loop_8", __LINE__, (maxmn - 1) + 1, "");
      for (int32_T u0{0}; u0 < maxmn; u0++) {
        ipiv->data[u0] = u0 + 1;
      }
      profileLoopEnd();
    } else {
      int32_T maxmn;
      maxmn = cpu_ipiv_t->size[0];
      profileLoopStart("mrdiv_loop_4", __LINE__, (maxmn - 1) + 1, "");
      for (int32_T u0{0}; u0 < maxmn; u0++) {
        if (b_A_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_int32_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_int32_T(cpu_ipiv_t, &gpu_ipiv_t);
        }
        b_A_outdatedOnCpu = false;
        ipiv->data[u0] = cpu_ipiv_t->data[u0];
      }
      profileLoopEnd();
    }
    tol = 1.0;
    if (A_needsGpuEnsureCapacity) {
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(c_cpu_A, &b_gpu_A, !b_A_outdatedOnGpu);
    }
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_A, gpu_A, !*A_outdatedOnGpu);
    if (b_A_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, c_cpu_A);
    }
    if (*A_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(gpu_A, cpu_A);
    }
    cublasDtrsm(getCublasGlobalHandle(), CUBLAS_SIDE_RIGHT,
                CUBLAS_FILL_MODE_UPPER, CUBLAS_OP_N, CUBLAS_DIAG_NON_UNIT, 1,
                B->size[1], (double *)&tol, (double *)&b_gpu_A.data[0],
                B->size[1], (double *)&gpu_A->data[0], 1);
    cublasDtrsm(getCublasGlobalHandle(), CUBLAS_SIDE_RIGHT,
                CUBLAS_FILL_MODE_LOWER, CUBLAS_OP_N, CUBLAS_DIAG_UNIT, 1,
                B->size[1], (double *)&tol, (double *)&b_gpu_A.data[0],
                B->size[1], (double *)&gpu_A->data[0], 1);
    *A_outdatedOnGpu = false;
    *A_outdatedOnCpu = true;
    cpu_minmn = B->size[1] - 2;
    profileLoopStart("mrdiv_loop_9", __LINE__, cpu_minmn + 1, "");
    for (int32_T u0{0}; u0 <= cpu_minmn; u0++) {
      i = ipiv->data[cpu_minmn - u0];
      if (i != (cpu_minmn - u0) + 1) {
        if (A_needsCpuEnsureCapacity) {
          nvtxMarkA("#cpuEmxAllocateOrResize_real_T#" MW_AT_LINE);
          cpuEmxAllocateOrResize_real_T(cpu_A, !*A_outdatedOnCpu);
        }
        if (*A_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_real_T(cpu_A, gpu_A);
        }
        tol = cpu_A->data[cpu_minmn - u0];
        cpu_A->data[cpu_minmn - u0] = cpu_A->data[i - 1];
        A_needsCpuEnsureCapacity = false;
        cpu_A->data[i - 1] = tol;
        *A_outdatedOnCpu = false;
        *A_outdatedOnGpu = true;
      }
    }
    profileLoopEnd();
  } else {
    ptrdiff_t info_t;
    real_T tol;
    int32_T i;
    int32_T maxmn;
    int32_T minmana;
    int32_T na;
    int32_T u0;
    boolean_T A_needsGpuEnsureCapacity;
    boolean_T B_outdatedOnGpu;
    boolean_T b_A_outdatedOnCpu;
    boolean_T b_A_outdatedOnGpu;
    boolean_T jpvt_outdatedOnGpu;
    boolean_T validLaunchParams;
    b_A_outdatedOnCpu = false;
    i = b_cpu_A->size[0] * b_cpu_A->size[1];
    b_cpu_A->size[0] = B->size[1];
    b_cpu_A->size[1] = B->size[0];
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(b_cpu_A, i, &ld_emlrtRTEI);
    profileLoopStart("mrdiv_loop_0", __LINE__, (B->size[0] - 1) + 1, "");
    for (i = 0; i < B->size[0]; i++) {
      profileLoopStart("mrdiv_loop_2", __LINE__, (B->size[1] - 1) + 1, "");
      for (maxmn = 0; maxmn < B->size[1]; maxmn++) {
        b_cpu_A->data[maxmn + b_cpu_A->size[0] * i] =
            B->data[i + B->size[0] * maxmn];
      }
      profileLoopEnd();
    }
    profileLoopEnd();
    B_outdatedOnGpu = false;
    i = cpu_B->size[0];
    cpu_B->size[0] = cpu_A->size[1];
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(cpu_B, i, &nd_emlrtRTEI);
    profileLoopStart("mrdiv_loop_3", __LINE__, (cpu_A->size[1] - 1) + 1, "");
    for (i = 0; i < cpu_A->size[1]; i++) {
      if (A_needsCpuEnsureCapacity) {
        nvtxMarkA("#cpuEmxAllocateOrResize_real_T#" MW_AT_LINE);
        cpuEmxAllocateOrResize_real_T(cpu_A, !*A_outdatedOnCpu);
      }
      A_needsCpuEnsureCapacity = false;
      if (*A_outdatedOnCpu) {
        nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
        gpuEmxMemcpyGpuToCpu_real_T(cpu_A, gpu_A);
      }
      *A_outdatedOnCpu = false;
      cpu_B->data[i] = cpu_A->data[i];
      B_outdatedOnGpu = true;
    }
    profileLoopEnd();
    maxmn = b_cpu_A->size[0];
    na = b_cpu_A->size[1];
    jpvt_outdatedOnGpu = false;
    i = cpu_jpvt->size[0] * cpu_jpvt->size[1];
    cpu_jpvt->size[0] = 1;
    cpu_jpvt->size[1] = b_cpu_A->size[1];
    nvtxMarkA("#emxEnsureCapacity_int32_T#" MW_AT_LINE);
    emxEnsureCapacity_int32_T(cpu_jpvt, i, &od_emlrtRTEI);
    u0 = b_cpu_A->size[0];
    minmana = b_cpu_A->size[1];
    if (u0 <= minmana) {
      minmana = u0;
    }
    i = cpu_tau->size[0];
    cpu_tau->size[0] = minmana;
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(cpu_tau, i, &pd_emlrtRTEI);
    i = jpvt_t->size[0];
    jpvt_t->size[0] = b_cpu_A->size[1];
    nvtxMarkA("#emxEnsureCapacity_ptrdiff_t#" MW_AT_LINE);
    emxEnsureCapacity_ptrdiff_t(jpvt_t, i, &qd_emlrtRTEI);
    profileLoopStart("mrdiv_loop_5", __LINE__, (b_cpu_A->size[1] - 1) + 1, "");
    for (i = 0; i < b_cpu_A->size[1]; i++) {
      cpu_jpvt->data[i] = 0;
      jpvt_outdatedOnGpu = true;
      jpvt_t->data[i] = (ptrdiff_t)0;
    }
    profileLoopEnd();
    info_t = LAPACKE_dgeqp3(102, (ptrdiff_t)b_cpu_A->size[0],
                            (ptrdiff_t)b_cpu_A->size[1], &b_cpu_A->data[0],
                            (ptrdiff_t)b_cpu_A->size[0], &jpvt_t->data[0],
                            &cpu_tau->data[0]);
    b_A_outdatedOnGpu = true;
    A_needsGpuEnsureCapacity = true;
    if ((int32_T)info_t != 0) {
      int64_T b;
      uint64_T numIters;
      nvtxMarkA("#computeNumIters#" MW_AT_LINE);
      numIters = computeNumIters(na - 1, maxmn - 1);
      mwGetLaunchParameters1D(numIters, &grid, &block, 2147483647U);
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(b_cpu_A, &c_gpu_A, false);
      A_needsGpuEnsureCapacity = false;
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_A, b_cpu_A);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        nvtxMarkA("#mrdiv_kernel31#" MW_AT_LINE);
        mrdiv_kernel31<<<grid, block>>>(maxmn - 1, na - 1, c_gpu_A,
                                        b_cpu_A->size[0U]);
      }
      b_A_outdatedOnGpu = false;
      b_A_outdatedOnCpu = true;
      u0 = b_cpu_A->size[0];
      cpu_minmn = b_cpu_A->size[1];
      if (u0 <= cpu_minmn) {
        cpu_minmn = u0;
      }
      profileLoopStart("mrdiv_loop_10", __LINE__, (cpu_minmn - 1) + 1, "");
      for (u0 = 0; u0 < cpu_minmn; u0++) {
        cpu_tau->data[u0] = rtNaN;
      }
      profileLoopEnd();
      nvtxMarkA("#computeEndIdx#" MW_AT_LINE);
      b = computeEndIdx(static_cast<int64_T>(cpu_minmn + 1),
                        static_cast<int64_T>(minmana), 1L);
      profileLoopStart("mrdiv_loop_12", __LINE__, b + 1L, "");
      for (int64_T k{0L}; k <= b; k++) {
        cpu_tau->data[static_cast<int32_T>((cpu_minmn + 1) + k) - 1] = 0.0;
      }
      profileLoopEnd();
      profileLoopStart("mrdiv_loop_13", __LINE__, (na - 1) + 1, "");
      for (u0 = 0; u0 < na; u0++) {
        cpu_jpvt->data[u0] = u0 + 1;
        jpvt_outdatedOnGpu = true;
      }
      profileLoopEnd();
    } else {
      profileLoopStart("mrdiv_loop_7", __LINE__, (na - 1) + 1, "");
      for (u0 = 0; u0 < na; u0++) {
        cpu_jpvt->data[u0] = (int32_T)jpvt_t->data[u0];
        jpvt_outdatedOnGpu = true;
      }
      profileLoopEnd();
    }
    na = -1;
    if (b_cpu_A->size[0] < b_cpu_A->size[1]) {
      cpu_minmn = b_cpu_A->size[0];
      maxmn = b_cpu_A->size[1];
    } else {
      cpu_minmn = b_cpu_A->size[1];
      maxmn = b_cpu_A->size[0];
    }
    if (b_A_outdatedOnCpu) {
      nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyGpuToCpu_real_T(b_cpu_A, &c_gpu_A);
    }
    tol = std::fmin(1.4901161193847656E-8,
                    2.2204460492503131E-15 * static_cast<real_T>(maxmn)) *
          std::abs(b_cpu_A->data[0]);
    nvtxRangePushA("#loop#mrdiv_whileloop_0##" MW_AT_LINE);
    while ((na + 1 < cpu_minmn) &&
           (!(std::abs(b_cpu_A->data[(na + b_cpu_A->size[0] * (na + 1)) + 1]) <=
              tol))) {
      na++;
    }
    nvtxRangePop();
    A_needsCpuEnsureCapacity = false;
    i = cpu_Y->size[0];
    cpu_Y->size[0] = b_cpu_A->size[1];
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(cpu_Y, i, &rd_emlrtRTEI);
    profileLoopStart("mrdiv_loop_11", __LINE__, (b_cpu_A->size[1] - 1) + 1, "");
    for (i = 0; i < b_cpu_A->size[1]; i++) {
      cpu_Y->data[i] = 0.0;
      A_needsCpuEnsureCapacity = true;
    }
    profileLoopEnd();
    cpu_minmn = 0;
    u0 = b_cpu_A->size[0];
    maxmn = b_cpu_A->size[1];
    if (u0 <= maxmn) {
      maxmn = u0;
    }
    if (A_needsGpuEnsureCapacity) {
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(b_cpu_A, &c_gpu_A, !b_A_outdatedOnGpu);
    }
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_tau, &gpu_tau, false);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_B, &gpu_B, !B_outdatedOnGpu);
    if (b_A_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_A, b_cpu_A);
    }
    nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
    gpuEmxMemcpyCpuToGpu_real_T(&gpu_tau, cpu_tau);
    if (B_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_B, cpu_B);
    }
    cusolverDnDormqr_bufferSize(
        getCuSolverGlobalHandle(), CUBLAS_SIDE_LEFT, CUBLAS_OP_T,
        cpu_B->size[0], 1, maxmn, (double *)&c_gpu_A.data[0], b_cpu_A->size[0],
        (double *)&gpu_tau.data[0], (double *)&gpu_B.data[0], cpu_B->size[0],
        getCuSolverWorkspaceReq());
    setCuSolverWorkspaceTypeSize(8);
    cusolverInitWorkspace();
    b_A_outdatedOnCpu = false;
    nvtxMarkA("#checkCudaError#" MW_AT_LINE);
    nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
    checkCudaError(
        cudaMemcpy(gpu_minmn, &cpu_minmn, 4UL, cudaMemcpyHostToDevice),
        __FILE__, __LINE__);
    cusolverDnDormqr(getCuSolverGlobalHandle(), CUBLAS_SIDE_LEFT, CUBLAS_OP_T,
                     cpu_B->size[0], 1, maxmn, (double *)&c_gpu_A.data[0],
                     b_cpu_A->size[0], (double *)&gpu_tau.data[0],
                     (double *)&gpu_B.data[0], cpu_B->size[0],
                     static_cast<real_T *>(getCuSolverWorkspaceBuff()),
                     *getCuSolverWorkspaceReq(), gpu_minmn);
    B_outdatedOnGpu = false;
    nvtxMarkA("#checkCudaError#" MW_AT_LINE);
    nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
    checkCudaError(
        cudaMemcpy(&cpu_minmn, gpu_minmn, 4UL, cudaMemcpyDeviceToHost),
        __FILE__, __LINE__);
    if (cpu_minmn < 0) {
      maxmn = cpu_B->size[0];
      i = cpu_B->size[0];
      cpu_B->size[0] = maxmn;
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(cpu_B, i, &sd_emlrtRTEI);
      b_A_outdatedOnCpu = true;
      profileLoopStart("mrdiv_loop_14", __LINE__, (maxmn - 1) + 1, "");
      for (i = 0; i < maxmn; i++) {
        cpu_B->data[i] = rtNaN;
        B_outdatedOnGpu = true;
      }
      profileLoopEnd();
    }
    nvtxMarkA("#computeNumIters#" MW_AT_LINE);
    mwGetLaunchParameters1D(computeNumIters(na), &grid, &block, 2147483647U);
    if (b_A_outdatedOnCpu) {
      nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
      gpuEmxEnsureCapacity_real_T(cpu_B, &gpu_B, !B_outdatedOnGpu);
    }
    nvtxMarkA("#gpuEmxEnsureCapacity_int32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_int32_T(cpu_jpvt, &gpu_jpvt, !jpvt_outdatedOnGpu);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_Y, &gpu_Y, !A_needsCpuEnsureCapacity);
    if (B_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_B, cpu_B);
    }
    if (jpvt_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_int32_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_int32_T(&gpu_jpvt, cpu_jpvt);
    }
    if (A_needsCpuEnsureCapacity) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_Y, cpu_Y);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      nvtxMarkA("#mrdiv_kernel32#" MW_AT_LINE);
      mrdiv_kernel32<<<grid, block>>>(gpu_B, gpu_jpvt, na, gpu_Y);
    }
    b_A_outdatedOnCpu = true;
    profileLoopStart("mrdiv_loop_15", __LINE__, na + 1, "");
    for (u0 = 0; u0 <= na; u0++) {
      i = cpu_jpvt->data[na - u0];
      if (b_A_outdatedOnCpu) {
        nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
        gpuEmxMemcpyGpuToCpu_real_T(cpu_Y, &gpu_Y);
      }
      cpu_Y->data[i - 1] /=
          b_cpu_A->data[(na - u0) + b_cpu_A->size[0] * (na - u0)];
      b_A_outdatedOnCpu = false;
      maxmn = na - u0;
      profileLoopStart("mrdiv_loop_17", __LINE__, (maxmn - 1) + 1, "");
      for (cpu_minmn = 0; cpu_minmn < maxmn; cpu_minmn++) {
        cpu_Y->data[cpu_jpvt->data[cpu_minmn] - 1] -=
            cpu_Y->data[cpu_jpvt->data[na - u0] - 1] *
            b_cpu_A->data[cpu_minmn + b_cpu_A->size[0] * (na - u0)];
      }
      profileLoopEnd();
    }
    profileLoopEnd();
    i = cpu_A->size[0] * cpu_A->size[1];
    cpu_A->size[0] = 1;
    cpu_A->size[1] = cpu_Y->size[0];
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(cpu_A, i, &td_emlrtRTEI);
    profileLoopStart("mrdiv_loop_16", __LINE__, (cpu_Y->size[0] - 1) + 1, "");
    for (i = 0; i < cpu_Y->size[0]; i++) {
      if (*A_outdatedOnCpu) {
        nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
        gpuEmxMemcpyGpuToCpu_real_T(cpu_A, gpu_A);
      }
      if (b_A_outdatedOnCpu) {
        nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
        gpuEmxMemcpyGpuToCpu_real_T(cpu_Y, &gpu_Y);
      }
      b_A_outdatedOnCpu = false;
      cpu_A->data[i] = cpu_Y->data[i];
      *A_outdatedOnCpu = false;
      *A_outdatedOnGpu = true;
    }
    profileLoopEnd();
  }
  nvtxMarkA("#emxFree_ptrdiff_t#" MW_AT_LINE);
  emxFree_ptrdiff_t(&jpvt_t);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_tau);
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&cpu_ipiv_t);
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&cpu_jpvt);
  nvtxMarkA("#emxFree_int32_T#" MW_AT_LINE);
  emxFree_int32_T(&ipiv);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&c_cpu_A);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_B);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&b_cpu_A);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_Y);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_Y);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&c_gpu_A);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_B);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&b_gpu_A);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&gpu_jpvt);
  nvtxMarkA("#gpuEmxFree_int32_T#" MW_AT_LINE);
  gpuEmxFree_int32_T(&gpu_ipiv_t);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_tau);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaFree#" MW_AT_LINE);
  checkCudaError(mwCudaFree(gpu_minmn), __FILE__, __LINE__);
  nvtxRangePop();
}

} // namespace internal
} // namespace coder

// End of code generation (mrdivide_helper.cu)
