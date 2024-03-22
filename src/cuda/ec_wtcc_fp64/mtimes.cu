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
#include "ec_wtcc_emxutil.h"
#include "ec_wtcc_mexutil.h"
#include "ec_wtcc_types.h"
#include "rt_nonfinite.h"
#include "MWCUBLASUtils.hpp"
#include "MWCudaMemoryFunctions.hpp"
#include "MWErrorCodeUtils.hpp"

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
  if (errCode != CUBLAS_STATUS_SUCCESS) {
    cublasGetErrorName(errCode, &errName);
    cublasGetErrorString(errCode, &errString);
    raiseCudaError(errCode, file, b_line, errName, errString);
  }
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
  checkCudaError(mwCudaMalloc(&gpu_B_data, sizeof(real_T)), __FILE__, __LINE__);
  if ((cpu_A->size[0] == 0) || (cpu_A->size[1] == 0)) {
    int32_T i;
    *C_outdatedOnCpu = false;
    *C_outdatedOnGpu = false;
    i = cpu_C->size[0];
    cpu_C->size[0] = cpu_A->size[0];
    emxEnsureCapacity_real_T(cpu_C, i, &yd_emlrtRTEI);
    for (i = 0; i < cpu_A->size[0]; i++) {
      cpu_C->data[i] = 0.0;
      *C_outdatedOnGpu = true;
    }
  } else {
    real_T alpha1;
    real_T beta1;
    int32_T i;
    i = cpu_C->size[0];
    cpu_C->size[0] = cpu_A->size[0];
    emxEnsureCapacity_real_T(cpu_C, i, &xd_emlrtRTEI);
    alpha1 = 1.0;
    beta1 = 0.0;
    gpuEmxEnsureCapacity_real_T(cpu_A, gpu_A, !*A_outdatedOnGpu);
    gpuEmxEnsureCapacity_real_T(cpu_C, gpu_C, true);
    if (*A_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real_T(gpu_A, cpu_A);
    }
    *A_outdatedOnGpu = false;
    checkCudaError(cudaMemcpy(gpu_B_data, cpu_B_data, sizeof(real_T),
                              cudaMemcpyHostToDevice),
                   __FILE__, __LINE__);
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
  checkCudaError(mwCudaFree(gpu_B_data), __FILE__, __LINE__);
}

} // namespace blas
} // namespace internal
} // namespace coder

// End of code generation (mtimes.cu)
