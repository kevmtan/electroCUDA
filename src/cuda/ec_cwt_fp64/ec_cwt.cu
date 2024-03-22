//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_cwt.cu
//
// Code generation for function 'ec_cwt'
//

// Include files
#include "ec_cwt.h"
#include "ResampleParser.h"
#include "conv2.h"
#include "cwtfilterbank.h"
#include "ec_cwt_data.h"
#include "ec_cwt_emxutil.h"
#include "ec_cwt_mexutil.h"
#include "ec_cwt_types.h"
#include "rt_nonfinite.h"
#include "uniformResampleKernel.h"
#include "wt.h"
#include "MWCudaDimUtility.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include "math_constants.h"
#include <cmath>

// Variable Definitions
static emlrtRTEInfo emlrtRTEI{
    25,                                                 // lineNo
    1,                                                  // colNo
    "ec_cwt",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwt.m" // pName
};

static emlrtRTEInfo b_emlrtRTEI{
    1,                                                  // lineNo
    22,                                                 // colNo
    "ec_cwt",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwt.m" // pName
};

static emlrtRTEInfo c_emlrtRTEI{
    37,                                                 // lineNo
    21,                                                 // colNo
    "ec_cwt",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwt.m" // pName
};

static emlrtRTEInfo e_emlrtRTEI{
    37,                                                 // lineNo
    5,                                                  // colNo
    "ec_cwt",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwt.m" // pName
};

static emlrtRTEInfo f_emlrtRTEI{
    43,                                                 // lineNo
    9,                                                  // colNo
    "ec_cwt",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwt.m" // pName
};

static emlrtRTEInfo g_emlrtRTEI{
    154,                                                        // lineNo
    1,                                                          // colNo
    "resample",                                                 // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/resample.m" // pName
};

static emlrtRTEInfo h_emlrtRTEI{
    38,                      // lineNo
    9,                       // colNo
    "uniformResampleKernel", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/uniformResampleKernel.m" // pName
};

static emlrtRTEInfo i_emlrtRTEI{
    21,                      // lineNo
    9,                       // colNo
    "uniformResampleKernel", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/uniformResampleKernel.m" // pName
};

static emlrtRTEInfo j_emlrtRTEI{
    41,                                                 // lineNo
    9,                                                  // colNo
    "ec_cwt",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwt.m" // pName
};

static emlrtRTEInfo k_emlrtRTEI{
    31,                      // lineNo
    29,                      // colNo
    "uniformResampleKernel", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/uniformResampleKernel.m" // pName
};

static emlrtRTEInfo l_emlrtRTEI{
    41,                      // lineNo
    5,                       // colNo
    "uniformResampleKernel", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/uniformResampleKernel.m" // pName
};

static emlrtRTEInfo m_emlrtRTEI{
    22,                      // lineNo
    9,                       // colNo
    "uniformResampleKernel", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/uniformResampleKernel.m" // pName
};

static emlrtRTEInfo r_emlrtRTEI{
    23,                                                 // lineNo
    1,                                                  // colNo
    "ec_cwt",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwt.m" // pName
};

static emlrtRTEInfo s_emlrtRTEI{
    37,                                                 // lineNo
    11,                                                 // colNo
    "ec_cwt",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwt.m" // pName
};

static emlrtRTEInfo t_emlrtRTEI{
    37,                                                 // lineNo
    15,                                                 // colNo
    "ec_cwt",                                           // fName
    "/home/kt/Gdrive/Git/electroCUDA/src/cuda/ec_cwt.m" // pName
};

static emlrtRTEInfo u_emlrtRTEI{
    15,                      // lineNo
    9,                       // colNo
    "uniformResampleKernel", // fName
    "/usr/local/MATLAB/R2024a/toolbox/signal/signal/+signal/+internal/"
    "+resample/uniformResampleKernel.m" // pName
};

// Function Declarations
static __global__ void ec_cwt_kernel1(const int32_T ch, const emxArray_real_T x,
                                      const int32_T b_x, emxArray_real_T c_x,
                                      int32_T x_dim0);

static __global__ void ec_cwt_kernel10(const emxArray_real_T xCh,
                                       const int32_T b_xCh, const int32_T c_xCh,
                                       emxArray_real_T opts_x,
                                       int32_T opts_x_dim0, int32_T xCh_dim0);

static __global__ void ec_cwt_kernel2(const emxArray_creal_T x, const int32_T b,
                                      emxArray_real_T y);

static __global__ void ec_cwt_kernel3(const emxArray_real_T y,
                                      const int32_T b_y, const int32_T c_y,
                                      emxArray_real_T xCh, int32_T xCh_dim0,
                                      int32_T y_dim0);

static __global__ void ec_cwt_kernel4(const emxArray_real_T xCh,
                                      const int32_T b, emxArray_real_T opts_x);

static __global__ void ec_cwt_kernel5(const emxArray_real_T w, const int32_T nx,
                                      const int32_T b, emxArray_real_T y);

