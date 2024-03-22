//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// mldivide.cu
//
// Code generation for function 'mldivide'
//

// Include files
#include "mldivide.h"
#include "ec_cwtAvg_data.h"
#include "ec_cwtAvg_emxutil.h"
#include "ec_cwtAvg_mexutil.h"
#include "ec_cwtAvg_types.h"
#include "rt_nonfinite.h"
#include "MWCUBLASUtils.hpp"
#include "MWCUSOLVERUtils.hpp"
#include "MWCudaDimUtility.hpp"
#include "MWCudaMemoryFunctions.hpp"
#include "MWErrorCodeUtils.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include "lapacke.h"
#include "math_constants.h"
#include <cmath>
#include <cstddef>

// Variable Definitions
static emlrtRTEInfo af_emlrtRTEI{
    20,                                                              // lineNo
    5,                                                               // colNo
    "mldivide",                                                      // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/ops/mldivide.m" // pName
};

static emlrtRTEInfo
    bf_emlrtRTEI{
        1,        // lineNo
        32,       // colNo
        "xgeqp3", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/"
        "xgeqp3.m" // pName
    };

static emlrtRTEInfo cf_emlrtRTEI{
    1,             // lineNo
    42,            // colNo
    "xgetrfs_gpu", // fName
    "/usr/local/MATLAB/R2024a/toolbox/gpucoder/gpucoder/+coder/+internal/"
    "+lapack/xgetrfs_gpu.m" // pName
};

static emlrtRTEInfo
    df_emlrtRTEI{
        61,       // lineNo
        9,        // colNo
        "xgeqp3", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/"
        "xgeqp3.m" // pName
    };

static emlrtRTEInfo ef_emlrtRTEI{
    27,            // lineNo
    23,            // colNo
    "xgetrfs_gpu", // fName
    "/usr/local/MATLAB/R2024a/toolbox/gpucoder/gpucoder/+coder/+internal/"
    "+lapack/xgetrfs_gpu.m" // pName
};

static emlrtRTEInfo
    ff_emlrtRTEI{
        92,       // lineNo
        22,       // colNo
        "xgeqp3", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/"
        "xgeqp3.m" // pName
    };

static emlrtRTEInfo
    gf_emlrtRTEI{
        105,      // lineNo
        1,        // colNo
        "xgeqp3", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/"
        "xgeqp3.m" // pName
    };

static emlrtRTEInfo hf_emlrtRTEI{
    68,            // lineNo
    9,             // colNo
    "xgetrfs_gpu", // fName
    "/usr/local/MATLAB/R2024a/toolbox/gpucoder/gpucoder/+coder/+internal/"
    "+lapack/xgetrfs_gpu.m" // pName
};

static emlrtRTEInfo if_emlrtRTEI{
    85,        // lineNo
    26,        // colNo
    "qrsolve", // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/qrsolve.m" // pName
};

static emlrtRTEInfo jf_emlrtRTEI{
    119,       // lineNo
    5,         // colNo
    "qrsolve", // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/qrsolve.m" // pName
};

static emlrtRTEInfo kf_emlrtRTEI{
    1,                                                               // lineNo
    14,                                                              // colNo
    "mldivide",                                                      // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/ops/mldivide.m" // pName
};

static emlrtRTEInfo lf_emlrtRTEI{
    27,            // lineNo
    1,             // colNo
    "xgetrfs_gpu", // fName
    "/usr/local/MATLAB/R2024a/toolbox/gpucoder/gpucoder/+coder/+internal/"
    "+lapack/xgetrfs_gpu.m" // pName
};

// Function Declarations
static void cusolverCheck(cusolverStatus_t errCode, const char_T *file,
                          uint32_T b_line);

static void gpuEmxMemcpyCpuToGpu_real_T(emxArray_real_T *gpu,
                                        const emxArray_real_T *cpu);

static __global__ void mldivide_kernel38(const int32_T b, const int32_T na,
                                         emxArray_real_T A, int32_T A_dim0);

