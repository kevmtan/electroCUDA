//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// uniformResampleKernel.cu
//
// Code generation for function 'uniformResampleKernel'
//

// Include files
#include "uniformResampleKernel.h"
#include "ec_wt_fp_data.h"
#include "ec_wt_fp_emxutil.h"
#include "ec_wt_fp_mexutil.h"
#include "ec_wt_fp_types.h"
#include "rt_nonfinite.h"
#include "upfirdn.h"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"
#include <cmath>

// Variable Definitions
static emlrtRTEInfo kh_emlrtRTEI{
    59,                      // lineNo
    9,                       // colNo
    "uniformResampleKernel", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/uniformResampleKernel.m" // pName
};

static emlrtRTEInfo lh_emlrtRTEI{
    17,                        // lineNo
    5,                         // colNo
    "uniformScalarVectorCore", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/uniformScalarVectorCore.m" // pName
};

static emlrtRTEInfo mh_emlrtRTEI{
    23,                        // lineNo
    5,                         // colNo
    "uniformScalarVectorCore", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/uniformScalarVectorCore.m" // pName
};

static emlrtRTEInfo nh_emlrtRTEI{
    55,                      // lineNo
    9,                       // colNo
    "uniformResampleKernel", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/uniformResampleKernel.m" // pName
};

static emlrtRTEInfo oh_emlrtRTEI{
    13,                  // lineNo
    1,                   // colNo
    "uniformMatrixCore", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/uniformMatrixCore.m" // pName
};

static emlrtRTEInfo ph_emlrtRTEI{
    14,                  // lineNo
    15,                  // colNo
    "uniformMatrixCore", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/uniformMatrixCore.m" // pName
};

static emlrtRTEInfo qh_emlrtRTEI{
    16,                        // lineNo
    5,                         // colNo
    "uniformScalarVectorCore", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/uniformScalarVectorCore.m" // pName
};

