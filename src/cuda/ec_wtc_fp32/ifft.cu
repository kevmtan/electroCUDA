//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ifft.cu
//
// Code generation for function 'ifft'
//

// Include files
#include "ifft.h"
#include "ec_wtc_fp_data.h"
#include "ec_wtc_fp_emxutil.h"
#include "ec_wtc_fp_mexutil.h"
#include "ec_wtc_fp_types.h"
#include "rt_nonfinite.h"
#include "MWCUFFTPlanManager.hpp"
#include "MWLocationStringifyNvtx3.h"
#include "cufft.h"
#include "nvtx3/nvToolsExt.h"
#include <cstring>

// Variable Definitions
static emlrtRTEInfo wd_emlrtRTEI{
    83,                                                              // lineNo
    1,                                                               // colNo
    "ifft",                                                          // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/ifft.m" // pName
};

// Function Definitions
//
//
namespace coder {
void ifft(const emxArray_creal32_T *x, emxArray_creal32_T *y)
{
  emxArray_creal32_T gpu_x;
  emxArray_creal32_T *cpu_x;
  nvtxRangePushA("#fcn#ifft#" MW_AT_LOCATION);
  nvtxMarkA("#gpuEmxReset_creal32_T#" MW_AT_LINE);
  gpuEmxReset_creal32_T(&gpu_x);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  if ((x->size[0] == 0) || (x->size[1] == 0)) {
    int32_T inembed;
    uint32_T ySize_idx_0;
    uint32_T ySize_idx_1;
    ySize_idx_0 = static_cast<uint32_T>(x->size[0]);
    ySize_idx_1 = static_cast<uint32_T>(x->size[1]);
    inembed = y->size[0] * y->size[1];
    y->size[0] = x->size[0];
    y->size[1] = x->size[1];
    nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
    emxEnsureCapacity_creal32_T(y, inembed, &wd_emlrtRTEI);
    if (static_cast<int32_T>(ySize_idx_0) * static_cast<int32_T>(ySize_idx_1) -
            1 >=
        0) {
      std::memset(&y->data[0], 0,
                  static_cast<uint32_T>(static_cast<int32_T>(ySize_idx_0) *
                                        static_cast<int32_T>(ySize_idx_1)) *
                      sizeof(creal32_T));
    }
  } else {
    cufftHandle fftPlanHandle;
    int32_T inembed;
    real32_T x_re;
    boolean_T x_outdatedOnGpu;
    nvtxMarkA("#emxInit_creal32_T#" MW_AT_LINE);
    emxInit_creal32_T(&cpu_x, 2, &vd_emlrtRTEI, true);
    x_outdatedOnGpu = false;
    inembed = cpu_x->size[0] * cpu_x->size[1];
    cpu_x->size[0] = x->size[0];
    cpu_x->size[1] = x->size[1];
    nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
    emxEnsureCapacity_creal32_T(cpu_x, inembed, &vd_emlrtRTEI);
    profileLoopStart("ifft_loop_0", __LINE__, (x->size[0] * x->size[1] - 1) + 1,
                     "");
    for (inembed = 0; inembed < x->size[0] * x->size[1]; inembed++) {
      cpu_x->data[inembed] = x->data[inembed];
      x_outdatedOnGpu = true;
    }
    profileLoopEnd();
    inembed = x->size[1];
    fftPlanHandle = acquireCUFFTPlan(1, &inembed, &inembed, x->size[0], 1,
                                     CUFFT_C2C, x->size[0]);
    nvtxMarkA("#gpuEmxEnsureCapacity_creal32_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal32_T(cpu_x, &gpu_x, !x_outdatedOnGpu);
    if (x_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_creal32_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_x, cpu_x);
    }
    cufftExecC2C(fftPlanHandle, (cufftComplex *)&gpu_x.data[0],
                 (cufftComplex *)&gpu_x.data[0], CUFFT_INVERSE);
    x_outdatedOnGpu = true;
    inembed = y->size[0] * y->size[1];
    y->size[0] = cpu_x->size[0];
    y->size[1] = cpu_x->size[1];
    nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
    emxEnsureCapacity_creal32_T(y, inembed, &wd_emlrtRTEI);
    x_re = static_cast<real32_T>(x->size[1]);
    profileLoopStart("ifft_loop_1", __LINE__,
                     (cpu_x->size[0] * cpu_x->size[1] - 1) + 1, "");
    for (inembed = 0; inembed < cpu_x->size[0] * cpu_x->size[1]; inembed++) {
      real32_T ai;
      real32_T ar;
      if (x_outdatedOnGpu) {
        nvtxMarkA("#gpuEmxMemcpyGpuToCpu_creal32_T#" MW_AT_LINE);
        gpuEmxMemcpyGpuToCpu_creal32_T(cpu_x, &gpu_x);
      }
      ar = cpu_x->data[inembed].re;
      x_outdatedOnGpu = false;
      ai = cpu_x->data[inembed].im;
      if (ai == 0.0F) {
        y->data[inembed].re = ar / x_re;
        y->data[inembed].im = 0.0F;
      } else if (ar == 0.0F) {
        y->data[inembed].re = 0.0F;
        y->data[inembed].im = ai / x_re;
      } else {
        y->data[inembed].re = ar / x_re;
        y->data[inembed].im = ai / x_re;
      }
    }
    profileLoopEnd();
    nvtxMarkA("#emxFree_creal32_T#" MW_AT_LINE);
    emxFree_creal32_T(&cpu_x);
  }
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#gpuEmxFree_creal32_T#" MW_AT_LINE);
  gpuEmxFree_creal32_T(&gpu_x);
  nvtxRangePop();
}

} // namespace coder

// End of code generation (ifft.cu)
