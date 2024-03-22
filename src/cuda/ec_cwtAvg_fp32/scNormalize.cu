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
#include "MWCudaDimUtility.hpp"
#include "MWCudaMemoryFunctions.hpp"
#include <cmath>
#include <cstring>

// Variable Definitions
static emlrtRTEInfo qf_emlrtRTEI{
    12,                                                               // lineNo
    5,                                                                // colNo
    "trapz",                                                          // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/trapz.m" // pName
};

static emlrtRTEInfo rf_emlrtRTEI{
    12,            // lineNo
    12,            // colNo
    "scNormalize", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "scNormalize.m" // pName
};

static emlrtRTEInfo sf_emlrtRTEI{
    22,            // lineNo
    32,            // colNo
    "scNormalize", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "scNormalize.m" // pName
};

static emlrtRTEInfo tf_emlrtRTEI{
    12,            // lineNo
    1,             // colNo
    "scNormalize", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "scNormalize.m" // pName
};

static emlrtRTEInfo uf_emlrtRTEI{
    26,            // lineNo
    43,            // colNo
    "scNormalize", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "scNormalize.m" // pName
};

static emlrtRTEInfo vf_emlrtRTEI{
    26,            // lineNo
    37,            // colNo
    "scNormalize", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "scNormalize.m" // pName
};

// Function Declarations
static real32_T rt_hypotf_snf(real32_T u0, real32_T u1);

static __global__ void scNormalize_kernel46(const real32_T c1,
                                            emxArray_real32_T c);

static __global__ void
scNormalize_kernel47(const real32_T c1, emxArray_real32_T c, int32_T z_dim0);

// Function Definitions
static real32_T rt_hypotf_snf(real32_T u0, real32_T u1)
{
  real32_T a;
  real32_T b;
  real32_T y;
  a = std::abs(u0);
  b = std::abs(u1);
  if (a < b) {
    a /= b;
    y = b * std::sqrt(a * a + 1.0F);
  } else if (a > b) {
    b /= a;
    y = a * std::sqrt(b * b + 1.0F);
  } else if (std::isnan(b)) {
    y = rtNaNF;
  } else {
    y = a * 1.41421354F;
  }
  return y;
}

static __global__
    __launch_bounds__(32, 1) void scNormalize_kernel46(const real32_T c1,
                                                       emxArray_real32_T c)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[0] = c1;
  }
}

static __global__ __launch_bounds__(32, 1) void scNormalize_kernel47(
    const real32_T c1, emxArray_real32_T c, int32_T z_dim0)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    c.data[z_dim0 - 1] = c1;
  }
}

