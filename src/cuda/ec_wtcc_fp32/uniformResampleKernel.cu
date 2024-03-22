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
#include "ec_wtcc_data.h"
#include "ec_wtcc_emxutil.h"
#include "ec_wtcc_mexutil.h"
#include "ec_wtcc_types.h"
#include "rt_nonfinite.h"
#include "upfirdn.h"
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
    emxArray_creal32_T *cpu_xIn, boolean_T *xIn_outdatedOnCpu,
    emxArray_creal32_T *gpu_xIn, boolean_T *xIn_outdatedOnGpu, real_T opts_p,
    real_T opts_q, emxArray_real32_T *cpu_opts_filterWithPadding,
    boolean_T *c_opts_filterWithPadding_outdat,
    emxArray_real32_T *gpu_opts_filterWithPadding,
    boolean_T *d_opts_filterWithPadding_outdat, real_T opts_filterDelay)
{
  emxArray_creal32_T gpu_yOut;
  emxArray_creal32_T gpu_yRow;
  emxArray_creal32_T *cpu_yOut;
  emxArray_creal32_T *cpu_yRow;
  emxArray_creal32_T *yRow;
  emxArray_real_T *b_y;
  emxArray_real_T *y;
  boolean_T yRow_outdatedOnCpu;
  boolean_T yRow_outdatedOnGpu;
  gpuEmxReset_creal32_T(&gpu_yRow);
  gpuEmxReset_creal32_T(&gpu_yOut);
  yRow_outdatedOnCpu = false;
  yRow_outdatedOnGpu = false;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_creal32_T(&cpu_yOut, 2, &dh_emlrtRTEI, true);
  emxInit_real_T(&y, 2, &eh_emlrtRTEI, true);
  emxInit_creal32_T(&cpu_yRow, 2, &fh_emlrtRTEI, true);
  emxInit_real_T(&b_y, 2, &eb_emlrtRTEI, true);
  emxInit_creal32_T(&yRow, 1, &bh_emlrtRTEI, true);
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
        emxEnsureCapacity_creal32_T(cpu_yRow, b_i, &ah_emlrtRTEI);
      } else {
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
        emxEnsureCapacity_real_T(b_y, b_i, &n_emlrtRTEI);
        b_y->data[0] = rtNaN;
      } else if (b < 1.0) {
        b_y->size[0] = 1;
        b_y->size[1] = 0;
      } else {
        b_i = b_y->size[0] * b_y->size[1];
        b_y->size[0] = 1;
        b_y->size[1] = static_cast<int32_T>(b - 1.0) + 1;
        emxEnsureCapacity_real_T(b_y, b_i, &n_emlrtRTEI);
        for (b_i = 0; b_i <= static_cast<int32_T>(b - 1.0); b_i++) {
          b_y->data[b_i] = static_cast<real_T>(b_i) + 1.0;
        }
      }
      i = static_cast<int32_T>(b);
      b_i = yRow->size[0];
      yRow->size[0] = static_cast<int32_T>(b);
      emxEnsureCapacity_creal32_T(yRow, b_i, &bh_emlrtRTEI);
      for (b_i = 0; b_i < i; b_i++) {
        if (yRow_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_creal32_T(cpu_yRow, &gpu_yRow);
        }
        yRow_outdatedOnCpu = false;
        yRow->data[b_i] =
            cpu_yRow
                ->data[static_cast<int32_T>(opts_filterDelay + b_y->data[b_i]) -
                       1];
      }
      i = static_cast<int32_T>(b);
      b_i = cpu_xIn->size[0] * cpu_xIn->size[1];
      cpu_xIn->size[0] = static_cast<int32_T>(b);
      cpu_xIn->size[1] = 1;
      emxEnsureCapacity_creal32_T(cpu_xIn, b_i, &ch_emlrtRTEI);
      for (u1 = 0; u1 < i; u1++) {
        if (*xIn_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_creal32_T(cpu_xIn, gpu_xIn);
        }
        cpu_xIn->data[u1] = yRow->data[u1];
        *xIn_outdatedOnCpu = false;
        *xIn_outdatedOnGpu = true;
      }
    } else {
      real_T b;
      int32_T b_i;
      int32_T i;
      b = std::ceil(static_cast<real_T>(cpu_xIn->size[0]) * opts_p / opts_q);
      b_upfirdn(cpu_xIn, gpu_xIn, xIn_outdatedOnGpu, cpu_opts_filterWithPadding,
                c_opts_filterWithPadding_outdat, gpu_opts_filterWithPadding,
                d_opts_filterWithPadding_outdat, opts_p, opts_q, cpu_yOut,
                &yRow_outdatedOnCpu, &gpu_yOut, &yRow_outdatedOnGpu);
      if (std::isnan(b)) {
        b_i = y->size[0] * y->size[1];
        y->size[0] = 1;
        y->size[1] = 1;
        emxEnsureCapacity_real_T(y, b_i, &n_emlrtRTEI);
        y->data[0] = rtNaN;
      } else if (b < 1.0) {
        y->size[0] = 1;
        y->size[1] = 0;
      } else {
        b_i = y->size[0] * y->size[1];
        y->size[0] = 1;
        y->size[1] = static_cast<int32_T>(b - 1.0) + 1;
        emxEnsureCapacity_real_T(y, b_i, &n_emlrtRTEI);
        for (b_i = 0; b_i <= static_cast<int32_T>(b - 1.0); b_i++) {
          y->data[b_i] = static_cast<real_T>(b_i) + 1.0;
        }
      }
      i = cpu_yOut->size[1];
      b_i = cpu_xIn->size[0] * cpu_xIn->size[1];
      cpu_xIn->size[0] = y->size[1];
      cpu_xIn->size[1] = cpu_yOut->size[1];
      emxEnsureCapacity_creal32_T(cpu_xIn, b_i, &yg_emlrtRTEI);
      for (b_i = 0; b_i < i; b_i++) {
        for (int32_T u1{0}; u1 < y->size[1]; u1++) {
          if (*xIn_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_creal32_T(cpu_xIn, gpu_xIn);
          }
          if (yRow_outdatedOnCpu) {
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
      }
    }
  }
  emxFree_creal32_T(&yRow);
  emxFree_real_T(&b_y);
  emxFree_creal32_T(&cpu_yRow);
  emxFree_real_T(&y);
  emxFree_creal32_T(&cpu_yOut);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  gpuEmxFree_creal32_T(&gpu_yOut);
  gpuEmxFree_creal32_T(&gpu_yRow);
}

