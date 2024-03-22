//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// scNormalize.cu
//
// Code generation for function 'scNormalize'
//

// Include files
#include "scNormalize.h"
#include "ec_cwtAvg_data.h"
#include "ec_cwtAvg_emxutil.h"
#include "ec_cwtAvg_mexutil.h"
#include "ec_cwtAvg_types.h"
#include "rt_nonfinite.h"
#include "MWCUBLASUtils.hpp"
#include "MWCudaMemoryFunctions.hpp"
#include <cmath>

// Variable Definitions
static emlrtRTEInfo of_emlrtRTEI{
    12,                                                               // lineNo
    5,                                                                // colNo
    "trapz",                                                          // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/trapz.m" // pName
};

static emlrtRTEInfo pf_emlrtRTEI{
    12,            // lineNo
    12,            // colNo
    "scNormalize", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "scNormalize.m" // pName
};

static emlrtRTEInfo qf_emlrtRTEI{
    22,            // lineNo
    32,            // colNo
    "scNormalize", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "scNormalize.m" // pName
};

static emlrtRTEInfo rf_emlrtRTEI{
    12,            // lineNo
    1,             // colNo
    "scNormalize", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "scNormalize.m" // pName
};

static emlrtRTEInfo sf_emlrtRTEI{
    26,            // lineNo
    43,            // colNo
    "scNormalize", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "scNormalize.m" // pName
};

static emlrtRTEInfo tf_emlrtRTEI{
    26,            // lineNo
    37,            // colNo
    "scNormalize", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "scNormalize.m" // pName
};

