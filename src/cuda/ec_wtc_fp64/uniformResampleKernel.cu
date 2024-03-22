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
#include "ec_wtc_fp_data.h"
#include "ec_wtc_fp_emxutil.h"
#include "ec_wtc_fp_mexutil.h"
#include "ec_wtc_fp_types.h"
#include "rt_nonfinite.h"
#include "upfirdn.h"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"
#include <cmath>

// Variable Definitions
static emlrtRTEInfo yg_emlrtRTEI{
    59,                      // lineNo
    9,                       // colNo
    "uniformResampleKernel", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/uniformResampleKernel.m" // pName
};

static emlrtRTEInfo ah_emlrtRTEI{
    17,                        // lineNo
    5,                         // colNo
    "uniformScalarVectorCore", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/uniformScalarVectorCore.m" // pName
};

static emlrtRTEInfo bh_emlrtRTEI{
    23,                        // lineNo
    5,                         // colNo
    "uniformScalarVectorCore", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/uniformScalarVectorCore.m" // pName
};

static emlrtRTEInfo ch_emlrtRTEI{
    55,                      // lineNo
    9,                       // colNo
    "uniformResampleKernel", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/uniformResampleKernel.m" // pName
};

static emlrtRTEInfo dh_emlrtRTEI{
    13,                  // lineNo
    1,                   // colNo
    "uniformMatrixCore", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/uniformMatrixCore.m" // pName
};

static emlrtRTEInfo eh_emlrtRTEI{
    14,                  // lineNo
    15,                  // colNo
    "uniformMatrixCore", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/uniformMatrixCore.m" // pName
};