//
//
void uniformResampleAlongFirstDim(
    emxArray_real32_T *cpu_xIn, boolean_T *xIn_outdatedOnCpu,
    emxArray_real32_T *gpu_xIn, boolean_T *xIn_outdatedOnGpu, real_T opts_p,
    real_T opts_q, emxArray_real32_T *cpu_opts_filterWithPadding,
    boolean_T *c_opts_filterWithPadding_outdat,
    emxArray_real32_T *gpu_opts_filterWithPadding,
    boolean_T *d_opts_filterWithPadding_outdat, real_T opts_filterDelay)
{
  emxArray_real32_T gpu_yOut;
  emxArray_real32_T gpu_yRow;
  emxArray_real32_T *cpu_yOut;
  emxArray_real32_T *cpu_yRow;
  emxArray_real32_T *yRow;
  emxArray_real_T *b_y;
  emxArray_real_T *y;
  boolean_T yRow_outdatedOnCpu;
  boolean_T yRow_outdatedOnGpu;
  gpuEmxReset_real32_T(&gpu_yRow);
  gpuEmxReset_real32_T(&gpu_yOut);
  yRow_outdatedOnCpu = false;
  yRow_outdatedOnGpu = false;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInit_real32_T(&cpu_yOut, 2, &dh_emlrtRTEI, true);
  emxInit_real_T(&y, 2, &eh_emlrtRTEI, true);
  emxInit_real32_T(&cpu_yRow, 2, &fh_emlrtRTEI, true);
  emxInit_real_T(&b_y, 2, &eb_emlrtRTEI, true);
  emxInit_real32_T(&yRow, 1, &bh_emlrtRTEI, true);
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
        emxEnsureCapacity_real32_T(cpu_yRow, b_i, &ah_emlrtRTEI);
      } else {
        upfirdn(cpu_xIn, gpu_xIn, xIn_outdatedOnGpu, cpu_opts_filterWithPadding,
                c_opts_filterWithPadding_outdat, gpu_opts_filterWithPadding,
                d_opts_filterWithPadding_outdat, opts_p, opts_q, cpu_yRow,
                &yRow_outdatedOnCpu, &gpu_yRow, &yRow_outdatedOnGpu);
      }
      if (std::isnan(b)) {
        b_i = b_y->size[0] * b_y->size[1];
        b_y->size[0] = 1;
        b_y->size[1] = 1;
        emxEnsureCapacity_real_T(b_y, b_i, &n_emlrtRTEI);
        b_y->data[0] = rtNaN;
      } else if (b < 1.0) {
        b_y->size[0] = 1;
        b_y->size[1] = 0;
      } else {
        b_i = b_y->size[0] * b_y->size[1];
        b_y->size[0] = 1;
        b_y->size[1] = static_cast<int32_T>(b - 1.0) + 1;
        emxEnsureCapacity_real_T(b_y, b_i, &n_emlrtRTEI);
        for (b_i = 0; b_i <= static_cast<int32_T>(b - 1.0); b_i++) {
          b_y->data[b_i] = static_cast<real_T>(b_i) + 1.0;
        }
      }
      i = static_cast<int32_T>(b);
      b_i = yRow->size[0];
      yRow->size[0] = static_cast<int32_T>(b);
      emxEnsureCapacity_real32_T(yRow, b_i, &bh_emlrtRTEI);
      for (b_i = 0; b_i < i; b_i++) {
        if (yRow_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real32_T(cpu_yRow, &gpu_yRow);
        }
        yRow_outdatedOnCpu = false;
        yRow->data[b_i] =
            cpu_yRow
                ->data[static_cast<int32_T>(opts_filterDelay + b_y->data[b_i]) -
                       1];
      }
      i = static_cast<int32_T>(b);
      b_i = cpu_xIn->size[0] * cpu_xIn->size[1];
      cpu_xIn->size[0] = static_cast<int32_T>(b);
      cpu_xIn->size[1] = 1;
      emxEnsureCapacity_real32_T(cpu_xIn, b_i, &ch_emlrtRTEI);
      for (u1 = 0; u1 < i; u1++) {
        if (*xIn_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real32_T(cpu_xIn, gpu_xIn);
        }
        cpu_xIn->data[u1] = yRow->data[u1];
        *xIn_outdatedOnCpu = false;
        *xIn_outdatedOnGpu = true;
      }
    } else {
      real_T b;
      int32_T b_i;
      int32_T i;
      b = std::ceil(static_cast<real_T>(cpu_xIn->size[0]) * opts_p / opts_q);
      upfirdn(cpu_xIn, gpu_xIn, xIn_outdatedOnGpu, cpu_opts_filterWithPadding,
              c_opts_filterWithPadding_outdat, gpu_opts_filterWithPadding,
              d_opts_filterWithPadding_outdat, opts_p, opts_q, cpu_yOut,
              &yRow_outdatedOnCpu, &gpu_yOut, &yRow_outdatedOnGpu);
      if (std::isnan(b)) {
        b_i = y->size[0] * y->size[1];
        y->size[0] = 1;
        y->size[1] = 1;
        emxEnsureCapacity_real_T(y, b_i, &n_emlrtRTEI);
        y->data[0] = rtNaN;
      } else if (b < 1.0) {
        y->size[0] = 1;
        y->size[1] = 0;
      } else {
        b_i = y->size[0] * y->size[1];
        y->size[0] = 1;
        y->size[1] = static_cast<int32_T>(b - 1.0) + 1;
        emxEnsureCapacity_real_T(y, b_i, &n_emlrtRTEI);
        for (b_i = 0; b_i <= static_cast<int32_T>(b - 1.0); b_i++) {
          y->data[b_i] = static_cast<real_T>(b_i) + 1.0;
        }
      }
      i = cpu_yOut->size[1];
      b_i = cpu_xIn->size[0] * cpu_xIn->size[1];
      cpu_xIn->size[0] = y->size[1];
      cpu_xIn->size[1] = cpu_yOut->size[1];
      emxEnsureCapacity_real32_T(cpu_xIn, b_i, &yg_emlrtRTEI);
      for (b_i = 0; b_i < i; b_i++) {
        for (int32_T u1{0}; u1 < y->size[1]; u1++) {
          if (*xIn_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_xIn, gpu_xIn);
          }
          if (yRow_outdatedOnCpu) {
            gpuEmxMemcpyGpuToCpu_real32_T(cpu_yOut, &gpu_yOut);
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
      }
    }
  }
  emxFree_real32_T(&yRow);
  emxFree_real_T(&b_y);
  emxFree_real32_T(&cpu_yRow);
  emxFree_real_T(&y);
  emxFree_real32_T(&cpu_yOut);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  gpuEmxFree_real32_T(&gpu_yOut);
  gpuEmxFree_real32_T(&gpu_yRow);
}

} // namespace resample
} // namespace internal
} // namespace b_signal
} // namespace coder

// End of code generation (uniformResampleKernel.cu)