static __global__ void ec_cwt_kernel6(emxArray_real_T y);

static __global__ void ec_cwt_kernel7(const emxArray_real_T y,
                                      const emxArray_real_T b_y,
                                      const real_T nlast, const int32_T ii,
                                      const int32_T b, emxArray_real_T b_y1,
                                      int32_T y1_dim0);

static __global__ void ec_cwt_kernel8(const int32_T b, emxArray_real_T y);

static __global__ void ec_cwt_kernel9(const emxArray_real_T xCh,
                                      const int32_T b_xCh,
                                      emxArray_real_T opts_x);

// Function Definitions
static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel1(
    const int32_T ch, const emxArray_real_T x, const int32_T b_x,
    emxArray_real_T c_x, int32_T x_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_x);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    c_x.data[i1] = x.data[i1 + x_dim0 * ch];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel10(
    const emxArray_real_T xCh, const int32_T b_xCh, const int32_T c_xCh,
    emxArray_real_T opts_x, int32_T opts_x_dim0, int32_T xCh_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(c_xCh) + 1UL) *
                (static_cast<uint64_T>(b_xCh) + 1UL) -
            1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_xCh) + 1UL));
    i1 = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
                              (static_cast<uint64_T>(b_xCh) + 1UL));
    opts_x.data[k + opts_x_dim0 * i1] = xCh.data[i1 + xCh_dim0 * k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel2(
    const emxArray_creal_T x, const int32_T b, emxArray_real_T y)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T k;
    k = static_cast<int32_T>(idx);
    y.data[k] = hypot(x.data[k].re, x.data[k].im);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel3(
    const emxArray_real_T y, const int32_T b_y, const int32_T c_y,
    emxArray_real_T xCh, int32_T xCh_dim0, int32_T y_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(c_y) + 1UL) * (static_cast<uint64_T>(b_y) + 1UL) -
      1UL;
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    int32_T k;
    k = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_y) + 1UL));
    i1 = static_cast<int32_T>((idx - static_cast<uint64_T>(k)) /
                              (static_cast<uint64_T>(b_y) + 1UL));
    xCh.data[k + xCh_dim0 * i1] = y.data[i1 + y_dim0 * k];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel4(
    const emxArray_real_T xCh, const int32_T b, emxArray_real_T opts_x)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    opts_x.data[i1] = xCh.data[i1];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel5(
    const emxArray_real_T w, const int32_T nx, const int32_T b,
    emxArray_real_T y)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    y.data[i1] = w.data[nx * i1];
  }
}

static __global__ __launch_bounds__(32,
                                    1) void ec_cwt_kernel6(emxArray_real_T y)
{
  int32_T tmpIdx;
  tmpIdx = static_cast<int32_T>(mwGetGlobalThreadIndex());
  if (tmpIdx < 1) {
    y.data[0] = CUDART_NAN;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel7(
    const emxArray_real_T y, const emxArray_real_T b_y, const real_T nlast,
    const int32_T ii, const int32_T b, emxArray_real_T b_y1, int32_T y1_dim0)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    b_y1.data[i1 + y1_dim0 * ii] =
        y.data[static_cast<int32_T>(nlast + b_y.data[i1]) - 1];
  }
}

static __global__ __launch_bounds__(1024,
                                    1) void ec_cwt_kernel8(const int32_T b,
                                                           emxArray_real_T y)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    y.data[i1] = static_cast<real_T>(i1) + 1.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_cwt_kernel9(
    const emxArray_real_T xCh, const int32_T b_xCh, emxArray_real_T opts_x)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_xCh);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T i1;
    i1 = static_cast<int32_T>(idx);
    opts_x.data[i1] = xCh.data[i1];
  }
}

