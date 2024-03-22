//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// mtimes.cu
//
// Code generation for function 'mtimes'
//

// Include files
#include "mtimes.h"
#include "ec_wtc_fp_emxutil.h"
#include "ec_wtc_fp_mexutil.h"
#include "ec_wtc_fp_types.h"
#include "rt_nonfinite.h"
#include "MWCUBLASUtils.hpp"
#include "MWCudaMemoryFunctions.hpp"
#include "MWErrorCodeUtils.hpp"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"

// Variable Definitions
static emlrtRTEInfo
    xd_emlrtRTEI{
        158,      // lineNo
        24,       // colNo
        "mtimes", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+blas/"
        "mtimes.m" // pName
    };

static emlrtRTEInfo
    yd_emlrtRTEI{
        140,      // lineNo
        5,        // colNo
        "mtimes", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+blas/"
        "mtimes.m" // pName
    };

// Function Declarations
static void cublasCheck(cublasStatus_t errCode, const char_T *file,
                        uint32_T b_line);

// Function Definitions
static void cublasCheck(cublasStatus_t errCode, const char_T *file,
                        uint32_T b_line)
{
  const char *errName;
  const char *errString;
  nvtxRangePushA("#fcn#cublasCheck#" MW_AT_LOCATION);
  if (errCode != CUBLAS_STATUS_SUCCESS) {
    cublasGetErrorName(errCode, &errName);
    cublasGetErrorString(errCode, &errString);
    nvtxMarkA("#raiseCudaError#" MW_AT_LINE);
    raiseCudaError(errCode, file, b_line, errName, errString);
  }
  nvtxRangePop();
}

//
//
namespace coder {
namespace internal {
namespace blas {
void mtimes(emxArray_real_T *cpu_A, emxArray_real_T *gpu_A,
            boolean_T *A_outdatedOnGpu, const real_T cpu_B_data[],
            emxArray_real_T *cpu_C, boolean_T *C_outdatedOnCpu,
            emxArray_real_T *gpu_C, boolean_T *C_outdatedOnGpu)
{
  real_T *gpu_B_data;
  nvtxRangePushA("#fcn#mtimes#" MW_AT_LOCATION);
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaMalloc#" MW_AT_LINE);
  checkCudaError(mwCudaMalloc(&gpu_B_data, sizeof(real_T)), __FILE__, __LINE__);
  if ((cpu_A->size[0] == 0) || (cpu_A->size[1] == 0)) {
    int32_T i;
    *C_outdatedOnCpu = false;
    *C_outdatedOnGpu = false;
    i = cpu_C->size[0];
    cpu_C->size[0] = cpu_A->size[0];
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(cpu_C, i, &yd_emlrtRTEI);
    profileLoopStart("mtimes_loop_0", __LINE__, (cpu_A->size[0] - 1) + 1, "");
    for (i = 0; i < cpu_A->size[0]; i++) {
      cpu_C->data[i] = 0.0;
      *C_outdatedOnGpu = true;
    }
    profileLoopEnd();
  } else {
    real_T alpha1;
    real_T beta1;
    int32_T i;
    i = cpu_C->size[0];
    cpu_C->size[0] = cpu_A->size[0];
    nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
    emxEnsureCapacity_real_T(cpu_C, i, &xd_emlrtRTEI);
    alpha1 = 1.0;
    beta1 = 0.0;
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_A, gpu_A, !*A_outdatedOnGpu);
    nvtxMarkA("#gpuEmxEnsureCapacity_real_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real_T(cpu_C, gpu_C, true);
    if (*A_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real_T(gpu_A, cpu_A);
    }
    *A_outdatedOnGpu = false;
    nvtxMarkA("#checkCudaError#" MW_AT_LINE);
    nvtxMarkA("#cudaMemcpy#" MW_AT_LINE);
    checkCudaError(cudaMemcpy(gpu_B_data, cpu_B_data, sizeof(real_T),
                              cudaMemcpyHostToDevice),
                   __FILE__, __LINE__);
    nvtxMarkA("#cublasCheck#" MW_AT_LINE);
    cublasCheck(cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                            cpu_A->size[0], 1, cpu_A->size[1],
                            (double *)&alpha1, (double *)&gpu_A->data[0],
                            cpu_A->size[0], (double *)&gpu_B_data[0],
                            cpu_A->size[1], (double *)&beta1,
                            (double *)&gpu_C->data[0], cpu_A->size[0]),
                __FILE__, __LINE__);
    *C_outdatedOnGpu = false;
    *C_outdatedOnCpu = true;
  }
  nvtxMarkA("#checkCudaError#" MW_AT_LINE);
  nvtxMarkA("#mwCudaFree#" MW_AT_LINE);
  checkCudaError(mwCudaFree(gpu_B_data), __FILE__, __LINE__);
  nvtxRangePop();
}

} // namespace blas
} // namespace internal
} // namespace coder

// End of code generation (mtimes.cu)