static emlrtRTEInfo fh_emlrtRTEI{
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
void b_uniformResampleAlongFirstDim(
    emxArray_creal_T *cpu_xIn, boolean_T *xIn_outdatedOnCpu,
    emxArray_creal_T *gpu_xIn, boolean_T *xIn_outdatedOnGpu, real_T opts_p,
    real_T opts_q, emxArray_real_T *cpu_opts_filterWithPadding,
    boolean_T *c_opts_filterWithPadding_outdat,
    emxArray_real_T *gpu_opts_filterWithPadding,
    boolean_T *d_opts_filterWithPadding_outdat, real_T opts_filterDelay)
{
  emxArray_creal_T gpu_yOut;
  emxArray_creal_T gpu_yRow;
  emxArray_creal_T *cpu_yOut;
  emxArray_creal_T *cpu_yRow;
  emxArray_creal_T *yRow;
  emxArray_real_T *b_y;
  emxArray_real_T *y;
  boolean_T yRow_outdatedOnCpu;
  boolean_T yRow_outdatedOnGpu;
  nvtxRangePushA("#fcn#b_uniformResampleAlongFirstDim#" MW_AT_LOCATION);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&gpu_yRow);
  nvtxMarkA("#gpuEmxReset_creal_T#" MW_AT_LINE);
  gpuEmxReset_creal_T(&gpu_yOut);
  yRow_outdatedOnCpu = false;
  yRow_outdatedOnGpu = false;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&cpu_yOut, 2, &dh_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&y, 2, &eh_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&cpu_yRow, 2, &fh_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&b_y, 2, &eb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_creal_T#" MW_AT_LINE);
  emxInit_creal_T(&yRow, 1, &bh_emlrtRTEI, true);
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
        nvtxMarkA("#b_upfirdn#" MW_AT_LINE);
        b_upfirdn(cpu_xIn, gpu_xIn, xIn_outdatedOnGpu,
                  cpu_opts_filterWithPadding, c_opts_filterWithPadding_outdat,
                  gpu_opts_filterWithPadding, d_opts_filterWithPadding_outdat,
                  opts_p, opts_q, cpu_yRow, &yRow_outdatedOnCpu, &gpu_yRow,
                  &yRow_outdatedOnGpu);
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
        nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
        emxEnsureCapacity_creal_T(cpu_yRow, b_i, &ah_emlrtRTEI);
      } else {
        nvtxMarkA("#b_upfirdn#" MW_AT_LINE);
        b_upfirdn(cpu_xIn, gpu_xIn, xIn_outdatedOnGpu,
                  cpu_opts_filterWithPadding, c_opts_filterWithPadding_outdat,
                  gpu_opts_filterWithPadding, d_opts_filterWithPadding_outdat,
                  opts_p, opts_q, cpu_yRow, &yRow_outdatedOnCpu, &gpu_yRow,
                  &yRow_outdatedOnGpu);
      }
      if (std::isnan(b)) {
        b_i = b_y->size[0] * b_y->size[1];
        b_y->size[0] = 1;
        b_y->size[1] = 1;
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(b_y, b_i, &n_emlrtRTEI);
        b_y->data[0] = rtNaN;
      } else if (b < 1.0) {
        b_y->size[0] = 1;
        b_y->size[1] = 0;
      } else {
        b_i = b_y->size[0] * b_y->size[1];
        b_y->size[0] = 1;
        b_y->size[1] = static_cast<int32_T>(b - 1.0) + 1;
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(b_y, b_i, &n_emlrtRTEI);
        profileLoopStart("b_uniformResampleAlongFirstDim_loop_2", __LINE__,
                         static_cast<int32_T>(b - 1.0) + 1, "");
        for (b_i = 0; b_i <= static_cast<int32_T>(b - 1.0); b_i++) {
          b_y->data[b_i] = static_cast<real_T>(b_i) + 1.0;
        }
        profileLoopEnd();
      }
      i = static_cast<int32_T>(b);
      b_i = yRow->size[0];
      yRow->size[0] = static_cast<int32_T>(b);
      nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
      emxEnsureCapacity_creal_T(yRow, b_i, &bh_emlrtRTEI);
      profileLoopStart("b_uniformResampleAlongFirstDim_loop_4", __LINE__,
                       (i - 1) + 1, "");
      for (b_i = 0; b_i < i; b_i++) {
        if (yRow_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_creal_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_creal_T(cpu_yRow, &gpu_yRow);
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
      nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
      emxEnsureCapacity_creal_T(cpu_xIn, b_i, &ch_emlrtRTEI);
      profileLoopStart("b_uniformResampleAlongFirstDim_loop_5", __LINE__,
                       (i - 1) + 1, "");
      for (u1 = 0; u1 < i; u1++) {
        if (*xIn_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_creal_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_creal_T(cpu_xIn, gpu_xIn);
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
      nvtxMarkA("#b_upfirdn#" MW_AT_LINE);
      b_upfirdn(cpu_xIn, gpu_xIn, xIn_outdatedOnGpu, cpu_opts_filterWithPadding,
                c_opts_filterWithPadding_outdat, gpu_opts_filterWithPadding,
                d_opts_filterWithPadding_outdat, opts_p, opts_q, cpu_yOut,
                &yRow_outdatedOnCpu, &gpu_yOut, &yRow_outdatedOnGpu);
      if (std::isnan(b)) {
        b_i = y->size[0] * y->size[1];
        y->size[0] = 1;
        y->size[1] = 1;
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(y, b_i, &n_emlrtRTEI);
        y->data[0] = rtNaN;
      } else if (b < 1.0) {
        y->size[0] = 1;
        y->size[1] = 0;
      } else {
        b_i = y->size[0] * y->size[1];
        y->size[0] = 1;
        y->size[1] = static_cast<int32_T>(b - 1.0) + 1;
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(y, b_i, &n_emlrtRTEI);
        profileLoopStart("b_uniformResampleAlongFirstDim_loop_0", __LINE__,
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
      nvtxMarkA("#emxEnsureCapacity_creal_T#" MW_AT_LINE);
      emxEnsureCapacity_creal_T(cpu_xIn, b_i, &yg_emlrtRTEI);
      profileLoopStart("b_uniformResampleAlongFirstDim_loop_1", __LINE__,
                       (i - 1) + 1, "");
      for (b_i = 0; b_i < i; b_i++) {
        profileLoopStart("b_uniformResampleAlongFirstDim_loop_3", __LINE__,
                         (y->size[1] - 1) + 1, "");
        for (int32_T u1{0}; u1 < y->size[1]; u1++) {
          if (*xIn_outdatedOnCpu) {
            nvtxMarkA("#gpuEmxMemcpyGpuToCpu_creal_T#" MW_AT_LINE);
            gpuEmxMemcpyGpuToCpu_creal_T(cpu_xIn, gpu_xIn);
          }
          if (yRow_outdatedOnCpu) {
            nvtxMarkA("#gpuEmxMemcpyGpuToCpu_creal_T#" MW_AT_LINE);
            gpuEmxMemcpyGpuToCpu_creal_T(cpu_yOut, &gpu_yOut);
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
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&yRow);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&b_y);
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&cpu_yRow);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&y);
  nvtxMarkA("#emxFree_creal_T#" MW_AT_LINE);
  emxFree_creal_T(&cpu_yOut);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&gpu_yOut);
  nvtxMarkA("#gpuEmxFree_creal_T#" MW_AT_LINE);
  gpuEmxFree_creal_T(&gpu_yRow);
  nvtxRangePop();
}

//
//
void uniformResampleAlongFirstDim(
    emxArray_real_T *cpu_xIn, boolean_T *xIn_outdatedOnCpu,
    emxArray_real_T *gpu_xIn, boolean_T *xIn_outdatedOnGpu, real_T opts_p,
    real_T opts_q, emxArray_real_T *cpu_opts_filterWithPadding,
    boolean_T *c_opts_filterWithPadding_outdat,
    emxArray_real_T *gpu_opts_filterWithPadding,
    boolean_T *d_opts_filterWithPadding_outdat, real_T opts_filterDelay)
{
  emxArray_real_T gpu_yOut;
  emxArray_real_T gpu_yRow;
  emxArray_real_T *b_y;
  emxArray_real_T *cpu_yOut;
  emxArray_real_T *cpu_yRow;
  emxArray_real_T *y;
  emxArray_real_T *yRow;
  boolean_T yRow_outdatedOnCpu;
  boolean_T yRow_outdatedOnGpu;
  nvtxRangePushA("#fcn#uniformResampleAlongFirstDim#" MW_AT_LOCATION);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_yRow);
  nvtxMarkA("#gpuEmxReset_real_T#" MW_AT_LINE);
  gpuEmxReset_real_T(&gpu_yOut);
  yRow_outdatedOnCpu = false;
  yRow_outdatedOnGpu = false;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_yOut, 2, &dh_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&y, 2, &eh_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&cpu_yRow, 2, &fh_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&b_y, 2, &eb_emlrtRTEI, true);
  nvtxMarkA("#emxInit_real_T#" MW_AT_LINE);
  emxInit_real_T(&yRow, 1, &bh_emlrtRTEI, true);
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
        upfirdn(cpu_xIn, gpu_xIn, xIn_outdatedOnGpu, cpu_opts_filterWithPadding,
                c_opts_filterWithPadding_outdat, gpu_opts_filterWithPadding,
                d_opts_filterWithPadding_outdat, opts_p, opts_q, cpu_yRow,
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
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(cpu_yRow, b_i, &ah_emlrtRTEI);
      } else {
        nvtxMarkA("#upfirdn#" MW_AT_LINE);
        upfirdn(cpu_xIn, gpu_xIn, xIn_outdatedOnGpu, cpu_opts_filterWithPadding,
                c_opts_filterWithPadding_outdat, gpu_opts_filterWithPadding,
                d_opts_filterWithPadding_outdat, opts_p, opts_q, cpu_yRow,
                &yRow_outdatedOnCpu, &gpu_yRow, &yRow_outdatedOnGpu);
      }
      if (std::isnan(b)) {
        b_i = b_y->size[0] * b_y->size[1];
        b_y->size[0] = 1;
        b_y->size[1] = 1;
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(b_y, b_i, &n_emlrtRTEI);
        b_y->data[0] = rtNaN;
      } else if (b < 1.0) {
        b_y->size[0] = 1;
        b_y->size[1] = 0;
      } else {
        b_i = b_y->size[0] * b_y->size[1];
        b_y->size[0] = 1;
        b_y->size[1] = static_cast<int32_T>(b - 1.0) + 1;
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(b_y, b_i, &n_emlrtRTEI);
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
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(yRow, b_i, &bh_emlrtRTEI);
      profileLoopStart("uniformResampleAlongFirstDim_loop_4", __LINE__,
                       (i - 1) + 1, "");
      for (b_i = 0; b_i < i; b_i++) {
        if (yRow_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_real_T(cpu_yRow, &gpu_yRow);
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
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(cpu_xIn, b_i, &ch_emlrtRTEI);
      profileLoopStart("uniformResampleAlongFirstDim_loop_5", __LINE__,
                       (i - 1) + 1, "");
      for (u1 = 0; u1 < i; u1++) {
        if (*xIn_outdatedOnCpu) {
          nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
          gpuEmxMemcpyGpuToCpu_real_T(cpu_xIn, gpu_xIn);
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
      upfirdn(cpu_xIn, gpu_xIn, xIn_outdatedOnGpu, cpu_opts_filterWithPadding,
              c_opts_filterWithPadding_outdat, gpu_opts_filterWithPadding,
              d_opts_filterWithPadding_outdat, opts_p, opts_q, cpu_yOut,
              &yRow_outdatedOnCpu, &gpu_yOut, &yRow_outdatedOnGpu);
      if (std::isnan(b)) {
        b_i = y->size[0] * y->size[1];
        y->size[0] = 1;
        y->size[1] = 1;
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(y, b_i, &n_emlrtRTEI);
        y->data[0] = rtNaN;
      } else if (b < 1.0) {
        y->size[0] = 1;
        y->size[1] = 0;
      } else {
        b_i = y->size[0] * y->size[1];
        y->size[0] = 1;
        y->size[1] = static_cast<int32_T>(b - 1.0) + 1;
        nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
        emxEnsureCapacity_real_T(y, b_i, &n_emlrtRTEI);
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
      nvtxMarkA("#emxEnsureCapacity_real_T#" MW_AT_LINE);
      emxEnsureCapacity_real_T(cpu_xIn, b_i, &yg_emlrtRTEI);
      profileLoopStart("uniformResampleAlongFirstDim_loop_1", __LINE__,
                       (i - 1) + 1, "");
      for (b_i = 0; b_i < i; b_i++) {
        profileLoopStart("uniformResampleAlongFirstDim_loop_3", __LINE__,
                         (y->size[1] - 1) + 1, "");
        for (int32_T u1{0}; u1 < y->size[1]; u1++) {
          if (*xIn_outdatedOnCpu) {
            nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
            gpuEmxMemcpyGpuToCpu_real_T(cpu_xIn, gpu_xIn);
          }
          if (yRow_outdatedOnCpu) {
            nvtxMarkA("#gpuEmxMemcpyGpuToCpu_real_T#" MW_AT_LINE);
            gpuEmxMemcpyGpuToCpu_real_T(cpu_yOut, &gpu_yOut);
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
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&yRow);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&b_y);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_yRow);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&y);
  nvtxMarkA("#emxFree_real_T#" MW_AT_LINE);
  emxFree_real_T(&cpu_yOut);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_yOut);
  nvtxMarkA("#gpuEmxFree_real_T#" MW_AT_LINE);
  gpuEmxFree_real_T(&gpu_yRow);
  nvtxRangePop();
}

} // namespace resample
} // namespace internal
} // namespace b_signal
} // namespace coder

// End of code generation (uniformResampleKernel.cu)