// Function Definitions
//
//
namespace coder {
namespace b_signal {
namespace internal {
namespace resample {
void uniformResampleAlongFirstDim(
    emxArray_creal32_T *cpu_xIn, boolean_T *xIn_outdatedOnCpu,
    emxArray_creal32_T *gpu_xIn, boolean_T *xIn_outdatedOnGpu, real_T opts_p,
    real_T opts_q, const emxArray_real32_T *cpu_opts_filterWithPadding,
    real_T opts_filterDelay)
{
  emxArray_creal32_T gpu_yOut;
  emxArray_creal32_T gpu_yRow;
  emxArray_creal32_T *cpu_yOut;
  emxArray_creal32_T *cpu_yRow;
  emxArray_creal32_T *yRow;
  emxArray_real32_T gpu_opts_filterWithPadding;
  emxArray_real_T *b_y;
  emxArray_real_T *y;
  boolean_T c_opts_filterWithPadding_outdat;
  boolean_T d_opts_filterWithPadding_outdat;
  boolean_T yRow_outdatedOnCpu;
  boolean_T yRow_outdatedOnGpu;
  nvtxRangePushA("#fcn#uniformResampleAlongFirstDim#" MW_AT_LOCATION);
  nvtxMarkA("#gpuEmxReset_creal32_T#" MW_AT_LINE);
  gpuEmxReset_creal32_T(&gpu_yRow);
  nvtxMarkA("#gpuEmxReset_creal32_T#" MW_AT_LINE);
  gpuEmxReset_creal32_T(&gpu_yOut);
  nvtxMarkA("#gpuEmxReset_real32_T#" MW_AT_LINE);
  gpuEmxReset_real32_T(&gpu_opts_filterWithPadding);
  yRow_outdatedOnCpu = false;
  yRow_outdatedOnGpu = false;
  c_opts_filterWithPadding_outdat = false;
  d_opts_filterWithPadding_outdat = true;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#emxInit_creal32_T#" MW_AT_LINE);
  emxInit_creal32_T(&cpu_yOut, 2, &oh_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&y, 2, &ph_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal32_T#" MW_AT_LINE);
  emxInit_creal32_T(&cpu_yRow, 2, &qh_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&b_y, 2, &re_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal32_T#" MW_AT_LINE);
  emxInit_creal32_T(&yRow, 1, &mh_emlrtRTEI, true);
  if ((!(opts_p == 1.0)) || (!(opts_q == 1.0))) {
    if ((cpu_xIn->size[0] == 1) || (cpu_xIn->size[1] == 1)) {
      real_T b;
      int32_T b_i;
      int32_T i;
      int32_T u1;
      if ((cpu_xIn->size[0] == 0) || (cpu_xIn->size[1] == 0)) {
        u1 = 0;
      } else {
        i = cpu_xIn->size[0];
        u1 = cpu_xIn->size[1];
        if (i >= u1) {
          u1 = i;
        }
      }
      b = std::ceil(static_cast<real_T>(u1) * opts_p / opts_q);
      if ((cpu_xIn->size[0] == 1) && (cpu_xIn->size[1] == 1)) {
        nvtxMarkA("#upfirdn#" MW_AT_LINE);
        upfirdn(cpu_xIn, gpu_xIn, xIn_outdatedOnGpu,
                (emxArray_real32_T *)cpu_opts_filterWithPadding,
                &c_opts_filterWithPadding_outdat, &gpu_opts_filterWithPadding,
                &d_opts_filterWithPadding_outdat, opts_p, opts_q, cpu_yRow,
                &yRow_outdatedOnCpu, &gpu_yRow, &yRow_outdatedOnGpu);
        if ((cpu_yRow->size[0] == 0) || (cpu_yRow->size[1] == 0)) {
          u1 = 0;
        } else {
          i = cpu_yRow->size[0];
          u1 = cpu_yRow->size[1];
          if (i >= u1) {
            u1 = i;
          }
        }
        b_i = cpu_yRow->size[0] * cpu_yRow->size[1];
        cpu_yRow->size[0] = u1;
        cpu_yRow->size[1] = 1;
        nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
        emxEnsureCapacity_creal32_T(cpu_yRow, b_i, &lh_emlrtRTEI);
      } else {
        nvtxMarkA("#upfirdn#" MW_AT_LINE);
        upfirdn(cpu_xIn, gpu_xIn, xIn_outdatedOnGpu,
                (emxArray_real32_T *)cpu_opts_filterWithPadding,
                &c_opts_filterWithPadding_outdat, &gpu_opts_filterWithPadding,
                &d_opts_filterWithPadding_outdat, opts_p, opts_q, cpu_yRow,
                &yRow_outdatedOnCpu, &gpu_yRow, &yRow_outdatedOnGpu);
      }
      if (std::isnan(b)) {
        b_i = b_y->size[0] * b_y->size[1];
        b_y->size[0] = 1;
        b_y->size[1] = 1;
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(b_y, b_i, &ib_emlrtRTEI);
        b_y->data[0] = rtNaN;
      } else if (b < 1.0) {
        b_y->size[0] = 1;
        b_y->size[1] = 0;
      } else {
        b_i = b_y->size[0] * b_y->size[1];
        b_y->size[0] = 1;
        b_y->size[1] = static_cast<int32_T>(b - 1.0) + 1;
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(b_y, b_i, &ib_emlrtRTEI);
        profileLoopStart("uniformResampleAlongFirstDim_loop_2", __LINE__,
                         static_cast<int32_T>(b - 1.0) + 1, "");
        for (b_i = 0; b_i <= static_cast<int32_T>(b - 1.0); b_i++) {
          b_y->data[b_i] = static_cast<real_T>(b_i) + 1.0;
        }
        profileLoopEnd();
      }
      i = static_cast<int32_T>(b);
      b_i = yRow->size[0];
      yRow->size[0] = static_cast<int32_T>(b);
      nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
      emxEnsureCapacity_creal32_T(yRow, b_i, &mh_emlrtRTEI);
      profileLoopStart("uniformResampleAlongFirstDim_loop_4", __LINE__,
                       (i - 1) + 1, "");
      for (b_i = 0; b_i < i; b_i++) {
        if (yRow_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_creal32_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_creal32_T(cpu_yRow, &gpu_yRow);
        }
        yRow_outdatedOnCpu = false;
        yRow->data[b_i] =
            cpu_yRow
                ->data[static_cast<int32_T>(opts_filterDelay + b_y->data[b_i]) -
                       1];
      }
      profileLoopEnd();
      i = static_cast<int32_T>(b);
      b_i = cpu_xIn->size[0] * cpu_xIn->size[1];
      cpu_xIn->size[0] = static_cast<int32_T>(b);
      cpu_xIn->size[1] = 1;
      nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
      emxEnsureCapacity_creal32_T(cpu_xIn, b_i, &nh_emlrtRTEI);
      profileLoopStart("uniformResampleAlongFirstDim_loop_5", __LINE__,
                       (i - 1) + 1, "");
      for (u1 = 0; u1 < i; u1++) {
        if (*xIn_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_creal32_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_creal32_T(cpu_xIn, gpu_xIn);
        }
        cpu_xIn->data[u1] = yRow->data[u1];
        *xIn_outdatedOnCpu = false;
        *xIn_outdatedOnGpu = true;
      }
      profileLoopEnd();
    } else {
      real_T b;
      int32_T b_i;
      int32_T i;
      b = std::ceil(static_cast<real_T>(cpu_xIn->size[0]) * opts_p / opts_q);
      nvtxMarkA("#upfirdn#" MW_AT_LINE);
      upfirdn(cpu_xIn, gpu_xIn, xIn_outdatedOnGpu,
              (emxArray_real32_T *)cpu_opts_filterWithPadding,
              &c_opts_filterWithPadding_outdat, &gpu_opts_filterWithPadding,
              &d_opts_filterWithPadding_outdat, opts_p, opts_q, cpu_yOut,
              &yRow_outdatedOnCpu, &gpu_yOut, &yRow_outdatedOnGpu);
      if (std::isnan(b)) {
        b_i = y->size[0] * y->size[1];
        y->size[0] = 1;
        y->size[1] = 1;
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(y, b_i, &ib_emlrtRTEI);
        y->data[0] = rtNaN;
      } else if (b < 1.0) {
        y->size[0] = 1;
        y->size[1] = 0;
      } else {
        b_i = y->size[0] * y->size[1];
        y->size[0] = 1;
        y->size[1] = static_cast<int32_T>(b - 1.0) + 1;
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(y, b_i, &ib_emlrtRTEI);
        profileLoopStart("uniformResampleAlongFirstDim_loop_0", __LINE__,
                         static_cast<int32_T>(b - 1.0) + 1, "");
        for (b_i = 0; b_i <= static_cast<int32_T>(b - 1.0); b_i++) {
          y->data[b_i] = static_cast<real_T>(b_i) + 1.0;
        }
        profileLoopEnd();
      }
      i = cpu_yOut->size[1];
      b_i = cpu_xIn->size[0] * cpu_xIn->size[1];
      cpu_xIn->size[0] = y->size[1];
      cpu_xIn->size[1] = cpu_yOut->size[1];
      nvtxMarkA("#emxEnsureCapacity_creal32_T#" MW_AT_LINE);
      emxEnsureCapacity_creal32_T(cpu_xIn, b_i, &kh_emlrtRTEI);
      profileLoopStart("uniformResampleAlongFirstDim_loop_1", __LINE__,
                       (i - 1) + 1, "");
      for (b_i = 0; b_i < i; b_i++) {
        profileLoopStart("uniformResampleAlongFirstDim_loop_3", __LINE__,
                         (y->size[1] - 1) + 1, "");
        for (int32_T u1{0}; u1 < y->size[1]; u1++) {
          if (*xIn_outdatedOnCpu) {
            nvtxMarkA("#gpuEmxMemcpyGpuToCpu_creal32_T#" MW_AT_LINE);
            gpuEmxMemcpyGpuToCpu_creal32_T(cpu_xIn, gpu_xIn);
          }
          if (yRow_outdatedOnCpu) {
            nvtxMarkA("#gpuEmxMemcpyGpuToCpu_creal32_T#" MW_AT_LINE);
            gpuEmxMemcpyGpuToCpu_creal32_T(cpu_yOut, &gpu_yOut);
          }
          yRow_outdatedOnCpu = false;
          cpu_xIn->data[u1 + cpu_xIn->size[0] * b_i] =
              cpu_yOut
                  ->data[(static_cast<int32_T>(opts_filterDelay + y->data[u1]) +
                          cpu_yOut->size[0] * b_i) -
                         1];
          *xIn_outdatedOnCpu = false;
          *xIn_outdatedOnGpu = true;
        }
        profileLoopEnd();
      }
      profileLoopEnd();
    }
  }
  nvtxMarkA("#emxFree_creal32_T#" MW_AT_LINE);
  emxFree_creal32_T(&yRow);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&b_y);
  nvtxMarkA("#emxFree_creal32_T#" MW_AT_LINE);
  emxFree_creal32_T(&cpu_yRow);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&y);
  nvtxMarkA("#emxFree_creal32_T#" MW_AT_LINE);
  emxFree_creal32_T(&cpu_yOut);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#gpuEmxFree_real32_T#" MW_AT_LINE);
  gpuEmxFree_real32_T(&gpu_opts_filterWithPadding);
  nvtxMarkA("#gpuEmxFree_creal32_T#" MW_AT_LINE);
  gpuEmxFree_creal32_T(&gpu_yOut);
  nvtxMarkA("#gpuEmxFree_creal32_T#" MW_AT_LINE);
  gpuEmxFree_creal32_T(&gpu_yRow);
  nvtxRangePop();
}

} // namespace resample
} // namespace internal
} // namespace b_signal
} // namespace coder

// End of code generation (uniformResampleKernel.cu)
