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
#include "ec_detr_data.h"
#include "ec_detr_emxutil.h"
#include "ec_detr_mexutil.h"
#include "ec_detr_types.h"
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
#include <cstring>

// Variable Definitions
static emlrtRTEInfo md_emlrtRTEI{
    31,                // lineNo
    5,                 // colNo
    "mrdivide_helper", // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/"
    "mrdivide_helper.m" // pName
};

static emlrtRTEInfo
    nd_emlrtRTEI{
        1,        // lineNo
        37,       // colNo
        "xgetrf", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/"
        "xgetrf.m" // pName
    };

static emlrtRTEInfo od_emlrtRTEI{
    44,                // lineNo
    32,                // colNo
    "mrdivide_helper", // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/"
    "mrdivide_helper.m" // pName
};

static emlrtRTEInfo pd_emlrtRTEI{
    18,           // lineNo
    29,           // colNo
    "xgetrf_gpu", // fName
    "/usr/local/MATLAB/R2024a/toolbox/gpucoder/gpucoder/+coder/+internal/"
    "+lapack/xgetrf_gpu.m" // pName
};

static emlrtRTEInfo qd_emlrtRTEI{
    44,                // lineNo
    35,                // colNo
    "mrdivide_helper", // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/"
    "mrdivide_helper.m" // pName
};

static emlrtRTEInfo rd_emlrtRTEI{
    50,           // lineNo
    31,           // colNo
    "xgetrf_gpu", // fName
    "/usr/local/MATLAB/R2024a/toolbox/gpucoder/gpucoder/+coder/+internal/"
    "+lapack/xgetrf_gpu.m" // pName
};

static emlrtRTEInfo
    sd_emlrtRTEI{
        61,       // lineNo
        9,        // colNo
        "xgeqp3", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/"
        "xgeqp3.m" // pName
    };

static emlrtRTEInfo td_emlrtRTEI{
    53,           // lineNo
    13,           // colNo
    "xgetrf_gpu", // fName
    "/usr/local/MATLAB/R2024a/toolbox/gpucoder/gpucoder/+coder/+internal/"
    "+lapack/xgetrf_gpu.m" // pName
};

static emlrtRTEInfo
    ud_emlrtRTEI{
        92,       // lineNo
        22,       // colNo
        "xgeqp3", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/"
        "xgeqp3.m" // pName
    };

static emlrtRTEInfo
    vd_emlrtRTEI{
        105,      // lineNo
        1,        // colNo
        "xgeqp3", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+lapack/"
        "xgeqp3.m" // pName
    };

static emlrtRTEInfo wd_emlrtRTEI{
    85,        // lineNo
    1,         // colNo
    "qrsolve", // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/qrsolve.m" // pName
};

static emlrtRTEInfo xd_emlrtRTEI{
    119,       // lineNo
    5,         // colNo
    "qrsolve", // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/qrsolve.m" // pName
};

static emlrtRTEInfo yd_emlrtRTEI{
    44,                // lineNo
    5,                 // colNo
    "mrdivide_helper", // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/"
    "mrdivide_helper.m" // pName
};

static emlrtRTEInfo ae_emlrtRTEI{
    44,                // lineNo
    9,                 // colNo
    "mrdivide_helper", // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/"
    "mrdivide_helper.m" // pName
};

static emlrtRTEInfo be_emlrtRTEI{
    25,                // lineNo
    14,                // colNo
    "mrdivide_helper", // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/"
    "mrdivide_helper.m" // pName
};

static emlrtRTEInfo ce_emlrtRTEI{
    18,           // lineNo
    5,            // colNo
    "xgetrf_gpu", // fName
    "/usr/local/MATLAB/R2024a/toolbox/gpucoder/gpucoder/+coder/+internal/"
    "+lapack/xgetrf_gpu.m" // pName
};

// Function Declarations
static void cusolverCheck(cusolverStatus_t errCode, const char_T *file,
                          uint32_T b_line);

static void gpuEmxMemcpyGpuToCpu_int32_T(emxArray_int32_T *cpu,
                                         emxArray_int32_T *gpu);

