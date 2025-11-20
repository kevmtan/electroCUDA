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
#include "ec_detr_fp_data.h"
#include "ec_detr_fp_emxutil.h"
#include "ec_detr_fp_mexutil.h"
#include "ec_detr_fp_types.h"
#include "rt_nonfinite.h"
#include "MWCUBLASUtils.hpp"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"

// Variable Definitions
static emlrtRTEInfo
    d_emlrtRTEI{
        140,      // lineNo
        5,        // colNo
        "mtimes", // fName
        "/usr/local/MATLAB/R2024b/toolbox/eml/eml/+coder/+internal/+blas/"
        "mtimes.m" // pName
    };

// Function Definitions
//
//
namespace coder {
namespace internal {
namespace blas {
void b_mtimes(emxArray_real32_T *cpu_A, emxArray_real32_T *gpu_A,
              boolean_T *A_outdatedOnGpu, emxArray_real32_T *cpu_B,
              emxArray_real32_T *gpu_B, boolean_T *B_outdatedOnGpu,
              emxArray_real32_T *cpu_C, boolean_T *C_outdatedOnCpu,
              emxArray_real32_T *gpu_C, boolean_T *C_outdatedOnGpu)
{
  nvtxRangePushA("#fcn#b_mtimes#" MW_AT_LOCATION);
  if ((cpu_A->size[0] == 0) || (cpu_A->size[1] == 0) || (cpu_B->size[0] == 0)) {
    int32_T i;
    *C_outdatedOnCpu = false;
    *C_outdatedOnGpu = false;
    i = cpu_C->size[0];
    cpu_C->size[0] = cpu_A->size[0];
    nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
    emxEnsureCapacity_real32_T(cpu_C, i, &d_emlrtRTEI);
    profileLoopStart("b_mtimes_loop_0", __LINE__, (cpu_A->size[0] - 1) + 1, "");
    for (i = 0; i < cpu_A->size[0]; i++) {
      cpu_C->data[i] = 0.0F;
      *C_outdatedOnGpu = true;
    }
    profileLoopEnd();
  } else {
    int32_T i;
    real32_T alpha1;
    real32_T beta1;
    i = cpu_C->size[0];
    cpu_C->size[0] = cpu_A->size[0];
    nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
    emxEnsureCapacity_real32_T(cpu_C, i, &c_emlrtRTEI);
    alpha1 = 1.0F;
    beta1 = 0.0F;
    nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real32_T(cpu_A, gpu_A, !*A_outdatedOnGpu);
    nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real32_T(cpu_B, gpu_B, !*B_outdatedOnGpu);
    nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real32_T(cpu_C, gpu_C, true);
    if (*A_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real32_T(gpu_A, cpu_A);
    }
    *A_outdatedOnGpu = false;
    if (*B_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real32_T(gpu_B, cpu_B);
    }
    *B_outdatedOnGpu = false;
    cublasSgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                cpu_A->size[0], 1, cpu_A->size[1], (float *)&alpha1,
                (float *)&gpu_A->data[0], cpu_A->size[0],
                (float *)&gpu_B->data[0], cpu_A->size[1], (float *)&beta1,
                (float *)&gpu_C->data[0], cpu_A->size[0]);
    *C_outdatedOnGpu = false;
    *C_outdatedOnCpu = true;
  }
  nvtxRangePop();
}

//
//
void mtimes(emxArray_real32_T *cpu_A, emxArray_real32_T *gpu_A,
            boolean_T *A_outdatedOnGpu, emxArray_real32_T *cpu_B,
            emxArray_real32_T *gpu_B, boolean_T *B_outdatedOnGpu,
            emxArray_real32_T *cpu_C, boolean_T *C_outdatedOnCpu,
            emxArray_real32_T *gpu_C, boolean_T *C_outdatedOnGpu)
{
  nvtxRangePushA("#fcn#mtimes#" MW_AT_LOCATION);
  if ((cpu_A->size[0] == 0) || (cpu_A->size[1] == 0) || (cpu_B->size[0] == 0) ||
      (cpu_B->size[1] == 0)) {
    int32_T i;
    *C_outdatedOnCpu = false;
    *C_outdatedOnGpu = false;
    i = cpu_C->size[0] * cpu_C->size[1];
    cpu_C->size[0] = cpu_A->size[0];
    cpu_C->size[1] = cpu_B->size[1];
    nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
    emxEnsureCapacity_real32_T(cpu_C, i, &d_emlrtRTEI);
    profileLoopStart("mtimes_loop_0", __LINE__,
                     (cpu_A->size[0] * cpu_B->size[1] - 1) + 1, "");
    for (i = 0; i < cpu_A->size[0] * cpu_B->size[1]; i++) {
      cpu_C->data[i] = 0.0F;
      *C_outdatedOnGpu = true;
    }
    profileLoopEnd();
  } else {
    int32_T i;
    real32_T alpha1;
    real32_T beta1;
    i = cpu_C->size[0] * cpu_C->size[1];
    cpu_C->size[0] = cpu_A->size[0];
    cpu_C->size[1] = cpu_B->size[1];
    nvtxMarkA("#emxEnsureCapacity_real32_T#" MW_AT_LINE);
    emxEnsureCapacity_real32_T(cpu_C, i, &c_emlrtRTEI);
    alpha1 = 1.0F;
    beta1 = 0.0F;
    nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real32_T(cpu_A, gpu_A, !*A_outdatedOnGpu);
    nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real32_T(cpu_B, gpu_B, !*B_outdatedOnGpu);
    nvtxMarkA("#gpuEmxEnsureCapacity_real32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_real32_T(cpu_C, gpu_C, true);
    if (*A_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real32_T(gpu_A, cpu_A);
    }
    *A_outdatedOnGpu = false;
    if (*B_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_real32_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_real32_T(gpu_B, cpu_B);
    }
    *B_outdatedOnGpu = false;
    cublasSgemm(getCublasGlobalHandle(), CUBLAS_OP_N, CUBLAS_OP_N,
                cpu_A->size[0], cpu_B->size[1], cpu_A->size[1],
                (float *)&alpha1, (float *)&gpu_A->data[0], cpu_A->size[0],
                (float *)&gpu_B->data[0], cpu_A->size[1], (float *)&beta1,
                (float *)&gpu_C->data[0], cpu_A->size[0]);
    *C_outdatedOnGpu = false;
    *C_outdatedOnCpu = true;
  }
  nvtxRangePop();
}

} // namespace blas
} // namespace internal
} // namespace coder

// End of code generation (mtimes.cu)