//
//
namespace coder {
namespace wavelet {
namespace internal {
namespace cwt {
void scNormalize(emxArray_creal32_T *cfs, real_T cpsi,
                 const emxArray_real32_T *scales, real32_T normfac)
{
  emxArray_real32_T gpu_c;
  emxArray_real32_T gpu_z;
  emxArray_real32_T *a;
  emxArray_real32_T *abscfssq;
  emxArray_real32_T *cpu_c;
  emxArray_real32_T *cpu_z;
  emxArray_real32_T *y;
  emxArray_real_T *c;
  emxArray_uint32_T *b_y;
  int32_T nx;
  int32_T u1;
  int32_T vstride;
  real32_T b_c1;
  real32_T cpu_b;
  real32_T *gpu_b;
  boolean_T b_outdatedOnCpu;
  boolean_T z_needsGpuEnsureCapacity;
  boolean_T z_outdatedOnGpu;
  gpuEmxReset_real32_T(&gpu_c);
  checkCudaError(mwCudaMalloc(&gpu_b, 4UL), __FILE__, __LINE__);
  gpuEmxReset_real32_T(&gpu_z);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  nx = cfs->size[0] * cfs->size[1];
  emxInit_real32_T(&y, 2, &rf_emlrtRTEI, true);
  vstride = y->size[0] * y->size[1];
  y->size[0] = cfs->size[0];
  y->size[1] = cfs->size[1];
  emxEnsureCapacity_real32_T(y, vstride, &n_emlrtRTEI);
  for (int32_T k{0}; k < nx; k++) {
    y->data[k] = rt_hypotf_snf(cfs->data[k].re, cfs->data[k].im);
  }
  emxInit_real32_T(&a, 2, &sf_emlrtRTEI, true);
  vstride = a->size[0] * a->size[1];
  a->size[0] = y->size[0];
  a->size[1] = y->size[1];
  emxEnsureCapacity_real32_T(a, vstride, &o_emlrtRTEI);
  nx = y->size[0] * y->size[1];
  for (int32_T k{0}; k < nx; k++) {
    a->data[k] = y->data[k] * y->data[k];
  }
  emxFree_real32_T(&y);
  emxInit_real32_T(&abscfssq, 2, &tf_emlrtRTEI, true);
  vstride = abscfssq->size[0] * abscfssq->size[1];
  nx = scales->size[1];
  u1 = a->size[0];
  if (nx <= u1) {
    u1 = nx;
  }
  if (scales->size[1] == 1) {
    abscfssq->size[0] = a->size[0];
  } else if (a->size[0] == 1) {
    abscfssq->size[0] = scales->size[1];
  } else if (a->size[0] == scales->size[1]) {
    abscfssq->size[0] = a->size[0];
  } else {
    abscfssq->size[0] = u1;
  }
  abscfssq->size[1] = a->size[1];
  emxEnsureCapacity_real32_T(abscfssq, vstride, &i_emlrtRTEI);
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
    int32_T acoef;
    int32_T bcoef;
    nx = (a->size[1] != 1);
    u1 = a->size[1] - 1;
    acoef = (a->size[0] != 1);
    bcoef = (scales->size[1] != 1);
    for (int32_T k{0}; k <= u1; k++) {
      int32_T i1;
      vstride = nx * k;
      i1 = abscfssq->size[0] - 1;
      for (int32_T b_k{0}; b_k <= i1; b_k++) {
        abscfssq->data[b_k + abscfssq->size[0] * k] =
            a->data[acoef * b_k + a->size[0] * vstride] /
            scales->data[bcoef * b_k];
      }
    }
  }
  emxFree_real32_T(&a);
  emxInit_uint32_T(&b_y, 2, &uf_emlrtRTEI, true);
  if (abscfssq->size[1] < 1) {
    b_y->size[0] = 1;
    b_y->size[1] = 0;
  } else {
    uint32_T u;
    u = static_cast<uint32_T>(abscfssq->size[1]);
    vstride = b_y->size[0] * b_y->size[1];
    b_y->size[0] = 1;
    b_y->size[1] = abscfssq->size[1];
    emxEnsureCapacity_uint32_T(b_y, vstride, &gb_emlrtRTEI);
    for (vstride = 0; vstride < static_cast<int32_T>(u); vstride++) {
      b_y->data[vstride] = static_cast<uint32_T>(vstride) + 1U;
    }
  }
  emxInit_real32_T(&cpu_z, 1, &vf_emlrtRTEI, true);
  z_outdatedOnGpu = false;
  vstride = cpu_z->size[0];
  cpu_z->size[0] = abscfssq->size[0];
  emxEnsureCapacity_real32_T(cpu_z, vstride, &qf_emlrtRTEI);
  z_needsGpuEnsureCapacity = true;
  for (vstride = 0; vstride < abscfssq->size[0]; vstride++) {
    cpu_z->data[vstride] = 0.0F;
    z_outdatedOnGpu = true;
  }
  if (abscfssq->size[1] > 1) {
    emxInit_real_T(&c, 1, &t_emlrtRTEI, true);
    if (b_y->size[1] == 1) {
      nx = abscfssq->size[1];
      vstride = c->size[0];
      c->size[0] = abscfssq->size[1];
      emxEnsureCapacity_real_T(c, vstride, &t_emlrtRTEI);
      for (vstride = 0; vstride < nx; vstride++) {
        c->data[vstride] = b_y->data[0];
      }
      real_T c1;
      c1 = 0.5 * static_cast<real_T>(b_y->data[0]);
      c->data[0] = c1;
      c->data[abscfssq->size[1] - 1] = c1;
    } else {
      vstride = c->size[0];
      c->size[0] = abscfssq->size[1];
      emxEnsureCapacity_real_T(c, vstride, &s_emlrtRTEI);
      c->data[0] =
          0.5 * static_cast<real_T>(static_cast<int32_T>(b_y->data[1]) -
                                    static_cast<int32_T>(b_y->data[0]));
      nx = abscfssq->size[1];
      for (int32_T k{0}; k <= nx - 3; k++) {
        c->data[k + 1] =
            0.5 * static_cast<real_T>(static_cast<int32_T>(b_y->data[k + 2]) -
                                      static_cast<int32_T>(b_y->data[k]));
      }
      c->data[abscfssq->size[1] - 1] =
          0.5 * static_cast<real_T>(
                    static_cast<int32_T>(b_y->data[abscfssq->size[1] - 1]) -
                    static_cast<int32_T>(b_y->data[abscfssq->size[1] - 2]));
    }
    vstride = abscfssq->size[0];
    if (abscfssq->size[0] != 0) {
      int64_T b;
      nx = abscfssq->size[0];
      std::memset(&cpu_z->data[0], 0,
                  static_cast<uint32_T>(nx) * sizeof(real32_T));
      z_outdatedOnGpu = true;
      nx = 0;
      u1 = abscfssq->size[0] * (abscfssq->size[1] - 1) + 1;
      b = computeEndIdx(1L, static_cast<int64_T>(u1),
                        static_cast<int64_T>(vstride));
      for (int64_T iac{0L}; iac <= b; iac++) {
        int64_T d;
        d = computeEndIdx(
            static_cast<int64_T>(static_cast<int32_T>(iac * vstride + 1L)),
            static_cast<int64_T>(
                (static_cast<int32_T>(iac * vstride + 1L) + vstride) - 1),
            1L);
        for (int64_T ia{0L}; ia <= d; ia++) {
          cpu_z->data[static_cast<int32_T>(ia)] +=
              abscfssq
                  ->data[static_cast<int32_T>(
                             static_cast<int32_T>(iac * vstride + 1L) + ia) -
                         1] *
              static_cast<real32_T>(c->data[nx]);
        }
        nx++;
      }
    }
    emxFree_real_T(&c);
  }
  emxFree_uint32_T(&b_y);
  cpu_b = 0.0F;
  b_outdatedOnCpu = false;
  if (cpu_z->size[0] <= 1) {
    if ((scales->size[1] == 1) &&
        (std::isinf(scales->data[0]) || std::isnan(scales->data[0]))) {
      cpu_b = rtNaNF;
    }
  } else {
    real32_T alpha1;
    boolean_T c_needsGpuEnsureCapacity;
    emxInit_real32_T(&cpu_c, 1, &t_emlrtRTEI, true);
    if (scales->size[1] == 1) {
      nx = cpu_z->size[0];
      b_outdatedOnCpu = false;
      vstride = cpu_c->size[0];
      cpu_c->size[0] = cpu_z->size[0];
      emxEnsureCapacity_real32_T(cpu_c, vstride, &t_emlrtRTEI);
      for (vstride = 0; vstride < nx; vstride++) {
        cpu_c->data[vstride] = scales->data[0];
        b_outdatedOnCpu = true;
      }
      b_c1 = 0.5F * scales->data[0];
      gpuEmxEnsureCapacity_real32_T(cpu_c, &gpu_c, !b_outdatedOnCpu);
      if (b_outdatedOnCpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_c, cpu_c);
      }
      scNormalize_kernel46<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(b_c1,
                                                                    gpu_c);
      gpuEmxEnsureCapacity_real32_T(cpu_z, &gpu_z, !z_outdatedOnGpu);
      z_needsGpuEnsureCapacity = false;
      c_needsGpuEnsureCapacity = false;
      if (z_outdatedOnGpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_z, cpu_z);
      }
      z_outdatedOnGpu = false;
      scNormalize_kernel47<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
          b_c1, gpu_c, cpu_z->size[0U]);
      b_outdatedOnCpu = false;
    } else {
      vstride = cpu_c->size[0];
      cpu_c->size[0] = cpu_z->size[0];
      emxEnsureCapacity_real32_T(cpu_c, vstride, &s_emlrtRTEI);
      cpu_c->data[0] = 0.5F * (scales->data[1] - scales->data[0]);
      nx = cpu_z->size[0];
      for (int32_T k{0}; k <= nx - 3; k++) {
        cpu_c->data[k + 1] = 0.5F * (scales->data[k + 2] - scales->data[k]);
      }
      cpu_c->data[cpu_z->size[0] - 1] =
          0.5F *
          (scales->data[cpu_z->size[0] - 1] - scales->data[cpu_z->size[0] - 2]);
      b_outdatedOnCpu = true;
      c_needsGpuEnsureCapacity = true;
    }
    b_c1 = 0.0F;
    alpha1 = 1.0F;
    if (z_needsGpuEnsureCapacity) {
      gpuEmxEnsureCapacity_real32_T(cpu_z, &gpu_z, !z_outdatedOnGpu);
    }
    if (c_needsGpuEnsureCapacity) {
      gpuEmxEnsureCapacity_real32_T(cpu_c, &gpu_c, !b_outdatedOnCpu);
    }
    if (z_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_z, cpu_z);
    }
    if (b_outdatedOnCpu) {
      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_c, cpu_c);
    }
    checkCudaError(cudaMemcpy(gpu_b, &cpu_b, 4UL, cudaMemcpyHostToDevice),
                   __FILE__, __LINE__);
    cublasCheck(cublasSgemv(getCublasGlobalHandle(), CUBLAS_OP_T,
                            cpu_z->size[0], 1, (float *)&alpha1,
                            (float *)&gpu_z.data[0], cpu_z->size[0],
                            (float *)&gpu_c.data[0], 1, (float *)&b_c1,
                            (float *)gpu_b, 1),
                __FILE__, __LINE__);
    b_outdatedOnCpu = true;
    emxFree_real32_T(&cpu_c);
  }
  emxFree_real32_T(&cpu_z);
  if (!(normfac == 0.0F)) {
    if (b_outdatedOnCpu) {
      checkCudaError(cudaMemcpy(&cpu_b, gpu_b, 4UL, cudaMemcpyDeviceToHost),
                     __FILE__, __LINE__);
    }
    b_c1 = std::sqrt(normfac /
                     (static_cast<real32_T>(
                          2.0 / cpsi / static_cast<real_T>(abscfssq->size[1])) *
                      cpu_b));
    for (vstride = 0; vstride < cfs->size[1]; vstride++) {
      for (nx = 0; nx < cfs->size[0]; nx++) {
        cfs->data[nx + cfs->size[0] * vstride].re *= b_c1;
        cfs->data[nx + cfs->size[0] * vstride].im *= b_c1;
      }
    }
  }
  emxFree_real32_T(&abscfssq);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  gpuEmxFree_real32_T(&gpu_z);
  checkCudaError(mwCudaFree(gpu_b), __FILE__, __LINE__);
  gpuEmxFree_real32_T(&gpu_c);
}

} // namespace cwt
} // namespace internal
} // namespace wavelet
} // namespace coder

// End of code generation (scNormalize.cu)
