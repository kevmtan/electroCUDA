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
static emlrtRTEInfo vd_emlrtRTEI{
    83,                                                              // lineNo
    1,                                                               // colNo
    "ifft",                                                          // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/datafun/ifft.m" // pName
};

// Function Definitions
//
//
namespace coder {
void ifft(const emxArray_creal_T *x, emxArray_creal_T *y)
{
  emxArray_creal_T gpu_x;
  emxArray_creal_T *cpu_x;
  nvtxRangePushA("#fcn#ifft#" MW_AT_LOCATION);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&gpu_x);
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  if ((x->size[0] == 0) || (x->size[1] == 0)) {
    int32_T i;
    uint32_T ySize_idx_0;
    uint32_T ySize_idx_1;
    ySize_idx_0 = static_cast<uint32_T>(x->size[0]);
    ySize_idx_1 = static_cast<uint32_T>(x->size[1]);
    i = y->size[0] * y->size[1];
    y->size[0] = x->size[0];
    y->size[1] = x->size[1];
    nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
    emxEnsureCapacity_creal_T(y, i, &vd_emlrtRTEI);
    if (static_cast<int32_T>(ySize_idx_0) * static_cast<int32_T>(ySize_idx_1) -
            1 >=
        0) {
      std::memset(&y->data[0], 0,
                  static_cast<uint32_T>(static_cast<int32_T>(ySize_idx_0) *
                                        static_cast<int32_T>(ySize_idx_1)) *
                      sizeof(creal_T));
    }
  } else {
    cufftHandle fftPlanHandle;
    int32_T i;
    int32_T inembed;
    boolean_T x_outdatedOnGpu;
    nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
    emxInit_creal_T(&cpu_x, 2, &ud_emlrtRTEI, true);
    x_outdatedOnGpu = false;
    i = cpu_x->size[0] * cpu_x->size[1];
    cpu_x->size[0] = x->size[0];
    cpu_x->size[1] = x->size[1];
    nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
    emxEnsureCapacity_creal_T(cpu_x, i, &ud_emlrtRTEI);
    profileLoopStart("ifft_loop_0", __LINE__, (x->size[0] * x->size[1] - 1) + 1,
                     "");
    for (i = 0; i < x->size[0] * x->size[1]; i++) {
      cpu_x->data[i] = x->data[i];
      x_outdatedOnGpu = true;
    }
    profileLoopEnd();
    inembed = x->size[1];
    fftPlanHandle = acquireCUFFTPlan(1, &inembed, &inembed, x->size[0], 1,
                                     CUFFT_Z2Z, x->size[0]);
    nvtxMarkA("#gpuEmxEnsureCapacity_creal_T#" MW_AT_LINE);
    gpuEmxEnsureCapacity_creal_T(cpu_x, &gpu_x, !x_outdatedOnGpu);
    if (x_outdatedOnGpu) {
      nvtxMarkA("#gpuEmxMemcpyCpuToGpu_creal_T#" MW_AT_LINE);
      gpuEmxMemcpyCpuToGpu_creal_T(&gpu_x, cpu_x);
    }
    cufftExecZ2Z(fftPlanHandle, (cufftDoubleComplex *)&gpu_x.data[0],
                 (cufftDoubleComplex *)&gpu_x.data[0], CUFFT_INVERSE);
    x_outdatedOnGpu = true;
    i = y->size[0] * y->size[1];
    y->size[0] = cpu_x->size[0];
    y->size[1] = cpu_x->size[1];
    nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
    emxEnsureCapacity_creal_T(y, i, &vd_emlrtRTEI);
    inembed = x->size[1];
    profileLoopStart("ifft_loop_1", __LINE__,
                     (cpu_x->size[0] * cpu_x->size[1] - 1) + 1, "");
    for (i = 0; i < cpu_x->size[0] * cpu_x->size[1]; i++) {
      real_T ai;
      real_T ar;
      if (x_outdatedOnGpu) {
        nvtxMarkA("#gpuEmxMemcpyGpuToCpu_creal_T#" MW_AT_LINE);
        gpuEmxMemcpyGpuToCpu_creal_T(cpu_x, &gpu_x);
      }
      ar = cpu_x->data[i].re;
      x_outdatedOnGpu = false;
      ai = cpu_x->data[i].im;
      if (ai == 0.0) {
        y->data[i].re = ar / static_cast<real_T>(inembed);
        y->data[i].im = 0.0;
      } else if (ar == 0.0) {
        y->data[i].re = 0.0;
        y->data[i].im = ai / static_cast<real_T>(inembed);
      } else {
        y->data[i].re = ar / static_cast<real_T>(inembed);
        y->data[i].im = ai / static_cast<real_T>(inembed);
      }
    }
    profileLoopEnd();
    nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
    emxFree_creal_T(&cpu_x);
  }
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&gpu_x);
  nvtxRangePop();
}

} // namespace coder

// End of code generation (ifft.cu)