// Function Definitions
//
//
namespace coder {
namespace wavelet {
namespace internal {
namespace cwt {
void scNormalize(emxArray_creal_T *cfs, real_T cpsi,
                 const emxArray_real_T *scales, real_T normfac)
{
  emxArray_real_T b_gpu_c;
  emxArray_real_T gpu_abscfssq;
  emxArray_real_T gpu_c;
  emxArray_real_T gpu_z;
  emxArray_real_T *a;
  emxArray_real_T *b_cpu_c;
  emxArray_real_T *cpu_abscfssq;
  emxArray_real_T *cpu_c;
  emxArray_real_T *cpu_z;
  emxArray_real_T *y;
  emxArray_uint32_T *b_y;
  real_T alpha1;
  real_T b_cpu_z;
  real_T c1;
  real_T *b_gpu_z;
  int32_T acoef;
  int32_T nx;
  int32_T u1;
  boolean_T abscfssq_outdatedOnGpu;
  boolean_T z_needsGpuEnsureCapacity;
  boolean_T z_outdatedOnGpu;
  gpuEmxReset_real_T(&b_gpu_c);
  checkCudaError(mwCudaMalloc(&b_gpu_z, 8UL), __FILE__, __LINE__);
  gpuEmxReset_real_T(&gpu_c);
  gpuEmxReset_real_T(&gpu_z);
  gpuEmxReset_real_T(&gpu_abscfssq);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  nx = cfs->size[0] * cfs->size[1];
  emxInit_real_T(&y, 2, &pf_emlrtRTEI, true);
  acoef = y->size[0] * y->size[1];
  y->size[0] = cfs->size[0];
  y->size[1] = cfs->size[1];
  emxEnsureCapacity_real_T(y, acoef, &l_emlrtRTEI);
  for (int32_T k{0}; k < nx; k++) {
    y->data[k] = rt_hypotd_snf(cfs->data[k].re, cfs->data[k].im);
  }
  emxInit_real_T(&a, 2, &qf_emlrtRTEI, true);
  acoef = a->size[0] * a->size[1];
  a->size[0] = y->size[0];
  a->size[1] = y->size[1];
  emxEnsureCapacity_real_T(a, acoef, &m_emlrtRTEI);
  nx = y->size[0] * y->size[1];
  for (int32_T k{0}; k < nx; k++) {
    a->data[k] = y->data[k] * y->data[k];
  }
  emxFree_real_T(&y);
  emxInit_real_T(&cpu_abscfssq, 2, &rf_emlrtRTEI, true);
  abscfssq_outdatedOnGpu = false;
  acoef = cpu_abscfssq->size[0] * cpu_abscfssq->size[1];
  nx = scales->size[1];
  u1 = a->size[0];
  if (nx <= u1) {
    u1 = nx;
  }
  if (scales->size[1] == 1) {
    cpu_abscfssq->size[0] = a->size[0];
  } else if (a->size[0] == 1) {
    cpu_abscfssq->size[0] = scales->size[1];
  } else if (a->size[0] == scales->size[1]) {
    cpu_abscfssq->size[0] = a->size[0];
  } else {
    cpu_abscfssq->size[0] = u1;
  }
  cpu_abscfssq->size[1] = a->size[1];
  emxEnsureCapacity_real_T(cpu_abscfssq, acoef, &h_emlrtRTEI);
  nx = scales->size[1];
  u1 = a->size[0];
  if (nx <= u1) {
    u1 = nx;
  }
  if (scales->size[1] == 1) {
    u1 = a->size[0];
  } else if (a->size[0] == 1) {
    u1 = scales->size[1];
  } else if (a->size[0] == scales->size[1]) {
    u1 = a->size[0];
  }
  if ((u1 != 0) && (a->size[1] != 0)) {
    int32_T bcoef;
    nx = (a->size[1] != 1);
    u1 = a->size[1] - 1;
    acoef = (a->size[0] != 1);
    bcoef = (scales->size[1] != 1);
    for (int32_T k{0}; k <= u1; k++) {
      int32_T i1;
      int32_T varargin_2;
      varargin_2 = nx * k;
      i1 = cpu_abscfssq->size[0] - 1;
      for (int32_T b_k{0}; b_k <= i1; b_k++) {
        cpu_abscfssq->data[b_k + cpu_abscfssq->size[0] * k] =
            a->data[acoef * b_k + a->size[0] * varargin_2] /
            scales->data[bcoef * b_k];
        abscfssq_outdatedOnGpu = true;
      }
    }
  }
  emxFree_real_T(&a);
  emxInit_uint32_T(&b_y, 2, &sf_emlrtRTEI, true);
  if (cpu_abscfssq->size[1] < 1) {
    b_y->size[0] = 1;
    b_y->size[1] = 0;
  } else {
    uint32_T u;
    u = static_cast<uint32_T>(cpu_abscfssq->size[1]);
    acoef = b_y->size[0] * b_y->size[1];
    b_y->size[0] = 1;
    b_y->size[1] = cpu_abscfssq->size[1];
    emxEnsureCapacity_uint32_T(b_y, acoef, &eb_emlrtRTEI);
    for (acoef = 0; acoef < static_cast<int32_T>(u); acoef++) {
      b_y->data[acoef] = static_cast<uint32_T>(acoef) + 1U;
    }
  }
  emxInit_real_T(&cpu_z, 1, &tf_emlrtRTEI, true);
  z_outdatedOnGpu = false;
  acoef = cpu_z->size[0];
  cpu_z->size[0] = cpu_abscfssq->size[0];
  emxEnsureCapacity_real_T(cpu_z, acoef, &of_emlrtRTEI);
  z_needsGpuEnsureCapacity = true;
  for (acoef = 0; acoef < cpu_abscfssq->size[0]; acoef++) {
    cpu_z->data[acoef] = 0.0;
    z_outdatedOnGpu = true;
  }
  if (cpu_abscfssq->size[1] > 1) {
    emxInit_real_T(&cpu_c, 1, &r_emlrtRTEI, true);
    if (b_y->size[1] == 1) {
      nx = cpu_abscfssq->size[1];
      acoef = cpu_c->size[0];
      cpu_c->size[0] = cpu_abscfssq->size[1];
      emxEnsureCapacity_real_T(cpu_c, acoef, &r_emlrtRTEI);
      for (acoef = 0; acoef < nx; acoef++) {
        cpu_c->data[acoef] = b_y->data[0];
      }
      c1 = 0.5 * static_cast<real_T>(b_y->data[0]);
      cpu_c->data[0] = c1;
      cpu_c->data[cpu_abscfssq->size[1] - 1] = c1;
    } else {
      acoef = cpu_c->size[0];
      cpu_c->size[0] = cpu_abscfssq->size[1];
      emxEnsureCapacity_real_T(cpu_c, acoef, &q_emlrtRTEI);
      cpu_c->data[0] =
          0.5 * static_cast<real_T>(static_cast<int32_T>(b_y->data[1]) -
                                    static_cast<int32_T>(b_y->data[0]));
      nx = cpu_abscfssq->size[1];
      for (int32_T k{0}; k <= nx - 3; k++) {
        cpu_c->data[k + 1] =
            0.5 * static_cast<real_T>(static_cast<int32_T>(b_y->data[k + 2]) -
                                      static_cast<int32_T>(b_y->data[k]));
      }
      cpu_c->data[cpu_abscfssq->size[1] - 1] =
          0.5 * static_cast<real_T>(
                    static_cast<int32_T>(b_y->data[cpu_abscfssq->size[1] - 1]) -
                    static_cast<int32_T>(b_y->data[cpu_abscfssq->size[1] - 2]));
    }
    if (cpu_abscfssq->size[0] >= 1) {
      c1 = 0.0;
      alpha1 = 1.0;
      gpuEmxEnsureCapacity_real_T(cpu_abscfssq, &gpu_abscfssq,
                                  !abscfssq_outdatedOnGpu);
      gpuEmxEnsureCapacity_real_T(cpu_c, &gpu_c, false);
      gpuEmxEnsureCapacity_real_T(cpu_z, &gpu_z, !z_outdatedOnGpu);
      z_needsGpuEnsureCapacity = false;
      if (abscfssq_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_abscfssq, cpu_abscfssq);
      }
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_c, cpu_c);
      if (z_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real_T(&gpu_z, cpu_z);
      }
      cublasCheck(cublasDgemv(getCublasGlobalHandle(), CUBLAS_OP_N,
                              cpu_abscfssq->size[0], cpu_abscfssq->size[1],
                              (double *)&alpha1,
                              (double *)&gpu_abscfssq.data[0],
                              cpu_abscfssq->size[0], (double *)&gpu_c.data[0],
                              1, (double *)&c1, (double *)&gpu_z.data[0], 1),
                  __FILE__, __LINE__);
      z_outdatedOnGpu = false;
    }
    emxFree_real_T(&cpu_c);
  }
  emxFree_uint32_T(&b_y);
  b_cpu_z = 0.0;
  abscfssq_outdatedOnGpu = false;
  if (cpu_z->size[0] <= 1) {
    if ((scales->size[1] == 1) &&
        (std::isinf(scales->data[0]) || std::isnan(scales->data[0]))) {
      b_cpu_z = rtNaN;
    }
  } else {
    emxInit_real_T(&b_cpu_c, 1, &r_emlrtRTEI, true);
    if (scales->size[1] == 1) {
      nx = cpu_z->size[0];
      acoef = b_cpu_c->size[0];
      b_cpu_c->size[0] = cpu_z->size[0];
      emxEnsureCapacity_real_T(b_cpu_c, acoef, &r_emlrtRTEI);
      for (acoef = 0; acoef < nx; acoef++) {
        b_cpu_c->data[acoef] = scales->data[0];
      }
      c1 = 0.5 * scales->data[0];
      b_cpu_c->data[0] = c1;
      b_cpu_c->data[cpu_z->size[0] - 1] = c1;
    } else {
      acoef = b_cpu_c->size[0];
      b_cpu_c->size[0] = cpu_z->size[0];
      emxEnsureCapacity_real_T(b_cpu_c, acoef, &q_emlrtRTEI);
      b_cpu_c->data[0] = 0.5 * (scales->data[1] - scales->data[0]);
      nx = cpu_z->size[0];
      for (int32_T k{0}; k <= nx - 3; k++) {
        b_cpu_c->data[k + 1] = 0.5 * (scales->data[k + 2] - scales->data[k]);
      }
      b_cpu_c->data[cpu_z->size[0] - 1] =
          0.5 *
          (scales->data[cpu_z->size[0] - 1] - scales->data[cpu_z->size[0] - 2]);
    }
    c1 = 0.0;
    alpha1 = 1.0;
    if (z_needsGpuEnsureCapacity) {
      gpuEmxEnsureCapacity_real_T(cpu_z, &gpu_z, !z_outdatedOnGpu);
    }
    gpuEmxEnsureCapacity_real_T(b_cpu_c, &b_gpu_c, false);
    if (z_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_z, cpu_z);
    }
    gpuEmxMemcpyCpuToGpu_real_T(&b_gpu_c, b_cpu_c);
    checkCudaError(cudaMemcpy(b_gpu_z, &b_cpu_z, 8UL, cudaMemcpyHostToDevice),
                   __FILE__, __LINE__);
    cublasCheck(cublasDgemv(getCublasGlobalHandle(), CUBLAS_OP_T,
                            cpu_z->size[0], 1, (double *)&alpha1,
                            (double *)&gpu_z.data[0], cpu_z->size[0],
                            (double *)&b_gpu_c.data[0], 1, (double *)&c1,
                            (double *)b_gpu_z, 1),
                __FILE__, __LINE__);
    abscfssq_outdatedOnGpu = true;
    emxFree_real_T(&b_cpu_c);
  }
  emxFree_real_T(&cpu_z);
  if (!(normfac == 0.0)) {
    if (abscfssq_outdatedOnGpu) {
      checkCudaError(cudaMemcpy(&b_cpu_z, b_gpu_z, 8UL, cudaMemcpyDeviceToHost),
                     __FILE__, __LINE__);
    }
    c1 = std::sqrt(
        normfac /
        (2.0 / cpsi / static_cast<real_T>(cpu_abscfssq->size[1]) * b_cpu_z));
    for (acoef = 0; acoef < cfs->size[1]; acoef++) {
      for (nx = 0; nx < cfs->size[0]; nx++) {
        cfs->data[nx + cfs->size[0] * acoef].re *= c1;
        cfs->data[nx + cfs->size[0] * acoef].im *= c1;
      }
    }
  }
  emxFree_real_T(&cpu_abscfssq);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  gpuEmxFree_real_T(&gpu_abscfssq);
  gpuEmxFree_real_T(&gpu_z);
  gpuEmxFree_real_T(&gpu_c);
  checkCudaError(mwCudaFree(b_gpu_z), __FILE__, __LINE__);
  gpuEmxFree_real_T(&b_gpu_c);
}

} // namespace cwt
} // namespace internal
} // namespace wavelet
} // namespace coder

// End of code generation (scNormalize.cu)