static __global__ void mrdiv_kernel31(const int32_T b, const int32_T na,
                                      emxArray_real_T A, int32_T A_dim0);

static __global__ void mrdiv_kernel32(const emxArray_real_T B,
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

static void gpuEmxMemcpyGpuToCpu_int32_T(emxArray_int32_T *cpu,
                                         emxArray_int32_T *gpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }
  checkCudaError(cudaMemcpy(cpu->data, gpu->data,
                            static_cast<uint32_T>(actualSize) * sizeof(int32_T),
                            cudaMemcpyDeviceToHost),
                 __FILE__, __LINE__);
}

static __global__ __launch_bounds__(1024, 1) void mrdiv_kernel31(
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
  checkCudaError(mwCudaMalloc(&gpu_minmn, 4UL), __FILE__, __LINE__);
  gpuEmxReset_int32_T(&gpu_ipiv_t);
  gpuEmxReset_real_T(&gpu_tau);
  gpuEmxReset_int32_T(&gpu_jpvt);
  gpuEmxReset_real_T(&b_gpu_A);
  gpuEmxReset_real_T(&gpu_B);
  gpuEmxReset_real_T(&c_gpu_A);
  gpuEmxReset_real_T(&gpu_Y);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real_T(&cpu_Y, 1, &ae_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_A, 2, &be_emlrtRTEI, true);
  emxInit_real_T(&cpu_B, 1, &qd_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_A, 2, &be_emlrtRTEI, true);
  emxInit_int32_T(&ipiv, 2, &be_emlrtRTEI, true);
  emxInit_int32_T(&cpu_jpvt, 2, &be_emlrtRTEI, true);
  emxInit_real_T(&cpu_tau, 1, &be_emlrtRTEI, true);
  emxInit_int32_T(&cpu_ipiv_t, 1, &ce_emlrtRTEI, true);
  emxInit_ptrdiff_t(&jpvt_t, 1, &vd_emlrtRTEI, true);
  if ((cpu_A->size[1] == 0) || ((B->size[0] == 0) || (B->size[1] == 0))) {
    int32_T i;
    cpu_minmn = B->size[0];
    i = cpu_A->size[0] * cpu_A->size[1];
    cpu_A->size[0] = 1;
    cpu_A->size[1] = B->size[0];
    emxEnsureCapacity_real_T(cpu_A, i, &md_emlrtRTEI);
    if (cpu_minmn - 1 >= 0) {
      if (*A_outdatedOnCpu) {
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
    boolean_T B_needsGpuEnsureCapacity;
    boolean_T b_A_outdatedOnCpu;
    boolean_T b_A_outdatedOnGpu;
    b_A_outdatedOnGpu = false;
    i = c_cpu_A->size[0] * c_cpu_A->size[1];
    c_cpu_A->size[0] = B->size[0];
    c_cpu_A->size[1] = B->size[1];
    emxEnsureCapacity_real_T(c_cpu_A, i, &nd_emlrtRTEI);
    for (i = 0; i < B->size[0] * B->size[1]; i++) {
      c_cpu_A->data[i] = B->data[i];
      b_A_outdatedOnGpu = true;
    }
    i = cpu_ipiv_t->size[0];
    cpu_ipiv_t->size[0] = B->size[1];
    emxEnsureCapacity_int32_T(cpu_ipiv_t, i, &pd_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(c_cpu_A, &b_gpu_A, !b_A_outdatedOnGpu);
    if (b_A_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, c_cpu_A);
    }
    cusolverCheck(
        cusolverDnDgetrf_bufferSize(getCuSolverGlobalHandle(), B->size[1],
                                    B->size[1], (double *)&b_gpu_A.data[0],
                                    B->size[1], getCuSolverWorkspaceReq()),
        __FILE__, __LINE__);
    setCuSolverWorkspaceTypeSize(8);
    cusolverInitWorkspace();
    b_A_outdatedOnCpu = false;
    gpuEmxEnsureCapacity_int32_T(cpu_ipiv_t, &gpu_ipiv_t, true);
    cusolverCheck(
        cusolverDnDgetrf(getCuSolverGlobalHandle(), B->size[1], B->size[1],
                         (double *)&b_gpu_A.data[0], B->size[1],
                         static_cast<real_T *>(getCuSolverWorkspaceBuff()),
                         &gpu_ipiv_t.data[0], gpu_minmn),
        __FILE__, __LINE__);
    B_needsGpuEnsureCapacity = true;
    b_A_outdatedOnGpu = false;
    i = ipiv->size[0] * ipiv->size[1];
    ipiv->size[0] = 1;
    ipiv->size[1] = cpu_ipiv_t->size[0];
    emxEnsureCapacity_int32_T(ipiv, i, &rd_emlrtRTEI);
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
      emxEnsureCapacity_real_T(c_cpu_A, i, &td_emlrtRTEI);
      b_A_outdatedOnCpu = true;
      for (i = 0; i < maxmn * cpu_minmn; i++) {
        c_cpu_A->data[i] = rtNaN;
        b_A_outdatedOnGpu = true;
      }
      maxmn = cpu_ipiv_t->size[0] - 1;
      for (int32_T u0{0}; u0 <= maxmn; u0++) {
        ipiv->data[u0] = u0 + 1;
      }
    } else {
      int32_T maxmn;
      maxmn = cpu_ipiv_t->size[0] - 1;
      for (int32_T u0{0}; u0 <= maxmn; u0++) {
        if (B_needsGpuEnsureCapacity) {
          gpuEmxMemcpyGpuToCpu_int32_T(cpu_ipiv_t, &gpu_ipiv_t);
        }
        B_needsGpuEnsureCapacity = false;
        ipiv->data[u0] = cpu_ipiv_t->data[u0];
      }
    }
    tol = 1.0;
    if (b_A_outdatedOnCpu) {
      gpuEmxEnsureCapacity_real_T(c_cpu_A, &b_gpu_A, !b_A_outdatedOnGpu);
    }
    gpuEmxEnsureCapacity_real_T(cpu_A, gpu_A, !*A_outdatedOnGpu);
    if (b_A_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_A, c_cpu_A);
    }
    if (*A_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real_T(gpu_A, cpu_A);
    }
    cublasCheck(cublasDtrsm(getCublasGlobalHandle(), CUBLAS_SIDE_RIGHT,
                            CUBLAS_FILL_MODE_UPPER, CUBLAS_OP_N,
                            CUBLAS_DIAG_NON_UNIT, 1, B->size[1], (double *)&tol,
                            (double *)&b_gpu_A.data[0], B->size[1],
                            (double *)&gpu_A->data[0], 1),
                __FILE__, __LINE__);
    cublasCheck(cublasDtrsm(getCublasGlobalHandle(), CUBLAS_SIDE_RIGHT,
                            CUBLAS_FILL_MODE_LOWER, CUBLAS_OP_N,
                            CUBLAS_DIAG_UNIT, 1, B->size[1], (double *)&tol,
                            (double *)&b_gpu_A.data[0], B->size[1],
                            (double *)&gpu_A->data[0], 1),
                __FILE__, __LINE__);
    *A_outdatedOnGpu = false;
    *A_outdatedOnCpu = true;
    cpu_minmn = B->size[1] - 2;
    for (int32_T u0{0}; u0 <= cpu_minmn; u0++) {
      i = ipiv->data[cpu_minmn - u0];
      if (i != (cpu_minmn - u0) + 1) {
        if (*A_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_A, gpu_A);
        }
        tol = cpu_A->data[cpu_minmn - u0];
        cpu_A->data[cpu_minmn - u0] = cpu_A->data[i - 1];
        cpu_A->data[i - 1] = tol;
        *A_outdatedOnCpu = false;
        *A_outdatedOnGpu = true;
      }
    }
  } else {
    ptrdiff_t info_t;
    real_T tol;
    int32_T i;
    int32_T maxmn;
    int32_T minmana;
    int32_T na;
    int32_T u0;
    boolean_T B_needsGpuEnsureCapacity;
    boolean_T B_outdatedOnGpu;
    boolean_T b_A_outdatedOnCpu;
    boolean_T b_A_outdatedOnGpu;
    boolean_T jpvt_outdatedOnGpu;
    boolean_T validLaunchParams;
    b_A_outdatedOnCpu = false;
    i = b_cpu_A->size[0] * b_cpu_A->size[1];
    b_cpu_A->size[0] = B->size[1];
    b_cpu_A->size[1] = B->size[0];
    emxEnsureCapacity_real_T(b_cpu_A, i, &od_emlrtRTEI);
    for (i = 0; i < B->size[0]; i++) {
      for (maxmn = 0; maxmn < B->size[1]; maxmn++) {
        b_cpu_A->data[maxmn + b_cpu_A->size[0] * i] =
            B->data[i + B->size[0] * maxmn];
      }
    }
    B_outdatedOnGpu = false;
    i = cpu_B->size[0];
    cpu_B->size[0] = cpu_A->size[1];
    emxEnsureCapacity_real_T(cpu_B, i, &qd_emlrtRTEI);
    for (i = 0; i < cpu_A->size[1]; i++) {
      if (*A_outdatedOnCpu) {
        gpuEmxMemcpyGpuToCpu_real_T(cpu_A, gpu_A);
      }
      *A_outdatedOnCpu = false;
      cpu_B->data[i] = cpu_A->data[i];
      B_outdatedOnGpu = true;
    }
    maxmn = b_cpu_A->size[0];
    na = b_cpu_A->size[1] - 1;
    jpvt_outdatedOnGpu = false;
    i = cpu_jpvt->size[0] * cpu_jpvt->size[1];
    cpu_jpvt->size[0] = 1;
    cpu_jpvt->size[1] = b_cpu_A->size[1];
    emxEnsureCapacity_int32_T(cpu_jpvt, i, &sd_emlrtRTEI);
    u0 = b_cpu_A->size[0];
    minmana = b_cpu_A->size[1];
    if (u0 <= minmana) {
      minmana = u0;
    }
    i = cpu_tau->size[0];
    cpu_tau->size[0] = minmana;
    emxEnsureCapacity_real_T(cpu_tau, i, &ud_emlrtRTEI);
    i = jpvt_t->size[0];
    jpvt_t->size[0] = b_cpu_A->size[1];
    emxEnsureCapacity_ptrdiff_t(jpvt_t, i, &vd_emlrtRTEI);
    for (i = 0; i < b_cpu_A->size[1]; i++) {
      cpu_jpvt->data[i] = 0;
      jpvt_outdatedOnGpu = true;
      jpvt_t->data[i] = (ptrdiff_t)0;
    }
    info_t = LAPACKE_dgeqp3(102, (ptrdiff_t)b_cpu_A->size[0],
                            (ptrdiff_t)b_cpu_A->size[1], &b_cpu_A->data[0],
                            (ptrdiff_t)b_cpu_A->size[0], &jpvt_t->data[0],
                            &cpu_tau->data[0]);
    b_A_outdatedOnGpu = true;
    if ((int32_T)info_t != 0) {
      int64_T b;
      mwGetLaunchParameters1D(computeNumIters(na, maxmn - 1), &grid, &block,
                              2147483647U);
      gpuEmxEnsureCapacity_real_T(b_cpu_A, &c_gpu_A, false);
      gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_A, b_cpu_A);
      validLaunchParams = mwValidateLaunchParameters(grid, block);
      if (validLaunchParams) {
        mrdiv_kernel31<<<grid, block>>>(maxmn - 1, na, c_gpu_A,
                                        b_cpu_A->size[0U]);
      }
      b_A_outdatedOnGpu = false;
      b_A_outdatedOnCpu = true;
      u0 = b_cpu_A->size[0];
      cpu_minmn = b_cpu_A->size[1];
      if (u0 <= cpu_minmn) {
        cpu_minmn = u0;
      }
      for (u0 = 0; u0 < cpu_minmn; u0++) {
        cpu_tau->data[u0] = rtNaN;
      }
      b = computeEndIdx(static_cast<int64_T>(cpu_minmn + 1),
                        static_cast<int64_T>(minmana), 1L);
      for (int64_T k{0L}; k <= b; k++) {
        cpu_tau->data[static_cast<int32_T>((cpu_minmn + 1) + k) - 1] = 0.0;
      }
      for (u0 = 0; u0 <= na; u0++) {
        cpu_jpvt->data[u0] = u0 + 1;
        jpvt_outdatedOnGpu = true;
      }
    } else {
      for (u0 = 0; u0 <= na; u0++) {
        cpu_jpvt->data[u0] = (int32_T)jpvt_t->data[u0];
        jpvt_outdatedOnGpu = true;
      }
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
      gpuEmxMemcpyGpuToCpu_real_T(b_cpu_A, &c_gpu_A);
    }
    tol = std::fmin(1.4901161193847656E-8,
                    2.2204460492503131E-15 * static_cast<real_T>(maxmn)) *
          std::abs(b_cpu_A->data[0]);
    while ((na + 1 < cpu_minmn) &&
           (!(std::abs(b_cpu_A->data[(na + b_cpu_A->size[0] * (na + 1)) + 1]) <=
              tol))) {
      na++;
    }
    b_A_outdatedOnCpu = false;
    i = cpu_Y->size[0];
    cpu_Y->size[0] = b_cpu_A->size[1];
    emxEnsureCapacity_real_T(cpu_Y, i, &wd_emlrtRTEI);
    for (i = 0; i < b_cpu_A->size[1]; i++) {
      cpu_Y->data[i] = 0.0;
      b_A_outdatedOnCpu = true;
    }
    cpu_minmn = 0;
    u0 = b_cpu_A->size[0];
    maxmn = b_cpu_A->size[1];
    if (u0 <= maxmn) {
      maxmn = u0;
    }
    gpuEmxEnsureCapacity_real_T(b_cpu_A, &c_gpu_A, !b_A_outdatedOnGpu);
    gpuEmxEnsureCapacity_real_T(cpu_tau, &gpu_tau, false);
    gpuEmxEnsureCapacity_real_T(cpu_B, &gpu_B, !B_outdatedOnGpu);
    if (b_A_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real_T(&c_gpu_A, b_cpu_A);
    }
    gpuEmxMemcpyCpuToGpu_real_T(&gpu_tau, cpu_tau);
    if (B_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_B, cpu_B);
    }
    cusolverCheck(cusolverDnDormqr_bufferSize(
                      getCuSolverGlobalHandle(), CUBLAS_SIDE_LEFT, CUBLAS_OP_T,
                      cpu_B->size[0], 1, maxmn, (double *)&c_gpu_A.data[0],
                      b_cpu_A->size[0], (double *)&gpu_tau.data[0],
                      (double *)&gpu_B.data[0], cpu_B->size[0],
                      getCuSolverWorkspaceReq()),
                  __FILE__, __LINE__);
    setCuSolverWorkspaceTypeSize(8);
    cusolverInitWorkspace();
    B_needsGpuEnsureCapacity = false;
    checkCudaError(
        cudaMemcpy(gpu_minmn, &cpu_minmn, 4UL, cudaMemcpyHostToDevice),
        __FILE__, __LINE__);
    cusolverCheck(cusolverDnDormqr(
                      getCuSolverGlobalHandle(), CUBLAS_SIDE_LEFT, CUBLAS_OP_T,
                      cpu_B->size[0], 1, maxmn, (double *)&c_gpu_A.data[0],
                      b_cpu_A->size[0], (double *)&gpu_tau.data[0],
                      (double *)&gpu_B.data[0], cpu_B->size[0],
                      static_cast<real_T *>(getCuSolverWorkspaceBuff()),
                      *getCuSolverWorkspaceReq(), gpu_minmn),
                  __FILE__, __LINE__);
    B_outdatedOnGpu = false;
    checkCudaError(
        cudaMemcpy(&cpu_minmn, gpu_minmn, 4UL, cudaMemcpyDeviceToHost),
        __FILE__, __LINE__);
    if (cpu_minmn < 0) {
      maxmn = cpu_B->size[0];
      i = cpu_B->size[0];
      cpu_B->size[0] = maxmn;
      emxEnsureCapacity_real_T(cpu_B, i, &xd_emlrtRTEI);
      B_needsGpuEnsureCapacity = true;
      for (i = 0; i < maxmn; i++) {
        cpu_B->data[i] = rtNaN;
        B_outdatedOnGpu = true;
      }
    }
    mwGetLaunchParameters1D(computeNumIters(na), &grid, &block, 2147483647U);
    if (B_needsGpuEnsureCapacity) {
      gpuEmxEnsureCapacity_real_T(cpu_B, &gpu_B, !B_outdatedOnGpu);
    }
    gpuEmxEnsureCapacity_int32_T(cpu_jpvt, &gpu_jpvt, !jpvt_outdatedOnGpu);
    gpuEmxEnsureCapacity_real_T(cpu_Y, &gpu_Y, !b_A_outdatedOnCpu);
    if (B_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_B, cpu_B);
    }
    if (jpvt_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_int32_T(&gpu_jpvt, cpu_jpvt);
    }
    if (b_A_outdatedOnCpu) {
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_Y, cpu_Y);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      mrdiv_kernel32<<<grid, block>>>(gpu_B, gpu_jpvt, na, gpu_Y);
    }
    b_A_outdatedOnCpu = true;
    for (u0 = 0; u0 <= na; u0++) {
      i = cpu_jpvt->data[na - u0];
      if (b_A_outdatedOnCpu) {
        gpuEmxMemcpyGpuToCpu_real_T(cpu_Y, &gpu_Y);
      }
      cpu_Y->data[i - 1] /=
          b_cpu_A->data[(na - u0) + b_cpu_A->size[0] * (na - u0)];
      b_A_outdatedOnCpu = false;
      maxmn = na - u0;
      for (cpu_minmn = 0; cpu_minmn < maxmn; cpu_minmn++) {
        cpu_Y->data[cpu_jpvt->data[cpu_minmn] - 1] -=
            cpu_Y->data[cpu_jpvt->data[na - u0] - 1] *
            b_cpu_A->data[cpu_minmn + b_cpu_A->size[0] * (na - u0)];
      }
    }
    i = cpu_A->size[0] * cpu_A->size[1];
    cpu_A->size[0] = 1;
    cpu_A->size[1] = cpu_Y->size[0];
    emxEnsureCapacity_real_T(cpu_A, i, &yd_emlrtRTEI);
    for (i = 0; i < cpu_Y->size[0]; i++) {
      if (*A_outdatedOnCpu) {
        gpuEmxMemcpyGpuToCpu_real_T(cpu_A, gpu_A);
      }
      if (b_A_outdatedOnCpu) {
        gpuEmxMemcpyGpuToCpu_real_T(cpu_Y, &gpu_Y);
      }
      b_A_outdatedOnCpu = false;
      cpu_A->data[i] = cpu_Y->data[i];
      *A_outdatedOnCpu = false;
      *A_outdatedOnGpu = true;
    }
  }
  emxFree_ptrdiff_t(&jpvt_t);
  emxFree_int32_T(&cpu_ipiv_t);
  emxFree_real_T(&cpu_tau);
  emxFree_int32_T(&cpu_jpvt);
  emxFree_int32_T(&ipiv);
  emxFree_real_T(&c_cpu_A);
  emxFree_real_T(&cpu_B);
  emxFree_real_T(&b_cpu_A);
  emxFree_real_T(&cpu_Y);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  gpuEmxFree_real_T(&gpu_Y);
  gpuEmxFree_real_T(&c_gpu_A);
  gpuEmxFree_real_T(&gpu_B);
  gpuEmxFree_real_T(&b_gpu_A);
  gpuEmxFree_int32_T(&gpu_jpvt);
  gpuEmxFree_real_T(&gpu_tau);
  gpuEmxFree_int32_T(&gpu_ipiv_t);
  checkCudaError(mwCudaFree(gpu_minmn), __FILE__, __LINE__);
}

} // namespace internal
} // namespace coder

// End of code generation (mrdivide_helper.cu)
