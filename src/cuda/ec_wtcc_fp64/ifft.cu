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
#include "ec_wtcc_data.h"
#include "ec_wtcc_emxutil.h"
#include "ec_wtcc_mexutil.h"
#include "ec_wtcc_types.h"
#include "rt_nonfinite.h"
#include "MWCUFFTPlanManager.hpp"
#include "cufft.h"
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
    emxInit_creal_T(&cpu_x, 2, &ud_emlrtRTEI, true);
    x_outdatedOnGpu = false;
    i = cpu_x->size[0] * cpu_x->size[1];
    cpu_x->size[0] = x->size[0];
    cpu_x->size[1] = x->size[1];
    emxEnsureCapacity_creal_T(cpu_x, i, &ud_emlrtRTEI);
    for (i = 0; i < x->size[0] * x->size[1]; i++) {
      cpu_x->data[i] = x->data[i];
      x_outdatedOnGpu = true;
    }
    inembed = x->size[1];
    fftPlanHandle = acquireCUFFTPlan(1, &inembed, &inembed, x->size[0], 1,
                                     CUFFT_Z2Z, x->size[0]);
    gpuEmxEnsureCapacity_creal_T(cpu_x, &gpu_x, !x_outdatedOnGpu);
    if (x_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_creal_T(&gpu_x, cpu_x);
    }
    cufftExecZ2Z(fftPlanHandle, (cufftDoubleComplex *)&gpu_x.data[0],
                 (cufftDoubleComplex *)&gpu_x.data[0], CUFFT_INVERSE);
    x_outdatedOnGpu = true;
    i = y->size[0] * y->size[1];
    y->size[0] = cpu_x->size[0];
    y->size[1] = cpu_x->size[1];
    emxEnsureCapacity_creal_T(y, i, &vd_emlrtRTEI);
    inembed = x->size[1];
    for (i = 0; i < cpu_x->size[0] * cpu_x->size[1]; i++) {
      real_T ai;
      real_T ar;
      if (x_outdatedOnGpu) {
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
    emxFree_creal_T(&cpu_x);
  }
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  gpuEmxFree_creal_T(&gpu_x);
}

} // namespace coder

// End of code generation (ifft.cu)
