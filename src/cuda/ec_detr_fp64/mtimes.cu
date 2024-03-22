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
#include "ec_detr_data.h"
#include "ec_detr_emxutil.h"
#include "ec_detr_mexutil.h"
#include "ec_detr_types.h"
#include "rt_nonfinite.h"
#include "MWCUBLASUtils.hpp"

// Variable Definitions
static emlrtRTEInfo
    d_emlrtRTEI{
        140,      // lineNo
        5,        // colNo
        "mtimes", // fName
        "/usr/local/MATLAB/R2024a/toolbox/eml/eml/+coder/+internal/+blas/"
        "mtimes.m" // pName
    };

// Function Definitions
//
//
namespace coder {
namespace internal {
namespace blas {
void b_mtimes(emxArray_real_T *cpu_A, emxArray_real_T *gpu_A,
              boolean_T *A_outdatedOnGpu, emxArray_real_T *cpu_B,
              emxArray_real_T *gpu_B, boolean_T *B_outdatedOnGpu,
              emxArray_real_T *cpu_C, boolean_T *C_outdatedOnCpu,
              emxArray_real_T *gpu_C, boolean_T *C_outdatedOnGpu)
{
  if ((cpu_A->size[0] == 0) || (cpu_A->size[1] == 0) || (cpu_B->size[0] == 0)) {
    int32_T i;
    *C_outdatedOnCpu = false;
    *C_outdatedOnGpu = false;
    i = cpu_C->size[0];
    cpu_C->size[0] = cpu_A->size[0];
    emxEnsureCapacity_real_T(cpu_C, i, &d_emlrtRTEI);
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
    emxEnsureCapacity_real_T(cpu_C, i, &c_emlrtRTEI);
    alpha1 = 1.0;
    beta1 = 0.0;
    gpuEmxEnsureCapacity_real_T(cpu_A, gpu_A, !*A_outdatedOnGpu);
    gpuEmxEnsureCapacity_real_T(cpu_B, gpu_B, !*B_outdatedOnGpu);
    gpuEmxEnsureCapacity_real_T(cpu_C, gpu_C, true);
    if (*A_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real_T(gpu_A, cpu_A);
    }
    *A_outdatedOnGpu = false;
    if (*B_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real_T(gpu_B, cpu_B);
    }
    *B_outdatedOnGpu = false;
    cublasCheck(cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                            cpu_A->size[0], 1, cpu_A->size[1],
                            (double *)&alpha1, (double *)&gpu_A->data[0],
                            cpu_A->size[0], (double *)&gpu_B->data[0],
                            cpu_A->size[1], (double *)&beta1,
                            (double *)&gpu_C->data[0], cpu_A->size[0]),
                __FILE__, __LINE__);
    *C_outdatedOnGpu = false;
    *C_outdatedOnCpu = true;
  }
}

//
//
void mtimes(emxArray_real_T *cpu_A, emxArray_real_T *gpu_A,
            boolean_T *A_outdatedOnGpu, emxArray_real_T *cpu_B,
            emxArray_real_T *gpu_B, boolean_T *B_outdatedOnGpu,
            emxArray_real_T *cpu_C, boolean_T *C_outdatedOnCpu,
            emxArray_real_T *gpu_C, boolean_T *C_outdatedOnGpu)
{
  if ((cpu_A->size[0] == 0) || (cpu_A->size[1] == 0) || (cpu_B->size[0] == 0) ||
      (cpu_B->size[1] == 0)) {
    int32_T i;
    *C_outdatedOnCpu = false;
    *C_outdatedOnGpu = false;
    i = cpu_C->size[0] * cpu_C->size[1];
    cpu_C->size[0] = cpu_A->size[0];
    cpu_C->size[1] = cpu_B->size[1];
    emxEnsureCapacity_real_T(cpu_C, i, &d_emlrtRTEI);
    for (i = 0; i < cpu_A->size[0] * cpu_B->size[1]; i++) {
      cpu_C->data[i] = 0.0;
      *C_outdatedOnGpu = true;
    }
  } else {
    real_T alpha1;
    real_T beta1;
    int32_T i;
    i = cpu_C->size[0] * cpu_C->size[1];
    cpu_C->size[0] = cpu_A->size[0];
    cpu_C->size[1] = cpu_B->size[1];
    emxEnsureCapacity_real_T(cpu_C, i, &c_emlrtRTEI);
    alpha1 = 1.0;
    beta1 = 0.0;
    gpuEmxEnsureCapacity_real_T(cpu_A, gpu_A, !*A_outdatedOnGpu);
    gpuEmxEnsureCapacity_real_T(cpu_B, gpu_B, !*B_outdatedOnGpu);
    gpuEmxEnsureCapacity_real_T(cpu_C, gpu_C, true);
    if (*A_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real_T(gpu_A, cpu_A);
    }
    *A_outdatedOnGpu = false;
    if (*B_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real_T(gpu_B, cpu_B);
    }
    *B_outdatedOnGpu = false;
    cublasCheck(cublasDgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                            cpu_A->size[0], cpu_B->size[1], cpu_A->size[1],
                            (double *)&alpha1, (double *)&gpu_A->data[0],
                            cpu_A->size[0], (double *)&gpu_B->data[0],
                            cpu_A->size[1], (double *)&beta1,
                            (double *)&gpu_C->data[0], cpu_A->size[0]),
                __FILE__, __LINE__);
    *C_outdatedOnGpu = false;
    *C_outdatedOnCpu = true;
  }
}

} // namespace blas
} // namespace internal
} // namespace coder

// End of code generation (mtimes.cu)