static __global__ void mldivide_kernel39(const emxArray_real_T B,
                                         const emxArray_int32_T jpvt,
                                         const int32_T na, emxArray_real_T Y);

// Function Definitions
static void cusolverCheck(cusolverStatus_t errCode, const char_T *file,
                          uint32_T b_line)
{
  const char *errName;
  const char *errString;
  if (errCode != CUSOLVER_STATUS_SUCCESS) {
    cusolverGetErrorName(errCode, &errName);
    cusolverGetErrorString(errCode, &errString);
    raiseCudaError(errCode, file, b_line, errName, errString);
  }
}

static void gpuEmxMemcpyCpuToGpu_real_T(emxArray_real_T *gpu,
                                        const emxArray_real_T *cpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }
  checkCudaError(cudaMemcpy(gpu->data, cpu->data,
                            static_cast<uint32_T>(actualSize) * sizeof(real_T),
                            cudaMemcpyHostToDevice),
                 __FILE__, __LINE__);
}

static __global__ __launch_bounds__(1024, 1) void mldivide_kernel38(
    const int32_T b, const int32_T na, emxArray_real_T A, int32_T A_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(na) + 1UL) * (static_cast<uint64_T>(b) + 1UL) -
      1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i;
    int32_T j;
    i = static_cast<int32_T>(idx % (static_cast<uint64_T>(b) + 1UL));
    j = static_cast<int32_T>((idx - static_cast<uint64_T>(i)) /
                             (static_cast<uint64_T>(b) + 1UL));
    A.data[j * A_dim0 + i] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void mldivide_kernel39(
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
void mldivide(const emxArray_real_T *A, const emxArray_real_T *B,
              emxArray_real_T *cpu_Y, boolean_T *Y_outdatedOnCpu,
              emxArray_real_T *gpu_Y, boolean_T *Y_outdatedOnGpu)
{
  dim3 block;
  dim3 grid;
  emxArray_int32_T gpu_IPIV;
  emxArray_int32_T gpu_jpvt;
  emxArray_int32_T *cpu_IPIV;
  emxArray_int32_T *cpu_jpvt;
  emxArray_ptrdiff_t *jpvt_t;
  emxArray_real_T b_gpu_A;
  emxArray_real_T gpu_A;
  emxArray_real_T gpu_B;
  emxArray_real_T gpu_tau;
  emxArray_real_T *b_cpu_A;
  emxArray_real_T *cpu_A;
  emxArray_real_T *cpu_B;
  emxArray_real_T *cpu_tau;
  int32_T cpu_maxmn;
  int32_T *gpu_maxmn;
  checkCudaError(mwCudaMalloc(&gpu_maxmn, 4UL), __FILE__, __LINE__);
  gpuEmxReset_real_T(&gpu_B);
  gpuEmxReset_int32_T(&gpu_IPIV);
  gpuEmxReset_real_T(&gpu_A);
  gpuEmxReset_real_T(&gpu_tau);
  gpuEmxReset_int32_T(&gpu_jpvt);
  gpuEmxReset_real_T(&b_gpu_A);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&cpu_A, 2, &kf_emlrtRTEI, true);
  emxInit_int32_T(&cpu_jpvt, 2, &kf_emlrtRTEI, true);
  emxInit_real_T(&cpu_tau, 1, &kf_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_A, 2, &kf_emlrtRTEI, true);
  emxInit_ptrdiff_t(&jpvt_t, 1, &gf_emlrtRTEI, true);
  emxInit_int32_T(&cpu_IPIV, 1, &lf_emlrtRTEI, true);
  emxInit_real_T(&cpu_B, 1, &if_emlrtRTEI, true);
  if ((A->size[0] == 0) || (A->size[1] == 0) || (B->size[0] == 0)) {
    int32_T u0;
    *Y_outdatedOnCpu = false;
    *Y_outdatedOnGpu = false;
    u0 = cpu_Y->size[0];
    cpu_Y->size[0] = A->size[1];
    emxEnsureCapacity_real_T(cpu_Y, u0, &af_emlrtRTEI);
    for (u0 = 0; u0 < A->size[1]; u0++) {
      cpu_Y->data[u0] = 0.0;
      *Y_outdatedOnGpu = true;
    }
  } else if (A->size[0] == A->size[1]) {
    int32_T minmn;
    int32_T u0;
    boolean_T A_outdatedOnGpu;
    *Y_outdatedOnCpu = false;
    *Y_outdatedOnGpu = false;
    u0 = cpu_Y->size[0];
    cpu_Y->size[0] = B->size[0];
    emxEnsureCapacity_real_T(cpu_Y, u0, &af_emlrtRTEI);
    for (u0 = 0; u0 < B->size[0]; u0++) {
      cpu_Y->data[u0] = B->data[u0];
      *Y_outdatedOnGpu = true;
    }
    u0 = A->size[0];
    minmn = A->size[1];
    if (u0 <= minmn) {
      minmn = u0;
    }
    u0 = B->size[0];
    if (u0 <= minmn) {
      minmn = u0;
    }
    A_outdatedOnGpu = false;
    u0 = b_cpu_A->size[0] * b_cpu_A->size[1];
    b_cpu_A->size[0] = A->size[0];
    b_cpu_A->size[1] = A->size[1];
    emxEnsureCapacity_real_T(b_cpu_A, u0, &cf_emlrtRTEI);
    for (u0 = 0; u0 < A->size[0] * A->size[1]; u0++) {
      b_cpu_A->data[u0] = A->data[u0];
      A_outdatedOnGpu = true;
    }
    u0 = cpu_IPIV->size[0];
    cpu_IPIV->size[0] = minmn;
    emxEnsureCapacity_int32_T(cpu_IPIV, u0, &ef_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(b_cpu_A, &gpu_A, !A_outdatedOnGpu);
    if (A_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_A, b_cpu_A);
    }
    cusolverCheck(cusolverDnDgetrf_bufferSize(getCuSolverGlobalHandle(), minmn,
                                              minmn, (double *)&gpu_A.data[0],
                                              b_cpu_A->size[0],
                                              getCuSolverWorkspaceReq()),
                  __FILE__, __LINE__);
    setCuSolverWorkspaceTypeSize(8);
    cusolverInitWorkspace();
    gpuEmxEnsureCapacity_int32_T(cpu_IPIV, &gpu_IPIV, true);
    cusolverCheck(
        cusolverDnDgetrf(getCuSolverGlobalHandle(), minmn, minmn,
                         (double *)&gpu_A.data[0], b_cpu_A->size[0],
                         static_cast<real_T *>(getCuSolverWorkspaceBuff()),
                         &gpu_IPIV.data[0], gpu_maxmn),
        __FILE__, __LINE__);
    checkCudaError(
        cudaMemcpy(&cpu_maxmn, gpu_maxmn, 4UL, cudaMemcpyDeviceToHost),
        __FILE__, __LINE__);
    if (cpu_maxmn < 0) {
      *Y_outdatedOnGpu = false;
      u0 = cpu_Y->size[0];
      cpu_Y->size[0] = B->size[0];
      emxEnsureCapacity_real_T(cpu_Y, u0, &hf_emlrtRTEI);
      for (u0 = 0; u0 < B->size[0]; u0++) {
        cpu_Y->data[u0] = rtNaN;
        *Y_outdatedOnGpu = true;
      }
    } else {
      gpuEmxEnsureCapacity_real_T(cpu_Y, gpu_Y, !*Y_outdatedOnGpu);
      if (*Y_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real_T(gpu_Y, cpu_Y);
      }
      cusolverCheck(cusolverDnDgetrs(getCuSolverGlobalHandle(), CUBLAS_OP_N,
                                     minmn, 1, (double *)&gpu_A.data[0],
                                     b_cpu_A->size[0], &gpu_IPIV.data[0],
                                     (double *)&gpu_Y->data[0], B->size[0],
                                     gpu_maxmn),
                    __FILE__, __LINE__);
      *Y_outdatedOnGpu = false;
      *Y_outdatedOnCpu = true;
    }
  } else {
    ptrdiff_t info_t;
    real_T tol;
    int32_T minmana;
    int32_T minmn;
    int32_T na;
    int32_T u0;
    boolean_T A_outdatedOnCpu;
    boolean_T A_outdatedOnGpu;
    boolean_T B_outdatedOnGpu;
    boolean_T jpvt_outdatedOnGpu;
    boolean_T validLaunchParams;
    A_outdatedOnCpu = false;
    u0 = cpu_A->size[0] * cpu_A->size[1];
    cpu_A->size[0] = A->size[0];
    cpu_A->size[1] = A->size[1];
    emxEnsureCapacity_real_T(cpu_A, u0, &bf_emlrtRTEI);
    for (u0 = 0; u0 < A->size[0] * A->size[1]; u0++) {
      cpu_A->data[u0] = A->data[u0];
    }
    cpu_maxmn = cpu_A->size[0];
    na = cpu_A->size[1] - 1;
    jpvt_outdatedOnGpu = false;
    u0 = cpu_jpvt->size[0] * cpu_jpvt->size[1];
    cpu_jpvt->size[0] = 1;
    cpu_jpvt->size[1] = cpu_A->size[1];
    emxEnsureCapacity_int32_T(cpu_jpvt, u0, &df_emlrtRTEI);
    u0 = cpu_A->size[0];
    minmana = cpu_A->size[1];
    if (u0 <= minmana) {
      minmana = u0;
    }
    u0 = cpu_tau->size[0];
    cpu_tau->size[0] = minmana;
    emxEnsureCapacity_real_T(cpu_tau, u0, &ff_emlrtRTEI);
    u0 = jpvt_t->size[0];
    jpvt_t->size[0] = cpu_A->size[1];
    emxEnsureCapacity_ptrdiff_t(jpvt_t, u0, &gf_emlrtRTEI);
    for (u0 = 0; u0 < cpu_A->size[1]; u0++) {
      cpu_jpvt->data[u0] = 0;
      jpvt_outdatedOnGpu = true;
      jpvt_t->data[u0] = (ptrdiff_t)0;
    }
    info_t = LAPACKE_dgeqp3(102, (ptrdiff_t)cpu_A->size[0],
                            (ptrdiff_t)cpu_A->size[1], &cpu_A->data[0],
                            (ptrdiff_t)cpu_A->size[0], &jpvt_t->data[0],
                            &cpu_tau->data[0]);
    A_outdatedOnGpu = true;
    if ((int32_T)info_t != 0) {
      int64_T b;
      mwGetLaunchParameters1D(computeNumIters(na, cpu_maxmn - 1), &grid, &block,
                              2147483647U);
      gpuEmxEnsureCapacity_real_T(cpu_A, &b_gpu_A, false);
      gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, cpu_A);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        mldivide_kernel38<<<grid, block>>>(cpu_maxmn - 1, na, b_gpu_A,
                                           cpu_A->size[0U]);
      }
      A_outdatedOnGpu = false;
      A_outdatedOnCpu = true;
      u0 = cpu_A->size[0];
      minmn = cpu_A->size[1];
      if (u0 <= minmn) {
        minmn = u0;
      }
      for (cpu_maxmn = 0; cpu_maxmn < minmn; cpu_maxmn++) {
        cpu_tau->data[cpu_maxmn] = rtNaN;
      }
      b = computeEndIdx(static_cast<int64_T>(minmn + 1),
                        static_cast<int64_T>(minmana), 1L);
      for (int64_T k{0L}; k <= b; k++) {
        cpu_tau->data[static_cast<int32_T>((minmn + 1) + k) - 1] = 0.0;
      }
      for (cpu_maxmn = 0; cpu_maxmn <= na; cpu_maxmn++) {
        cpu_jpvt->data[cpu_maxmn] = cpu_maxmn + 1;
        jpvt_outdatedOnGpu = true;
      }
    } else {
      for (cpu_maxmn = 0; cpu_maxmn <= na; cpu_maxmn++) {
        cpu_jpvt->data[cpu_maxmn] = (int32_T)jpvt_t->data[cpu_maxmn];
        jpvt_outdatedOnGpu = true;
      }
    }
    na = -1;
    if (cpu_A->size[0] < cpu_A->size[1]) {
      minmn = cpu_A->size[0];
      cpu_maxmn = cpu_A->size[1];
    } else {
      minmn = cpu_A->size[1];
      cpu_maxmn = cpu_A->size[0];
    }
    if (A_outdatedOnCpu) {
      gpuEmxMemcpyGpuToCpu_real_T(cpu_A, &b_gpu_A);
    }
    tol = std::fmin(1.4901161193847656E-8,
                    2.2204460492503131E-15 * static_cast<real_T>(cpu_maxmn)) *
          std::abs(cpu_A->data[0]);
    while ((na + 1 < minmn) &&
           (!(std::abs(cpu_A->data[(na + cpu_A->size[0] * (na + 1)) + 1]) <=
              tol))) {
      na++;
    }
    B_outdatedOnGpu = false;
    u0 = cpu_B->size[0];
    cpu_B->size[0] = B->size[0];
    emxEnsureCapacity_real_T(cpu_B, u0, &if_emlrtRTEI);
    for (u0 = 0; u0 < B->size[0]; u0++) {
      cpu_B->data[u0] = B->data[u0];
      B_outdatedOnGpu = true;
    }
    *Y_outdatedOnGpu = false;
    u0 = cpu_Y->size[0];
    cpu_Y->size[0] = cpu_A->size[1];
    emxEnsureCapacity_real_T(cpu_Y, u0, &af_emlrtRTEI);
    for (u0 = 0; u0 < cpu_A->size[1]; u0++) {
      cpu_Y->data[u0] = 0.0;
      *Y_outdatedOnGpu = true;
    }
    cpu_maxmn = 0;
    u0 = cpu_A->size[0];
    minmn = cpu_A->size[1];
    if (u0 <= minmn) {
      minmn = u0;
    }
    gpuEmxEnsureCapacity_real_T(cpu_A, &b_gpu_A, !A_outdatedOnGpu);
    gpuEmxEnsureCapacity_real_T(cpu_tau, &gpu_tau, false);
    gpuEmxEnsureCapacity_real_T(cpu_B, &gpu_B, !B_outdatedOnGpu);
    if (A_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, cpu_A);
    }
    gpuEmxMemcpyCpuToGpu_real_T(&gpu_tau, cpu_tau);
    if (B_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_B, cpu_B);
    }
    cusolverCheck(cusolverDnDormqr_bufferSize(
                      getCuSolverGlobalHandle(), CUBLAS_SIDE_LEFT, CUBLAS_OP_T,
                      cpu_B->size[0], 1, minmn, (double *)&b_gpu_A.data[0],
                      cpu_A->size[0], (double *)&gpu_tau.data[0],
                      (double *)&gpu_B.data[0], cpu_B->size[0],
                      getCuSolverWorkspaceReq()),
                  __FILE__, __LINE__);
    setCuSolverWorkspaceTypeSize(8);
    cusolverInitWorkspace();
    A_outdatedOnCpu = false;
    checkCudaError(
        cudaMemcpy(gpu_maxmn, &cpu_maxmn, 4UL, cudaMemcpyHostToDevice),
        __FILE__, __LINE__);
    cusolverCheck(cusolverDnDormqr(
                      getCuSolverGlobalHandle(), CUBLAS_SIDE_LEFT, CUBLAS_OP_T,
                      cpu_B->size[0], 1, minmn, (double *)&b_gpu_A.data[0],
                      cpu_A->size[0], (double *)&gpu_tau.data[0],
                      (double *)&gpu_B.data[0], cpu_B->size[0],
                      static_cast<real_T *>(getCuSolverWorkspaceBuff()),
                      *getCuSolverWorkspaceReq(), gpu_maxmn),
                  __FILE__, __LINE__);
    B_outdatedOnGpu = false;
    checkCudaError(
        cudaMemcpy(&cpu_maxmn, gpu_maxmn, 4UL, cudaMemcpyDeviceToHost),
        __FILE__, __LINE__);
    if (cpu_maxmn < 0) {
      cpu_maxmn = cpu_B->size[0];
      u0 = cpu_B->size[0];
      cpu_B->size[0] = cpu_maxmn;
      emxEnsureCapacity_real_T(cpu_B, u0, &jf_emlrtRTEI);
      A_outdatedOnCpu = true;
      for (u0 = 0; u0 < cpu_maxmn; u0++) {
        cpu_B->data[u0] = rtNaN;
        B_outdatedOnGpu = true;
      }
    }
    mwGetLaunchParameters1D(computeNumIters(na), &grid, &block, 2147483647U);
    if (A_outdatedOnCpu) {
      gpuEmxEnsureCapacity_real_T(cpu_B, &gpu_B, !B_outdatedOnGpu);
    }
    gpuEmxEnsureCapacity_int32_T(cpu_jpvt, &gpu_jpvt, !jpvt_outdatedOnGpu);
    gpuEmxEnsureCapacity_real_T(cpu_Y, gpu_Y, !*Y_outdatedOnGpu);
    if (B_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_B, cpu_B);
    }
    if (jpvt_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_int32_T(&gpu_jpvt, cpu_jpvt);
    }
    if (*Y_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real_T(gpu_Y, cpu_Y);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      mldivide_kernel39<<<grid, block>>>(gpu_B, gpu_jpvt, na, *gpu_Y);
    }
    *Y_outdatedOnGpu = false;
    *Y_outdatedOnCpu = true;
    for (minmn = 0; minmn <= na; minmn++) {
      u0 = cpu_jpvt->data[na - minmn];
      if (*Y_outdatedOnCpu) {
        gpuEmxMemcpyGpuToCpu_real_T(cpu_Y, gpu_Y);
      }
      cpu_Y->data[u0 - 1] /=
          cpu_A->data[(na - minmn) + cpu_A->size[0] * (na - minmn)];
      *Y_outdatedOnCpu = false;
      *Y_outdatedOnGpu = true;
      cpu_maxmn = na - minmn;
      for (u0 = 0; u0 < cpu_maxmn; u0++) {
        cpu_Y->data[cpu_jpvt->data[u0] - 1] -=
            cpu_Y->data[cpu_jpvt->data[na - minmn] - 1] *
            cpu_A->data[u0 + cpu_A->size[0] * (na - minmn)];
      }
    }
  }
  emxFree_real_T(&cpu_B);
  emxFree_int32_T(&cpu_IPIV);
  emxFree_ptrdiff_t(&jpvt_t);
  emxFree_real_T(&b_cpu_A);
  emxFree_real_T(&cpu_tau);
  emxFree_int32_T(&cpu_jpvt);
  emxFree_real_T(&cpu_A);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  gpuEmxFree_real_T(&b_gpu_A);
  gpuEmxFree_int32_T(&gpu_jpvt);
  gpuEmxFree_real_T(&gpu_tau);
  gpuEmxFree_real_T(&gpu_A);
  gpuEmxFree_int32_T(&gpu_IPIV);
  gpuEmxFree_real_T(&gpu_B);
  checkCudaError(mwCudaFree(gpu_maxmn), __FILE__, __LINE__);
}

} // namespace coder

// End of code generation (mldivide.cu)