//
// function [y,freqs] = ec_cwt(x,fs,fLims,fVoices,ds)
void ec_cwt(const emxArray_real_T *cpu_x, real_T fs, const real_T fLims[2],
            real_T fVoices, const real_T ds[2], emxArray_cell_wrap_0 *y,
            emxArray_real_T *freqs)
{
  static const int32_T iv1[2]{1, 7};
  static const int32_T iv2[2]{1, 7};
  static const char_T rfmt[7]{'%', '2', '3', '.', '1', '5', 'e'};
  coder::b_signal::internal::resample::ResampleParser expl_temp;
  coder::cwtfilterbank fb;
  dim3 block;
  dim3 grid;
  emxArray_creal_T c_gpu_x;
  emxArray_creal_T *b_cpu_x;
  emxArray_real_T b_gpu_x;
  emxArray_real_T b_gpu_y;
  emxArray_real_T b_yCol;
  emxArray_real_T c_gpu_y;
  emxArray_real_T gpu_opts_x;
  emxArray_real_T gpu_w;
  emxArray_real_T gpu_x;
  emxArray_real_T gpu_xCh;
  emxArray_real_T gpu_y;
  emxArray_real_T gpu_y1;
  emxArray_real_T *b_cpu_y;
  emxArray_real_T *c_cpu_x;
  emxArray_real_T *c_cpu_y;
  emxArray_real_T *cpu_opts_x;
  emxArray_real_T *cpu_w;
  emxArray_real_T *cpu_xCh;
  emxArray_real_T *cpu_y;
  emxArray_real_T *cpu_y1;
  emxArray_real_T *yCol;
  const mxArray *b_y;
  const mxArray *c_y;
  const mxArray *d_y;
  const mxArray *e_y;
  const mxArray *m;
  const mxArray *m1;
  const mxArray *m2;
  const mxArray *m3;
  real_T Ly;
  int32_T b_expl_temp[1];
  int32_T exponent;
  int32_T i;
  int32_T i1;
  int32_T i3;
  int32_T i4;
  char_T unusedExpr[23];
  boolean_T doDownsample;
  boolean_T w_outdatedOnCpu;
  boolean_T w_outdatedOnGpu;
  boolean_T x_needsGpuEnsureCapacity;
  boolean_T x_outdatedOnGpu;
  boolean_T y_needsGpuEnsureCapacity;
  gpuEmxReset_real_T(&b_gpu_x);
  gpuEmxReset_real_T(&c_gpu_y);
  gpuEmxReset_real_T(&b_gpu_y);
  gpuEmxReset_real_T(&gpu_w);
  gpuEmxReset_real_T(&gpu_y1);
  gpuEmxReset_real_T(&gpu_opts_x);
  gpuEmxReset_real_T(&gpu_xCh);
  gpuEmxReset_creal_T(&c_gpu_x);
  gpuEmxReset_real_T(&gpu_y);
  gpuEmxReset_real_T(&gpu_x);
  w_outdatedOnCpu = false;
  w_outdatedOnGpu = false;
  x_outdatedOnGpu = true;
  y_needsGpuEnsureCapacity = true;
  x_needsGpuEnsureCapacity = true;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInitStruct_cwtfilterbank(&fb, &r_emlrtRTEI, true);
  //  Continuous wavelet transform - CUDA binary wrapper (double-precision,
  //  FP64) CWT uses morse wavelets, as they account for unequal
  //  variance-covariance across freqs. L1-norm is applied to mitigate 1/f decay
  //  of neuronal field potentials. Log-transform & robust z-scoring converts
  //  absolute valued CWT outputs into normal distribution.
  //
  //  Kevin Tan, 2022 (kevmtan.github.io)
  //  Input validation
  // 'ec_cwt:11' x (:,:){mustBeFloat}
  //  Input data
  // 'ec_cwt:12' fs (1,1) double = 1000
  //  Sampling rate
  // 'ec_cwt:13' fLims (1,2) double = [1 300]
  //  Frequency limits
  // 'ec_cwt:14' fVoices (1,1) double = 10
  //  Voices per octave
  // 'ec_cwt:15' ds (1,2) double = [1 1]
  //  Frequency limits
  // 'ec_cwt:17' coder.gpu.kernelfun;
  // 'ec_cwt:18' nFrames = height(x);
  // 'ec_cwt:19' nChs = width(x);
  // 'ec_cwt:20' doDownsample = ds(2)>ds(1);
  doDownsample = (ds[1] > ds[0]);
  //  Prep CWT
  // 'ec_cwt:23' fb = cwtfilterbank(Wavelet="Morse",SignalLength=nFrames,...
  // 'ec_cwt:24'
  // SamplingFrequency=fs,FrequencyLimits=fLims,VoicesPerOctave=fVoices);
  coder::cwtfilterbank_cwtfilterbank(&fb, static_cast<real_T>(cpu_x->size[0]),
                                     fs, fLims, fVoices);
  // 'ec_cwt:25' freqs = centerFrequencies(fb);
  i = freqs->size[0];
  freqs->size[0] = fb.WaveletCenterFrequencies->size[0];
  emxEnsureCapacity_real_T(freqs, i, &emlrtRTEI);
  for (i = 0; i < fb.WaveletCenterFrequencies->size[0]; i++) {
    freqs->data[i] = fb.WaveletCenterFrequencies->data[i];
  }
  //  nFreqs = uint32(numel(freqs));
  //  nFrames = uint32(numel(1:ds:nFrames));
  //  Preallocate
  // 'ec_cwt:30' tmp = cell(1,nChs);
  i = y->size[0] * y->size[1];
  y->size[0] = 1;
  y->size[1] = cpu_x->size[1];
  emxEnsureCapacity_cell_wrap_0(y, i, &b_emlrtRTEI);
  // 'ec_cwt:31' y = coder.nullcopy(tmp);
  //  y = coder.nullcopy(zeros([nFrames nChs nFreqs],like=x)); % Preallocate
  //  output Channel loop
  // 'ec_cwt:35' for ch = 1:nChs
  i1 = cpu_x->size[1];
  emxInit_real_T(&cpu_y, 2, &s_emlrtRTEI, true);
  emxInit_creal_T(&b_cpu_x, 2, &t_emlrtRTEI, true);
  emxInit_real_T(&cpu_xCh, 2, &e_emlrtRTEI, true);
  emxInit_real_T(&cpu_opts_x, 2, &g_emlrtRTEI, true);
  emxInit_real_T(&cpu_y1, 2, &u_emlrtRTEI, true);
  emxInit_real_T(&yCol, 1, &v_emlrtRTEI, true);
  emxInit_real_T(&cpu_w, 1, &o_emlrtRTEI, true);
  emxInit_real_T(&b_cpu_y, 1, &o_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_y, 2, &w_emlrtRTEI, true);
  emxInitStruct_ResampleParser(&expl_temp, &g_emlrtRTEI, true);
  emxInit_real_T(&c_cpu_x, 1, &c_emlrtRTEI, true);
  for (int32_T ch{0}; ch < i1; ch++) {
    int32_T f_y;
    int32_T nx;
    uint32_T b_dv[2];
    boolean_T validLaunchParams;
    boolean_T xCh_outdatedOnCpu;
    //  CWT
    // 'ec_cwt:37' xCh = abs(wt(fb,x(:,ch)))';
    i = c_cpu_x->size[0];
    c_cpu_x->size[0] = cpu_x->size[0];
    emxEnsureCapacity_real_T(c_cpu_x, i, &c_emlrtRTEI);
    i = cpu_x->size[0] - 1;
    mwGetLaunchParameters1D(computeNumIters(i), &grid, &block, 2147483647U);
    if (x_needsGpuEnsureCapacity) {
      gpuEmxEnsureCapacity_real_T(cpu_x, &gpu_x, !x_outdatedOnGpu);
    }
    x_needsGpuEnsureCapacity = false;
    gpuEmxEnsureCapacity_real_T(c_cpu_x, &b_gpu_x, true);
    if (x_outdatedOnGpu) {
      gpuEmxMemcpyCpuToGpu_real_T(&gpu_x, cpu_x);
    }
    x_outdatedOnGpu = false;
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwt_kernel1<<<grid, block>>>(ch, gpu_x, i, b_gpu_x, cpu_x->size[0U]);
    }
    gpuEmxMemcpyGpuToCpu_real_T(c_cpu_x, &b_gpu_x);
    coder::cwtfilterbank_wt(&fb, c_cpu_x, b_cpu_x);
    nx = b_cpu_x->size[0] * b_cpu_x->size[1];
    for (i = 0; i < 2; i++) {
      b_dv[i] = static_cast<uint32_T>(b_cpu_x->size[i]);
    }
    i = cpu_y->size[0] * cpu_y->size[1];
    cpu_y->size[0] = static_cast<int32_T>(b_dv[0]);
    cpu_y->size[1] = static_cast<int32_T>(b_dv[1]);
    emxEnsureCapacity_real_T(cpu_y, i, &d_emlrtRTEI);
    mwGetLaunchParameters1D(computeNumIters(nx - 1), &grid, &block,
                            2147483647U);
    gpuEmxEnsureCapacity_creal_T(b_cpu_x, &c_gpu_x, false);
    gpuEmxEnsureCapacity_real_T(cpu_y, &gpu_y, true);
    gpuEmxMemcpyCpuToGpu_creal_T(&c_gpu_x, b_cpu_x);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwt_kernel2<<<grid, block>>>(c_gpu_x, nx - 1, gpu_y);
    }
    i = cpu_xCh->size[0] * cpu_xCh->size[1];
    cpu_xCh->size[0] = cpu_y->size[1];
    cpu_xCh->size[1] = cpu_y->size[0];
    emxEnsureCapacity_real_T(cpu_xCh, i, &e_emlrtRTEI);
    i = cpu_y->size[0] - 1;
    f_y = cpu_y->size[1] - 1;
    mwGetLaunchParameters1D(computeNumIters(i, f_y), &grid, &block,
                            2147483647U);
    gpuEmxEnsureCapacity_real_T(cpu_xCh, &gpu_xCh, true);
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      ec_cwt_kernel3<<<grid, block>>>(gpu_y, f_y, i, gpu_xCh, cpu_xCh->size[0U],
                                      cpu_y->size[0U]);
    }
    xCh_outdatedOnCpu = true;
    //  CWT
    //  Downsample
    // 'ec_cwt:40' if doDownsample
    if (doDownsample) {
      real_T xCh[2];
      real_T absx;
      real_T dlast;
      real_T n;
      real_T x;
      real_T xin;
      int32_T opts_dim;
      // 'ec_cwt:41' y{ch} = resample(xCh,ds(1),ds(2));
      if ((cpu_xCh->size[0] == 1) || (cpu_xCh->size[1] == 1)) {
        opts_dim = 1;
      } else {
        opts_dim = 2;
        if (cpu_xCh->size[0] != 1) {
          opts_dim = 1;
        }
      }
      xCh_outdatedOnCpu = (cpu_xCh->size[0] == 1);
      if (opts_dim == 1) {
        if ((cpu_xCh->size[0] == 1) || (cpu_xCh->size[1] == 1)) {
          if ((cpu_xCh->size[0] == 0) || (cpu_xCh->size[1] == 0)) {
            f_y = 0;
          } else {
            nx = cpu_xCh->size[0];
            f_y = cpu_xCh->size[1];
            if (nx >= f_y) {
              f_y = nx;
            }
          }
          i = cpu_opts_x->size[0] * cpu_opts_x->size[1];
          cpu_opts_x->size[0] = f_y;
          cpu_opts_x->size[1] = 1;
          emxEnsureCapacity_real_T(cpu_opts_x, i, &g_emlrtRTEI);
          mwGetLaunchParameters1D(computeNumIters(f_y - 1), &grid, &block,
                                  2147483647U);
          gpuEmxEnsureCapacity_real_T(cpu_opts_x, &gpu_opts_x, true);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwt_kernel4<<<grid, block>>>(gpu_xCh, f_y - 1, gpu_opts_x);
          }
        } else {
          i = cpu_opts_x->size[0] * cpu_opts_x->size[1];
          cpu_opts_x->size[0] = cpu_xCh->size[0];
          cpu_opts_x->size[1] = cpu_xCh->size[1];
          emxEnsureCapacity_real_T(cpu_opts_x, i, &g_emlrtRTEI);
          i = cpu_xCh->size[0] * cpu_xCh->size[1] - 1;
          mwGetLaunchParameters1D(computeNumIters(i), &grid, &block,
                                  2147483647U);
          gpuEmxEnsureCapacity_real_T(cpu_opts_x, &gpu_opts_x, true);
          validLaunchParams = mwValidateLaunchParameters(grid, block);
          if (validLaunchParams) {
            ec_cwt_kernel9<<<grid, block>>>(gpu_xCh, i, gpu_opts_x);
          }
        }
      } else {
        i = cpu_opts_x->size[0] * cpu_opts_x->size[1];
        cpu_opts_x->size[0] = cpu_xCh->size[1];
        cpu_opts_x->size[1] = cpu_xCh->size[0];
        emxEnsureCapacity_real_T(cpu_opts_x, i, &g_emlrtRTEI);
        i = cpu_xCh->size[0] - 1;
        f_y = cpu_xCh->size[1] - 1;
        mwGetLaunchParameters1D(computeNumIters(i, f_y), &grid, &block,
                                2147483647U);
        gpuEmxEnsureCapacity_real_T(cpu_opts_x, &gpu_opts_x, true);
        validLaunchParams = mwValidateLaunchParameters(grid, block);
        if (validLaunchParams) {
          ec_cwt_kernel10<<<grid, block>>>(gpu_xCh, f_y, i, gpu_opts_x,
                                           cpu_opts_x->size[0U],
                                           cpu_xCh->size[0U]);
        }
      }
      x = ds[0] / ds[1];
      xin = x;
      absx = std::abs(x);
      if (std::isinf(absx) || std::isnan(absx)) {
        absx = rtNaN;
      } else if (absx < 4.4501477170144028E-308) {
        absx = 4.94065645841247E-324;
      } else {
        std::frexp(absx, &exponent);
        absx = std::ldexp(1.0, exponent - 53);
      }
      absx = std::fmax(1.0E-12, absx);
      if (std::isinf(x) || std::isnan(x)) {
        if (!std::isnan(x)) {
          if (x < 0.0) {
            n = -1.0;
          } else {
            n = 1.0;
          }
        } else {
          n = 0.0;
        }
        absx = 0.0;
      } else {
        real_T d;
        real_T nlast;
        n = 1.0;
        d = 0.0;
        nlast = 0.0;
        dlast = 1.0;
        real_T rndx;
        int32_T exitg1;
        do {
          exitg1 = 0;
          rndx = std::round(x);
          if (!std::isinf(x)) {
            real_T tmp;
            x -= rndx;
            tmp = nlast;
            nlast = n;
            n = n * rndx + tmp;
            tmp = dlast;
            dlast = d;
            d = d * rndx + tmp;
          } else {
            nlast = n;
            dlast = d;
            n = x;
            d = 0.0;
          }
          if ((x == 0.0) || (std::abs(n / d - xin) <= absx)) {
            exitg1 = 1;
          } else {
            x = 1.0 / x;
          }
        } while (exitg1 == 0);
        if (std::isnan(d)) {
          x = rtNaN;
        } else if (d < 0.0) {
          x = -1.0;
        } else {
          x = (d > 0.0);
        }
        n /= x;
        absx = std::abs(d);
      }
      for (i = 0; i < 2; i++) {
        xCh[i] = cpu_xCh->size[i];
      }
      gpuEmxMemcpyGpuToCpu_real_T(cpu_opts_x, &gpu_opts_x);
      coder::b_signal::internal::resample::c_ResampleParser_createFilterAn(
          opts_dim, n, absx, xCh, xCh_outdatedOnCpu, cpu_opts_x, &expl_temp);
      absx = expl_temp.p;
      n = expl_temp.q;
      if (expl_temp.dim == 1) {
        if (expl_temp.isRowVectorInput) {
          i = cpu_y1->size[0] * cpu_y1->size[1];
          cpu_y1->size[0] = expl_temp.x->size[0];
          cpu_y1->size[1] = expl_temp.x->size[1];
          emxEnsureCapacity_real_T(cpu_y1, i, &i_emlrtRTEI);
          for (i = 0; i < expl_temp.x->size[0] * expl_temp.x->size[1]; i++) {
            cpu_y1->data[i] = expl_temp.x->data[i];
          }
          coder::b_signal::internal::resample::uniformResampleAlongFirstDim(
              cpu_y1, expl_temp.p, expl_temp.q, expl_temp.filterWithPadding,
              expl_temp.filterDelay);
          if ((cpu_y1->size[0] == 0) || (cpu_y1->size[1] == 0)) {
            f_y = 0;
          } else {
            nx = cpu_y1->size[0];
            f_y = cpu_y1->size[1];
            if (nx >= f_y) {
              f_y = nx;
            }
          }
          i = expl_temp.x->size[0] * expl_temp.x->size[1];
          expl_temp.x->size[0] = 1;
          expl_temp.x->size[1] = f_y;
          emxEnsureCapacity_real_T(expl_temp.x, i, &m_emlrtRTEI);
          for (i = 0; i < f_y; i++) {
            expl_temp.x->data[i] = cpu_y1->data[i];
          }
        } else {
          coder::b_signal::internal::resample::uniformResampleAlongFirstDim(
              expl_temp.x, expl_temp.p, expl_temp.q,
              expl_temp.filterWithPadding, expl_temp.filterDelay);
        }
      } else {
        if (expl_temp.x->size[0] == 1) {
          boolean_T y1_needsGpuEnsureCapacity;
          dlast = std::ceil(expl_temp.p / expl_temp.q);
          xCh_outdatedOnCpu = false;
          i = cpu_y1->size[0] * cpu_y1->size[1];
          cpu_y1->size[0] = static_cast<int32_T>(dlast);
          cpu_y1->size[1] = expl_temp.x->size[1];
          emxEnsureCapacity_real_T(cpu_y1, i, &k_emlrtRTEI);
          y1_needsGpuEnsureCapacity = true;
          opts_dim = expl_temp.x->size[0] * expl_temp.x->size[1];
          if (opts_dim - 1 >= 0) {
            if ((static_cast<int32_T>(expl_temp.p) == 0) ||
                ((static_cast<int32_T>(expl_temp.p) > 0) &&
                 (static_cast<int32_T>(expl_temp.p) < 1))) {
              i3 = 1;
              i4 = 0;
            } else {
              i3 = static_cast<int32_T>(expl_temp.p);
              i4 = static_cast<int32_T>(expl_temp.p);
            }
            Ly = std::ceil(
                (0.0 * expl_temp.p +
                 static_cast<real_T>(expl_temp.filterWithPadding->size[0])) /
                expl_temp.q);
          }
          for (int32_T ii{0}; ii < opts_dim; ii++) {
            if (!(absx - 1.0 >= 0.0)) {
              b_y = nullptr;
              m = emlrtCreateCharArray(2, &iv1[0]);
              emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m, &rfmt[0]);
              emlrtAssign(&b_y, m);
              c_y = nullptr;
              m1 = emlrtCreateDoubleScalar(absx - 1.0);
              emlrtAssign(&c_y, m1);
              emlrt_marshallIn(b_sprintf(b_y, c_y, &e_emlrtMCI),
                               "<output of sprintf>", unusedExpr);
            }
            i = yCol->size[0];
            yCol->size[0] = static_cast<int32_T>(absx);
            emxEnsureCapacity_real_T(yCol, i, &n_emlrtRTEI);
            for (i = 0; i < static_cast<int32_T>(absx); i++) {
              yCol->data[i] = 0.0;
            }
            f_y = div_s32(i4 - 1, i3) + 1;
            for (i = 0; i < f_y; i++) {
              yCol->data[i3 * i] = expl_temp.x->data[ii];
            }
            b_yCol = *yCol;
            b_expl_temp[0] = static_cast<int32_T>(absx);
            b_yCol.size = &b_expl_temp[0];
            b_yCol.numDimensions = 1;
            coder::b_conv2(&b_yCol, expl_temp.filterWithPadding, cpu_w,
                           &w_outdatedOnCpu, &gpu_w, &w_outdatedOnGpu);
            if (!(n - 1.0 >= 0.0)) {
              d_y = nullptr;
              m2 = emlrtCreateCharArray(2, &iv2[0]);
              emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m2, &rfmt[0]);
              emlrtAssign(&d_y, m2);
              e_y = nullptr;
              m3 = emlrtCreateDoubleScalar(n - 1.0);
              emlrtAssign(&e_y, m3);
              emlrt_marshallIn(b_sprintf(d_y, e_y, &e_emlrtMCI),
                               "<output of sprintf>", unusedExpr);
            }
            if (n == 0.0) {
              nx = 1;
              f_y = -1;
            } else {
              nx = static_cast<int32_T>(n);
              f_y = cpu_w->size[0] - 1;
            }
            i = b_cpu_y->size[0];
            b_cpu_y->size[0] = div_s32(f_y, nx) + 1;
            emxEnsureCapacity_real_T(b_cpu_y, i, &o_emlrtRTEI);
            i = f_y / nx;
            mwGetLaunchParameters1D(computeNumIters(i), &grid, &block,
                                    2147483647U);
            gpuEmxEnsureCapacity_real_T(cpu_w, &gpu_w, !w_outdatedOnGpu);
            gpuEmxEnsureCapacity_real_T(b_cpu_y, &b_gpu_y, true);
            xCh_outdatedOnCpu = false;
            if (w_outdatedOnGpu) {
              gpuEmxMemcpyCpuToGpu_real_T(&gpu_w, cpu_w);
            }
            w_outdatedOnGpu = false;
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwt_kernel5<<<grid, block>>>(gpu_w, nx, i, b_gpu_y);
            }
            if (!(div_s32(f_y, nx) + 1 < Ly)) {
              i = b_cpu_y->size[0];
              if (Ly < 1.0) {
                b_cpu_y->size[0] = 0;
              } else {
                b_cpu_y->size[0] = static_cast<int32_T>(Ly);
              }
              emxEnsureCapacity_real_T(b_cpu_y, i, &p_emlrtRTEI);
              xCh_outdatedOnCpu = true;
            }
            if (std::isnan(dlast)) {
              i = c_cpu_y->size[0] * c_cpu_y->size[1];
              c_cpu_y->size[0] = 1;
              c_cpu_y->size[1] = 1;
              emxEnsureCapacity_real_T(c_cpu_y, i, &q_emlrtRTEI);
              gpuEmxEnsureCapacity_real_T(c_cpu_y, &c_gpu_y, true);
              y_needsGpuEnsureCapacity = false;
              ec_cwt_kernel6<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(c_gpu_y);
            } else if (dlast < 1.0) {
              c_cpu_y->size[0] = 1;
              c_cpu_y->size[1] = 0;
            } else {
              i = c_cpu_y->size[0] * c_cpu_y->size[1];
              c_cpu_y->size[0] = 1;
              c_cpu_y->size[1] = static_cast<int32_T>(dlast - 1.0) + 1;
              emxEnsureCapacity_real_T(c_cpu_y, i, &q_emlrtRTEI);
              mwGetLaunchParameters1D(
                  computeNumIters(static_cast<int32_T>(dlast - 1.0)), &grid,
                  &block, 2147483647U);
              gpuEmxEnsureCapacity_real_T(c_cpu_y, &c_gpu_y, true);
              y_needsGpuEnsureCapacity = false;
              validLaunchParams = mwValidateLaunchParameters(grid, block);
              if (validLaunchParams) {
                ec_cwt_kernel8<<<grid, block>>>(
                    static_cast<int32_T>(dlast - 1.0), c_gpu_y);
              }
            }
            nx = cpu_y1->size[0];
            mwGetLaunchParameters1D(computeNumIters(nx - 1), &grid, &block,
                                    2147483647U);
            if (xCh_outdatedOnCpu) {
              gpuEmxEnsureCapacity_real_T(b_cpu_y, &b_gpu_y, true);
            }
            if (y_needsGpuEnsureCapacity) {
              gpuEmxEnsureCapacity_real_T(c_cpu_y, &c_gpu_y, true);
            }
            y_needsGpuEnsureCapacity = false;
            if (y1_needsGpuEnsureCapacity) {
              gpuEmxEnsureCapacity_real_T(cpu_y1, &gpu_y1, true);
            }
            y1_needsGpuEnsureCapacity = false;
            validLaunchParams = mwValidateLaunchParameters(grid, block);
            if (validLaunchParams) {
              ec_cwt_kernel7<<<grid, block>>>(b_gpu_y, c_gpu_y,
                                              expl_temp.filterDelay, ii, nx - 1,
                                              gpu_y1, cpu_y1->size[0U]);
            }
            xCh_outdatedOnCpu = true;
          }
        } else {
          xCh_outdatedOnCpu = false;
          i = cpu_y1->size[0] * cpu_y1->size[1];
          cpu_y1->size[0] = expl_temp.x->size[0];
          cpu_y1->size[1] = expl_temp.x->size[1];
          emxEnsureCapacity_real_T(cpu_y1, i, &h_emlrtRTEI);
          for (i = 0; i < expl_temp.x->size[0] * expl_temp.x->size[1]; i++) {
            cpu_y1->data[i] = expl_temp.x->data[i];
          }
          coder::b_signal::internal::resample::uniformResampleAlongFirstDim(
              cpu_y1, expl_temp.p, expl_temp.q, expl_temp.filterWithPadding,
              expl_temp.filterDelay);
        }
        if ((expl_temp.x->size[0] == 1) || (expl_temp.x->size[1] == 1)) {
          nx = static_cast<int32_T>(expl_temp.inputSize[0]);
          f_y = cpu_y1->size[0];
          i = expl_temp.x->size[0] * expl_temp.x->size[1];
          expl_temp.x->size[0] = static_cast<int32_T>(expl_temp.inputSize[0]);
          expl_temp.x->size[1] = cpu_y1->size[0];
          emxEnsureCapacity_real_T(expl_temp.x, i, &l_emlrtRTEI);
          for (i = 0; i < nx * f_y; i++) {
            if (xCh_outdatedOnCpu) {
              gpuEmxMemcpyGpuToCpu_real_T(cpu_y1, &gpu_y1);
            }
            xCh_outdatedOnCpu = false;
            expl_temp.x->data[i] = cpu_y1->data[i];
          }
        } else {
          i = expl_temp.x->size[0] * expl_temp.x->size[1];
          expl_temp.x->size[0] = cpu_y1->size[1];
          expl_temp.x->size[1] = cpu_y1->size[0];
          emxEnsureCapacity_real_T(expl_temp.x, i, &l_emlrtRTEI);
          for (i = 0; i < cpu_y1->size[0]; i++) {
            for (nx = 0; nx < cpu_y1->size[1]; nx++) {
              if (xCh_outdatedOnCpu) {
                gpuEmxMemcpyGpuToCpu_real_T(cpu_y1, &gpu_y1);
              }
              xCh_outdatedOnCpu = false;
              expl_temp.x->data[nx + expl_temp.x->size[0] * i] =
                  cpu_y1->data[i + cpu_y1->size[0] * nx];
            }
          }
        }
      }
      i = y->data[ch].f1->size[0] * y->data[ch].f1->size[1];
      y->data[ch].f1->size[0] = expl_temp.x->size[0];
      emxEnsureCapacity_real_T(y->data[ch].f1, i, &j_emlrtRTEI);
      i = y->data[ch].f1->size[0] * y->data[ch].f1->size[1];
      y->data[ch].f1->size[1] = expl_temp.x->size[1];
      emxEnsureCapacity_real_T(y->data[ch].f1, i, &j_emlrtRTEI);
      for (i = 0; i < expl_temp.x->size[0] * expl_temp.x->size[1]; i++) {
        y->data[ch].f1->data[i] = expl_temp.x->data[i];
      }
      //  Downsample
    } else {
      // 'ec_cwt:42' else
      // 'ec_cwt:43' y{ch} = xCh;
      i = y->data[ch].f1->size[0] * y->data[ch].f1->size[1];
      y->data[ch].f1->size[0] = cpu_xCh->size[0];
      emxEnsureCapacity_real_T(y->data[ch].f1, i, &f_emlrtRTEI);
      i = y->data[ch].f1->size[0] * y->data[ch].f1->size[1];
      y->data[ch].f1->size[1] = cpu_xCh->size[1];
      emxEnsureCapacity_real_T(y->data[ch].f1, i, &f_emlrtRTEI);
      for (i = 0; i < cpu_xCh->size[0] * cpu_xCh->size[1]; i++) {
        if (xCh_outdatedOnCpu) {
          gpuEmxMemcpyGpuToCpu_real_T(cpu_xCh, &gpu_xCh);
        }
        xCh_outdatedOnCpu = false;
        y->data[ch].f1->data[i] = cpu_xCh->data[i];
      }
    }
  }
  emxFree_real_T(&c_cpu_x);
  emxFreeStruct_ResampleParser(&expl_temp);
  emxFree_real_T(&c_cpu_y);
  emxFree_real_T(&b_cpu_y);
  emxFree_real_T(&cpu_w);
  emxFree_real_T(&yCol);
  emxFree_real_T(&cpu_y1);
  emxFree_real_T(&cpu_opts_x);
  emxFree_real_T(&cpu_xCh);
  emxFree_creal_T(&b_cpu_x);
  emxFree_real_T(&cpu_y);
  emxFreeStruct_cwtfilterbank(&fb);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  gpuEmxFree_real_T(&gpu_x);
  gpuEmxFree_real_T(&gpu_y);
  gpuEmxFree_creal_T(&c_gpu_x);
  gpuEmxFree_real_T(&gpu_xCh);
  gpuEmxFree_real_T(&gpu_opts_x);
  gpuEmxFree_real_T(&gpu_y1);
  gpuEmxFree_real_T(&gpu_w);
  gpuEmxFree_real_T(&b_gpu_y);
  gpuEmxFree_real_T(&c_gpu_y);
  gpuEmxFree_real_T(&b_gpu_x);
}

// End of code generation (ec_cwt.cu)
