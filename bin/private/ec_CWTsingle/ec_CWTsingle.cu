//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_CWTsingle.cu
//
// Code generation for function 'ec_CWTsingle'
//

// Include files
#include "ec_CWTsingle.h"
#include "ec_CWTsingle_data.h"
#include "ec_CWTsingle_emxutil.h"
#include "ec_CWTsingle_mexutil.h"
#include "ec_CWTsingle_types.h"
#include "rt_nonfinite.h"
#include "MWCUFFTPlanManager.hpp"
#include "MWCudaDimUtility.hpp"
#include "MWCudaMemoryFunctions.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include "cufft.h"
#include <cmath>
#include <cstring>

// Variable Definitions
static emlrtMCInfo emlrtMCI{
    53,                                                                // lineNo
    14,                                                                // colNo
    "nonConstPrint",                                                   // fName
    "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/strfun/sprintf.m" // pName
};

static emlrtMCInfo b_emlrtMCI{
    55,                                                                // lineNo
    15,                                                                // colNo
    "nonConstPrint",                                                   // fName
    "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/strfun/sprintf.m" // pName
};

static emlrtRTEInfo c_emlrtRTEI{
    1,    // lineNo
    1,    // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+gpu/"
    "wt.p" // pName
};

static emlrtRTEInfo d_emlrtRTEI{
    1,        // lineNo
    1,        // colNo
    "realWT", // fName
    "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+gpu/"
    "realWT.p" // pName
};

static emlrtRTEInfo e_emlrtRTEI{
    1,             // lineNo
    1,             // colNo
    "cwtFreqGrid", // fName
    "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+gpu/"
    "cwtFreqGrid.p" // pName
};

static emlrtRTEInfo f_emlrtRTEI{
    1,                 // lineNo
    1,                 // colNo
    "cuFFTNDCallback", // fName
    "/usr/local/MATLAB/R2022b/toolbox/gpucoder/gpucoder/+gpucoder/+internal/"
    "cuFFTNDCallback.p" // pName
};

static emlrtRTEInfo g_emlrtRTEI{
    1,           // lineNo
    1,           // colNo
    "cwtScales", // fName
    "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+gpu/"
    "cwtScales.p" // pName
};

static emlrtRTEInfo h_emlrtRTEI{
    1,              // lineNo
    1,              // colNo
    "freqToScales", // fName
    "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+gpu/"
    "freqToScales.p" // pName
};

static emlrtRTEInfo i_emlrtRTEI{
    9,                                                           // lineNo
    5,                                                           // colNo
    "ec_CWTsingle",                                              // fName
    "/home/kt/Gdrive/Git/electroCUDA/bin/src_mex/ec_CWTsingle.m" // pName
};

static emlrtRTEInfo j_emlrtRTEI{
    1,                // lineNo
    1,                // colNo
    "morseBPFilters", // fName
    "/usr/local/MATLAB/R2022b/toolbox/wavelet/wavelet/+wavelet/+internal/+gpu/"
    "morseBPFilters.p" // pName
};

static emlrtRTEInfo k_emlrtRTEI{
    30,                    // lineNo
    21,                    // colNo
    "applyScalarFunction", // fName
    "/usr/local/MATLAB/R2022b/toolbox/eml/eml/+coder/+internal/"
    "applyScalarFunction.m" // pName
};

static emlrtRTEInfo l_emlrtRTEI{
    10,                                                          // lineNo
    1,                                                           // colNo
    "ec_CWTsingle",                                              // fName
    "/home/kt/Gdrive/Git/electroCUDA/bin/src_mex/ec_CWTsingle.m" // pName
};

static emlrtRTEInfo m_emlrtRTEI{
    170,                     // lineNo
    24,                      // colNo
    "combineVectorElements", // fName
    "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/datafun/private/"
    "combineVectorElements.m" // pName
};

static emlrtRTEInfo n_emlrtRTEI{
    97,                      // lineNo
    13,                      // colNo
    "combineVectorElements", // fName
    "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/datafun/private/"
    "combineVectorElements.m" // pName
};

static emlrtRTEInfo o_emlrtRTEI{
    12,                                                          // lineNo
    10,                                                          // colNo
    "ec_CWTsingle",                                              // fName
    "/home/kt/Gdrive/Git/electroCUDA/bin/src_mex/ec_CWTsingle.m" // pName
};

static emlrtRTEInfo p_emlrtRTEI{
    12,                                                          // lineNo
    5,                                                           // colNo
    "ec_CWTsingle",                                              // fName
    "/home/kt/Gdrive/Git/electroCUDA/bin/src_mex/ec_CWTsingle.m" // pName
};

static emlrtRTEInfo q_emlrtRTEI{
    1,                                                           // lineNo
    27,                                                          // colNo
    "ec_CWTsingle",                                              // fName
    "/home/kt/Gdrive/Git/electroCUDA/bin/src_mex/ec_CWTsingle.m" // pName
};

static emlrtRTEInfo r_emlrtRTEI{
    104,                                                 // lineNo
    5,                                                   // colNo
    "cwt",                                               // fName
    "/usr/local/MATLAB/R2022b/toolbox/wavelet/eml/cwt.m" // pName
};

static emlrtRTEInfo s_emlrtRTEI{
    107,                                                 // lineNo
    9,                                                   // colNo
    "cwt",                                               // fName
    "/usr/local/MATLAB/R2022b/toolbox/wavelet/eml/cwt.m" // pName
};

static emlrtRTEInfo t_emlrtRTEI{
    10,                                                          // lineNo
    6,                                                           // colNo
    "ec_CWTsingle",                                              // fName
    "/home/kt/Gdrive/Git/electroCUDA/bin/src_mex/ec_CWTsingle.m" // pName
};

static emlrtRTEInfo u_emlrtRTEI{
    49,                                                              // lineNo
    9,                                                               // colNo
    "mean",                                                          // fName
    "/usr/local/MATLAB/R2022b/toolbox/eml/lib/matlab/datafun/mean.m" // pName
};

// Function Declarations
static void b_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_char_T *ret);

static __global__ void ec_CWTsingle_kernel1(const real_T freqLims[2],
                                            boolean_T b[2]);

static __global__ void ec_CWTsingle_kernel10(const emxArray_real32_T x,
                                             int32_T Norig,
                                             emxArray_real32_T xv);

static __global__ void ec_CWTsingle_kernel11(const emxArray_real32_T x,
                                             const int32_T Norig,
                                             const int32_T Npad, int32_T N,
                                             emxArray_real32_T xv);

static __global__ void ec_CWTsingle_kernel12(const emxArray_real32_T xv,
                                             int32_T b_xv,
                                             emxArray_creal32_T xdft);

static __global__ void ec_CWTsingle_kernel13(const emxArray_creal32_T xdft,
                                             const int32_T Nfilt, int32_T M,
                                             const int32_T cfsdft_dim0,
                                             const int32_T psidft_dim0,
                                             emxArray_real32_T b_psidft,
                                             emxArray_creal32_T cfsdft);

static __global__ void ec_CWTsingle_kernel14(const int32_T cfsdft_dim1,
                                             creal32_T *cfsdft);

static __global__ void ec_CWTsingle_kernel15(const creal32_T *cfsdft,
                                             const emxArray_creal32_T b_cfsdft,
                                             int32_T c_cfsdft,
                                             emxArray_creal32_T cfstmp);

static __global__ void ec_CWTsingle_kernel16(const int32_T cfsdft_dim1,
                                             uint32_T xSize[2]);

static __global__ void ec_CWTsingle_kernel17(int32_T xSize,
                                             emxArray_creal32_T cfstmp);

static __global__ void ec_CWTsingle_kernel18(const emxArray_creal32_T cfstmp,
                                             const int32_T Norig, int32_T Ns,
                                             const int32_T cfs_dim0,
                                             const int32_T cfstmp_dim0,
                                             emxArray_creal32_T cfs);

static __global__ void
ec_CWTsingle_kernel19(const emxArray_creal32_T cfstmp, const int32_T Npad,
                      const int32_T Norig, int32_T Ns, const int32_T cfs_dim0,
                      const int32_T cfstmp_dim0, emxArray_creal32_T cfs);

static __global__ void ec_CWTsingle_kernel2(const real_T maxscale,
                                            real_T freqLims[2]);

static __global__ void
ec_CWTsingle_kernel20(const real32_T maxwavcf, const real_T maxscale,
                      const boolean_T IsOdd, const int32_T M,
                      const int32_T Norig, emxArray_real_T coi);

static __global__ void ec_CWTsingle_kernel21(const emxArray_real_T coi,
                                             int32_T b_coi,
                                             emxArray_real32_T c_coi);

static __global__ void ec_CWTsingle_kernel22(int32_T b_cf,
                                             emxArray_real32_T c_cf,
                                             emxArray_real32_T freqs);

static __global__ void ec_CWTsingle_kernel23(const emxArray_creal32_T cfs,
                                             int32_T N, emxArray_real32_T y);

static __global__ void ec_CWTsingle_kernel24(const emxArray_real32_T y,
                                             const int32_T b_y, int32_T c_y,
                                             const int32_T wt_dim0,
                                             const int32_T y_dim0,
                                             emxArray_real32_T wt);

static __global__ void ec_CWTsingle_kernel25(const emxArray_real32_T wt,
                                             int32_T M, emxArray_real32_T y);

static __global__ void ec_CWTsingle_kernel26(const emxArray_real32_T wt,
                                             const int32_T N, int32_T M,
                                             emxArray_real32_T y);

static __global__ void ec_CWTsingle_kernel27(int32_T xSize,
                                             emxArray_real32_T y);

static __global__ void ec_CWTsingle_kernel28(const real32_T maxwavcf,
                                             const emxArray_real32_T y,
                                             int32_T b_y, emxArray_real32_T wt);

static __global__ void ec_CWTsingle_kernel29(const emxArray_real32_T wt,
                                             int32_T b_wt,
                                             emxArray_real32_T c_wt);

static __global__ void ec_CWTsingle_kernel3(const real_T fs,
                                            real_T freqLims[2]);

static __global__ void ec_CWTsingle_kernel4(const int32_T N,
                                            const real_T maxscale,
                                            const int32_T M,
                                            emxArray_real_T omega);

static __global__ void ec_CWTsingle_kernel5(const real_T freqLims[2],
                                            boolean_T b[2]);

static __global__ void ec_CWTsingle_kernel6(const real_T a0, int32_T Ns,
                                            emxArray_real_T scales);

static __global__ void ec_CWTsingle_kernel7(const real_T fs,
                                            real_T freqLims[2]);

static __global__ void ec_CWTsingle_kernel8(const real_T a0, const real_T s0,
                                            int32_T Ns, emxArray_real_T scales);

static __global__ void
ec_CWTsingle_kernel9(const real_T fs, const emxArray_real_T omega,
                     const emxArray_real_T scales, const int32_T M,
                     const int32_T N, int32_T Ns, const int32_T psidft_dim0,
                     emxArray_real32_T b_cf, emxArray_real32_T b_psidft);

static void emlrt_marshallIn(const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             emxArray_char_T *y);

static void emlrt_marshallIn(const mxArray *tmpStr, const char_T *identifier,
                             emxArray_char_T *y);

static const mxArray *feval(const mxArray *m1, const mxArray *m2,
                            const mxArray *m3, emlrtMCInfo *location);

static void gpuEmxEnsureCapacity_creal32_T(const emxArray_creal32_T *cpu,
                                           emxArray_creal32_T *gpu);

static void gpuEmxEnsureCapacity_real32_T(const emxArray_real32_T *cpu,
                                          emxArray_real32_T *gpu);

static void gpuEmxEnsureCapacity_real_T(const emxArray_real_T *cpu,
                                        emxArray_real_T *gpu);

static void gpuEmxFree_creal32_T(emxArray_creal32_T *gpu);

static void gpuEmxFree_real32_T(emxArray_real32_T *gpu);

static void gpuEmxFree_real_T(emxArray_real_T *gpu);

static void gpuEmxMemcpyCpuToGpu_creal32_T(emxArray_creal32_T *gpu,
                                           const emxArray_creal32_T *cpu);

static void gpuEmxMemcpyCpuToGpu_real32_T(emxArray_real32_T *gpu,
                                          const emxArray_real32_T *cpu);

static void gpuEmxMemcpyGpuToCpu_creal32_T(emxArray_creal32_T *cpu,
                                           emxArray_creal32_T *gpu);

static void gpuEmxMemcpyGpuToCpu_real32_T(emxArray_real32_T *cpu,
                                          emxArray_real32_T *gpu);

static void gpuEmxReset_creal32_T(emxArray_creal32_T *gpu);

static void gpuEmxReset_real32_T(emxArray_real32_T *gpu);

static void gpuEmxReset_real_T(emxArray_real_T *gpu);

static const mxArray *length(const mxArray *m1, emlrtMCInfo *location);

static real_T rt_powd_snf(real_T u0, real_T u1);

// Function Definitions
static void b_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_char_T *ret)
{
  static const int32_T dims[2]{1, -1};
  int32_T iv[2];
  int32_T i;
  const boolean_T bv[2]{false, true};
  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "char", false, 2U,
                            (const void *)&dims[0], &bv[0], &iv[0]);
  i = ret->size[0] * ret->size[1];
  ret->size[0] = iv[0];
  ret->size[1] = iv[1];
  emxEnsureCapacity_char_T(ret, i, static_cast<emlrtRTEInfo *>(nullptr));
  emlrtImportArrayR2015b(emlrtRootTLSGlobal, src, &ret->data[0], 1, false);
  emlrtDestroyArray(&src);
}

static __global__
    __launch_bounds__(32, 1) void ec_CWTsingle_kernel1(const real_T freqLims[2],
                                                       boolean_T b[2])
{
  uint64_T threadId;
  int32_T jj;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  jj = static_cast<int32_T>(threadId);
  if (jj < 2) {
    b[jj] = isnan(freqLims[jj]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_CWTsingle_kernel10(
    const emxArray_real32_T x, int32_T Norig, emxArray_real32_T xv)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(Norig - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T kk;
    kk = static_cast<int32_T>(idx);
    xv.data[kk] = x.data[kk];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_CWTsingle_kernel11(
    const emxArray_real32_T x, const int32_T Norig, const int32_T Npad,
    int32_T N, emxArray_real32_T xv)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(N);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T kk;
    kk = static_cast<int32_T>(idx);
    if (kk < Npad) {
      xv.data[kk] = x.data[(Npad - kk) - 1];
    } else {
      int32_T b_index;
      boolean_T guard1{false};
      guard1 = false;
      if (kk + 1 > Npad) {
        if (Norig > MAX_int32_T - Npad) {
          b_index = MAX_int32_T;
        } else {
          b_index = Npad + Norig;
        }
        if (kk + 1 <= b_index) {
          b_index = (Npad - kk) - 1;
          if (b_index < 0) {
            b_index = -b_index;
          }
          xv.data[kk] = x.data[b_index - 1];
        } else {
          guard1 = true;
        }
      } else {
        guard1 = true;
      }
      if (guard1) {
        if ((Norig > 0) && (Npad > MAX_int32_T - Norig)) {
          b_index = MAX_int32_T;
        } else {
          b_index = Norig + Npad;
        }
        if (kk + 1 > b_index) {
          if (Norig > 1073741823) {
            b_index = MAX_int32_T;
          } else {
            b_index = Norig << 1;
          }
          b_index = (b_index - kk) - 1;
          if ((b_index < 0) && (Npad < MIN_int32_T - b_index)) {
            b_index = MIN_int32_T;
          } else if ((b_index > 0) && (Npad > MAX_int32_T - b_index)) {
            b_index = MAX_int32_T;
          } else {
            b_index += Npad;
          }
          if (b_index <= 2147483646) {
            b_index++;
          }
          xv.data[kk] = x.data[b_index - 1];
        }
      }
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_CWTsingle_kernel12(
    const emxArray_real32_T xv, int32_T b_xv, emxArray_creal32_T xdft)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_xv);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T jj;
    jj = static_cast<int32_T>(idx);
    xdft.data[jj].re = xv.data[jj];
    xdft.data[jj].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_CWTsingle_kernel13(
    const emxArray_creal32_T xdft, const int32_T Nfilt, int32_T M,
    const int32_T cfsdft_dim0, const int32_T psidft_dim0,
    emxArray_real32_T b_psidft, emxArray_creal32_T cfsdft)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(Nfilt - 1) + 1UL) *
                (static_cast<uint64_T>(M) + 1UL) -
            1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T jj;
    int32_T kk;
    jj = static_cast<int32_T>(idx % (static_cast<uint64_T>(Nfilt - 1) + 1UL));
    kk = static_cast<int32_T>((idx - static_cast<uint64_T>(jj)) /
                              (static_cast<uint64_T>(Nfilt - 1) + 1UL));
    cfsdft.data[kk + cfsdft_dim0 * jj].re =
        b_psidft.data[kk + psidft_dim0 * jj] * xdft.data[jj].re;
    cfsdft.data[kk + cfsdft_dim0 * jj].im =
        b_psidft.data[kk + psidft_dim0 * jj] * xdft.data[jj].im;
  }
}

static __global__ __launch_bounds__(32, 1) void ec_CWTsingle_kernel14(
    const int32_T cfsdft_dim1, creal32_T *cfsdft)
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    cfsdft->re = static_cast<real32_T>(cfsdft_dim1);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_CWTsingle_kernel15(
    const creal32_T *cfsdft, const emxArray_creal32_T b_cfsdft,
    int32_T c_cfsdft, emxArray_creal32_T cfstmp)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(c_cfsdft);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T jj;
    real32_T ai;
    real32_T ar;
    jj = static_cast<int32_T>(idx);
    ar = b_cfsdft.data[jj].re;
    ai = b_cfsdft.data[jj].im;
    if (ai == 0.0F) {
      cfstmp.data[jj].re = ar / cfsdft->re;
      cfstmp.data[jj].im = 0.0F;
    } else if (ar == 0.0F) {
      cfstmp.data[jj].re = 0.0F;
      cfstmp.data[jj].im = ai / cfsdft->re;
    } else {
      cfstmp.data[jj].re = ar / cfsdft->re;
      cfstmp.data[jj].im = ai / cfsdft->re;
    }
  }
}

static __global__ __launch_bounds__(32, 1) void ec_CWTsingle_kernel16(
    const int32_T cfsdft_dim1, uint32_T xSize[2])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    xSize[1] = static_cast<uint32_T>(cfsdft_dim1);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_CWTsingle_kernel17(
    int32_T xSize, emxArray_creal32_T cfstmp)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(xSize);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T jj;
    jj = static_cast<int32_T>(idx);
    cfstmp.data[jj].re = 0.0F;
    cfstmp.data[jj].im = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_CWTsingle_kernel18(
    const emxArray_creal32_T cfstmp, const int32_T Norig, int32_T Ns,
    const int32_T cfs_dim0, const int32_T cfstmp_dim0, emxArray_creal32_T cfs)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(Norig - 1) + 1UL) *
                (static_cast<uint64_T>(Ns) + 1UL) -
            1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T b_index;
    int32_T jj;
    jj = static_cast<int32_T>(idx % (static_cast<uint64_T>(Norig - 1) + 1UL));
    b_index = static_cast<int32_T>((idx - static_cast<uint64_T>(jj)) /
                                   (static_cast<uint64_T>(Norig - 1) + 1UL));
    cfs.data[b_index + cfs_dim0 * jj] = cfstmp.data[b_index + cfstmp_dim0 * jj];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_CWTsingle_kernel19(
    const emxArray_creal32_T cfstmp, const int32_T Npad, const int32_T Norig,
    int32_T Ns, const int32_T cfs_dim0, const int32_T cfstmp_dim0,
    emxArray_creal32_T cfs)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = (static_cast<uint64_T>(Norig - 1) + 1UL) *
                (static_cast<uint64_T>(Ns) + 1UL) -
            1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T b_index;
    int32_T jj;
    jj = static_cast<int32_T>(idx % (static_cast<uint64_T>(Norig - 1) + 1UL));
    b_index = static_cast<int32_T>((idx - static_cast<uint64_T>(jj)) /
                                   (static_cast<uint64_T>(Norig - 1) + 1UL));
    jj = (Npad + jj) + 1;
    cfs.data[b_index + cfs_dim0 * ((jj - Npad) - 1)] =
        cfstmp.data[b_index + cfstmp_dim0 * (jj - 1)];
  }
}

static __global__
    __launch_bounds__(32, 1) void ec_CWTsingle_kernel2(const real_T maxscale,
                                                       real_T freqLims[2])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    freqLims[0] = maxscale;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_CWTsingle_kernel20(
    const real32_T maxwavcf, const real_T maxscale, const boolean_T IsOdd,
    const int32_T M, const int32_T Norig, emxArray_real_T coi)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(Norig - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    real_T d;
    int32_T b_index;
    int32_T kk;
    kk = static_cast<int32_T>(idx);
    b_index = 0;
    if (kk + 1 <= M) {
      b_index = kk + 1;
    } else if ((kk == M) && (!IsOdd)) {
      b_index = M;
    } else if ((kk + 1 > M) && IsOdd) {
      b_index = Norig - kk;
    } else if ((kk > M) && (!IsOdd)) {
      b_index = Norig - kk;
    }
    d = 1.0 / (0.60690379849267206 * maxscale * static_cast<real_T>(b_index));
    coi.data[kk] = d;
    if (d > maxwavcf) {
      coi.data[kk] = maxwavcf;
    }
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_CWTsingle_kernel21(
    const emxArray_real_T coi, int32_T b_coi, emxArray_real32_T c_coi)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_coi);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T jj;
    jj = static_cast<int32_T>(idx);
    c_coi.data[jj] = static_cast<real32_T>(coi.data[jj]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_CWTsingle_kernel22(
    int32_T b_cf, emxArray_real32_T c_cf, emxArray_real32_T freqs)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_cf);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T jj;
    jj = static_cast<int32_T>(idx);
    freqs.data[jj] = c_cf.data[jj];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_CWTsingle_kernel23(
    const emxArray_creal32_T cfs, int32_T N, emxArray_real32_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(N);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T b_index;
    b_index = static_cast<int32_T>(idx);
    y.data[b_index] = hypotf(cfs.data[b_index].re, cfs.data[b_index].im);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_CWTsingle_kernel24(
    const emxArray_real32_T y, const int32_T b_y, int32_T c_y,
    const int32_T wt_dim0, const int32_T y_dim0, emxArray_real32_T wt)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(b_y) + 1UL) * (static_cast<uint64_T>(c_y) + 1UL) -
      1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T b_index;
    int32_T jj;
    b_index = static_cast<int32_T>(idx % (static_cast<uint64_T>(b_y) + 1UL));
    jj = static_cast<int32_T>((idx - static_cast<uint64_T>(b_index)) /
                              (static_cast<uint64_T>(b_y) + 1UL));
    wt.data[b_index + wt_dim0 * jj] = y.data[jj + y_dim0 * b_index];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_CWTsingle_kernel25(
    const emxArray_real32_T wt, int32_T M, emxArray_real32_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(M);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T b_index;
    b_index = static_cast<int32_T>(idx);
    y.data[b_index] = wt.data[b_index];
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_CWTsingle_kernel26(
    const emxArray_real32_T wt, const int32_T N, int32_T M, emxArray_real32_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(M);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T b_index;
    b_index = static_cast<int32_T>(idx);
    y.data[b_index] += wt.data[N + b_index];
  }
}

static __global__
    __launch_bounds__(1024, 1) void ec_CWTsingle_kernel27(int32_T xSize,
                                                          emxArray_real32_T y)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(xSize);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T jj;
    jj = static_cast<int32_T>(idx);
    y.data[jj] = 0.0F;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_CWTsingle_kernel28(
    const real32_T maxwavcf, const emxArray_real32_T y, int32_T b_y,
    emxArray_real32_T wt)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_y);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T jj;
    jj = static_cast<int32_T>(idx);
    wt.data[jj] = y.data[jj] / maxwavcf;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_CWTsingle_kernel29(
    const emxArray_real32_T wt, int32_T b_wt, emxArray_real32_T c_wt)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b_wt);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T jj;
    jj = static_cast<int32_T>(idx);
    c_wt.data[jj] = wt.data[jj];
  }
}

static __global__
    __launch_bounds__(32, 1) void ec_CWTsingle_kernel3(const real_T fs,
                                                       real_T freqLims[2])
{
  uint64_T threadId;
  int32_T tmpIdx;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  tmpIdx = static_cast<int32_T>(threadId);
  if (tmpIdx < 1) {
    freqLims[1] = fs / 2.0;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_CWTsingle_kernel4(
    const int32_T N, const real_T maxscale, const int32_T M,
    emxArray_real_T omega)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(M);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T b_index;
    int32_T kk;
    kk = static_cast<int32_T>(idx);
    omega.data[kk] = static_cast<real_T>(kk) * maxscale;
    b_index = kk + M;
    if (b_index > 2147483645) {
      b_index = MAX_int32_T;
    } else {
      b_index += 2;
    }
    if (b_index <= N) {
      b_index = kk + M;
      if (b_index > 2147483645) {
        b_index = MAX_int32_T;
      } else {
        b_index += 2;
      }
      omega.data[b_index - 1] = 0.0;
    }
  }
}

static __global__
    __launch_bounds__(32, 1) void ec_CWTsingle_kernel5(const real_T freqLims[2],
                                                       boolean_T b[2])
{
  uint64_T threadId;
  int32_T jj;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  jj = static_cast<int32_T>(threadId);
  if (jj < 2) {
    b[jj] = isnan(freqLims[jj]);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_CWTsingle_kernel6(
    const real_T a0, int32_T Ns, emxArray_real_T scales)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(Ns - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T kk;
    kk = static_cast<int32_T>(idx);
    scales.data[kk] =
        0.68998891650046823 * pow(a0, (static_cast<real_T>(kk) + 1.0) - 1.0);
  }
}

static __global__
    __launch_bounds__(32, 1) void ec_CWTsingle_kernel7(const real_T fs,
                                                       real_T freqLims[2])
{
  uint64_T threadId;
  int32_T jj;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  jj = static_cast<int32_T>(threadId);
  if (jj < 2) {
    freqLims[jj] = freqLims[jj] / fs * 2.0 * 3.1415926535897931;
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_CWTsingle_kernel8(
    const real_T a0, const real_T s0, int32_T Ns, emxArray_real_T scales)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(Ns - 1);
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T kk;
    kk = static_cast<int32_T>(idx);
    scales.data[kk] = s0 * pow(a0, (static_cast<real_T>(kk) + 1.0) - 1.0);
  }
}

static __global__ __launch_bounds__(1024, 1) void ec_CWTsingle_kernel9(
    const real_T fs, const emxArray_real_T omega, const emxArray_real_T scales,
    const int32_T M, const int32_T N, int32_T Ns, const int32_T psidft_dim0,
    emxArray_real32_T b_cf, emxArray_real32_T b_psidft)
{
  uint64_T loopEnd;
  uint64_T threadId;
  uint64_T threadStride;
  threadId = static_cast<uint64_T>(mwGetGlobalThreadIndexInXDimension());
  threadStride = mwGetTotalThreadsLaunched();
  loopEnd =
      (static_cast<uint64_T>(N - 1) + 1UL) * (static_cast<uint64_T>(Ns) + 1UL) -
      1UL;
  for (uint64_T idx{threadId}; idx <= loopEnd; idx += threadStride) {
    int32_T jj;
    int32_T kk;
    jj = static_cast<int32_T>(idx % (static_cast<uint64_T>(N - 1) + 1UL));
    kk = static_cast<int32_T>((idx - static_cast<uint64_T>(jj)) /
                              (static_cast<uint64_T>(N - 1) + 1UL));
    if (jj + 1 > M) {
      b_psidft.data[kk + psidft_dim0 * jj] = 0.0F;
    } else {
      real_T d;
      real_T d1;
      d = scales.data[kk];
      d1 = omega.data[jj];
      b_psidft.data[kk + psidft_dim0 * jj] = static_cast<real32_T>(
          0.0050536085896138571 * exp(20.0 * log(d * d1) - pow(d * d1, 3.0)));
    }
    if (jj + 1 == 1) {
      b_cf.data[kk] = static_cast<real32_T>(
          1.8820720577620569 / scales.data[kk] / 6.2831853071795862 * fs);
    }
  }
}

static void emlrt_marshallIn(const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             emxArray_char_T *y)
{
  b_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void emlrt_marshallIn(const mxArray *tmpStr, const char_T *identifier,
                             emxArray_char_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  emlrt_marshallIn(emlrtAlias(tmpStr), &thisId, y);
  emlrtDestroyArray(&tmpStr);
}

static const mxArray *feval(const mxArray *m1, const mxArray *m2,
                            const mxArray *m3, emlrtMCInfo *location)
{
  const mxArray *pArrays[3];
  const mxArray *m;
  pArrays[0] = m1;
  pArrays[1] = m2;
  pArrays[2] = m3;
  return emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 1, &m, 3, &pArrays[0],
                               "feval", true, location);
}

static void gpuEmxEnsureCapacity_creal32_T(const emxArray_creal32_T *cpu,
                                           emxArray_creal32_T *gpu)
{
  creal32_T *newData;
  if (gpu->data == 0) {
    newData = 0UL;
    mwCudaMalloc(&newData, static_cast<uint64_T>(
                               static_cast<uint32_T>(cpu->allocatedSize) *
                               sizeof(creal32_T)));
    gpu->numDimensions = cpu->numDimensions;
    gpu->size = static_cast<int32_T *>(emlrtCallocMex(
        static_cast<uint32_T>(gpu->numDimensions), sizeof(int32_T)));
    for (int32_T i{0}; i < cpu->numDimensions; i++) {
      gpu->size[i] = cpu->size[i];
    }
    gpu->allocatedSize = cpu->allocatedSize;
    gpu->canFreeData = true;
    gpu->data = newData;
  } else {
    int32_T actualSizeCpu;
    int32_T actualSizeGpu;
    actualSizeCpu = 1;
    actualSizeGpu = 1;
    for (int32_T i{0}; i < cpu->numDimensions; i++) {
      actualSizeGpu *= gpu->size[i];
      actualSizeCpu *= cpu->size[i];
      gpu->size[i] = cpu->size[i];
    }
    if (gpu->allocatedSize < actualSizeCpu) {
      newData = 0UL;
      mwCudaMalloc(&newData, static_cast<uint64_T>(
                                 static_cast<uint32_T>(cpu->allocatedSize) *
                                 sizeof(creal32_T)));
      cudaMemcpy(newData, gpu->data,
                 static_cast<uint32_T>(actualSizeGpu) * sizeof(creal32_T),
                 cudaMemcpyDeviceToDevice);
      gpu->allocatedSize = cpu->allocatedSize;
      if (gpu->canFreeData) {
        mwCudaFree(gpu->data);
      }
      gpu->canFreeData = true;
      gpu->data = newData;
    }
  }
}

static void gpuEmxEnsureCapacity_real32_T(const emxArray_real32_T *cpu,
                                          emxArray_real32_T *gpu)
{
  real32_T *newData;
  if (gpu->data == 0) {
    newData = 0UL;
    mwCudaMalloc(&newData, static_cast<uint64_T>(
                               static_cast<uint32_T>(cpu->allocatedSize) *
                               sizeof(real32_T)));
    gpu->numDimensions = cpu->numDimensions;
    gpu->size = static_cast<int32_T *>(emlrtCallocMex(
        static_cast<uint32_T>(gpu->numDimensions), sizeof(int32_T)));
    for (int32_T i{0}; i < cpu->numDimensions; i++) {
      gpu->size[i] = cpu->size[i];
    }
    gpu->allocatedSize = cpu->allocatedSize;
    gpu->canFreeData = true;
    gpu->data = newData;
  } else {
    int32_T actualSizeCpu;
    int32_T actualSizeGpu;
    actualSizeCpu = 1;
    actualSizeGpu = 1;
    for (int32_T i{0}; i < cpu->numDimensions; i++) {
      actualSizeGpu *= gpu->size[i];
      actualSizeCpu *= cpu->size[i];
      gpu->size[i] = cpu->size[i];
    }
    if (gpu->allocatedSize < actualSizeCpu) {
      newData = 0UL;
      mwCudaMalloc(&newData, static_cast<uint64_T>(
                                 static_cast<uint32_T>(cpu->allocatedSize) *
                                 sizeof(real32_T)));
      cudaMemcpy(newData, gpu->data,
                 static_cast<uint32_T>(actualSizeGpu) * sizeof(real32_T),
                 cudaMemcpyDeviceToDevice);
      gpu->allocatedSize = cpu->allocatedSize;
      if (gpu->canFreeData) {
        mwCudaFree(gpu->data);
      }
      gpu->canFreeData = true;
      gpu->data = newData;
    }
  }
}

static void gpuEmxEnsureCapacity_real_T(const emxArray_real_T *cpu,
                                        emxArray_real_T *gpu)
{
  real_T *newData;
  if (gpu->data == 0) {
    newData = 0UL;
    mwCudaMalloc(&newData, static_cast<uint64_T>(
                               static_cast<uint32_T>(cpu->allocatedSize) *
                               sizeof(real_T)));
    gpu->numDimensions = cpu->numDimensions;
    gpu->size = static_cast<int32_T *>(emlrtCallocMex(
        static_cast<uint32_T>(gpu->numDimensions), sizeof(int32_T)));
    for (int32_T i{0}; i < cpu->numDimensions; i++) {
      gpu->size[i] = cpu->size[i];
    }
    gpu->allocatedSize = cpu->allocatedSize;
    gpu->canFreeData = true;
    gpu->data = newData;
  } else {
    int32_T actualSizeCpu;
    int32_T actualSizeGpu;
    actualSizeCpu = 1;
    actualSizeGpu = 1;
    for (int32_T i{0}; i < cpu->numDimensions; i++) {
      actualSizeGpu *= gpu->size[i];
      actualSizeCpu *= cpu->size[i];
      gpu->size[i] = cpu->size[i];
    }
    if (gpu->allocatedSize < actualSizeCpu) {
      newData = 0UL;
      mwCudaMalloc(&newData, static_cast<uint64_T>(
                                 static_cast<uint32_T>(cpu->allocatedSize) *
                                 sizeof(real_T)));
      cudaMemcpy(newData, gpu->data,
                 static_cast<uint32_T>(actualSizeGpu) * sizeof(real_T),
                 cudaMemcpyDeviceToDevice);
      gpu->allocatedSize = cpu->allocatedSize;
      if (gpu->canFreeData) {
        mwCudaFree(gpu->data);
      }
      gpu->canFreeData = true;
      gpu->data = newData;
    }
  }
}

static void gpuEmxFree_creal32_T(emxArray_creal32_T *gpu)
{
  if (gpu->data != (void *)4207599121UL) {
    mwCudaFree(gpu->data);
  }
  emlrtFreeMex(gpu->size);
}

static void gpuEmxFree_real32_T(emxArray_real32_T *gpu)
{
  if (gpu->data != (void *)4207599121UL) {
    mwCudaFree(gpu->data);
  }
  emlrtFreeMex(gpu->size);
}

static void gpuEmxFree_real_T(emxArray_real_T *gpu)
{
  if (gpu->data != (void *)4207599121UL) {
    mwCudaFree(gpu->data);
  }
  emlrtFreeMex(gpu->size);
}

static void gpuEmxMemcpyCpuToGpu_creal32_T(emxArray_creal32_T *gpu,
                                           const emxArray_creal32_T *cpu)
{
  int32_T actualSize;
  int32_T i;
  if (gpu->numDimensions < cpu->numDimensions) {
    gpu->numDimensions = cpu->numDimensions;
    emlrtFreeMex(gpu->size);
    gpu->size = static_cast<int32_T *>(emlrtCallocMex(
        static_cast<uint32_T>(gpu->numDimensions), sizeof(int32_T)));
  } else {
    gpu->numDimensions = cpu->numDimensions;
  }
  actualSize = 1;
  for (i = 0; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
    gpu->size[i] = cpu->size[i];
  }
  if (gpu->allocatedSize < actualSize) {
    if (gpu->canFreeData) {
      mwCudaFree(gpu->data);
    }
    i = cpu->allocatedSize;
    if (i < actualSize) {
      i = actualSize;
    }
    gpu->allocatedSize = i;
    gpu->canFreeData = true;
    mwCudaMalloc(&gpu->data, static_cast<uint64_T>(
                                 static_cast<uint32_T>(gpu->allocatedSize) *
                                 sizeof(creal32_T)));
  }
  cudaMemcpy(gpu->data, cpu->data,
             static_cast<uint32_T>(actualSize) * sizeof(creal32_T),
             cudaMemcpyHostToDevice);
}

static void gpuEmxMemcpyCpuToGpu_real32_T(emxArray_real32_T *gpu,
                                          const emxArray_real32_T *cpu)
{
  int32_T actualSize;
  int32_T i;
  if (gpu->numDimensions < cpu->numDimensions) {
    gpu->numDimensions = cpu->numDimensions;
    emlrtFreeMex(gpu->size);
    gpu->size = static_cast<int32_T *>(emlrtCallocMex(
        static_cast<uint32_T>(gpu->numDimensions), sizeof(int32_T)));
  } else {
    gpu->numDimensions = cpu->numDimensions;
  }
  actualSize = 1;
  for (i = 0; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
    gpu->size[i] = cpu->size[i];
  }
  if (gpu->allocatedSize < actualSize) {
    if (gpu->canFreeData) {
      mwCudaFree(gpu->data);
    }
    i = cpu->allocatedSize;
    if (i < actualSize) {
      i = actualSize;
    }
    gpu->allocatedSize = i;
    gpu->canFreeData = true;
    mwCudaMalloc(&gpu->data, static_cast<uint64_T>(
                                 static_cast<uint32_T>(gpu->allocatedSize) *
                                 sizeof(real32_T)));
  }
  cudaMemcpy(gpu->data, cpu->data,
             static_cast<uint32_T>(actualSize) * sizeof(real32_T),
             cudaMemcpyHostToDevice);
}

static void gpuEmxMemcpyGpuToCpu_creal32_T(emxArray_creal32_T *cpu,
                                           emxArray_creal32_T *gpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }
  cudaMemcpy(cpu->data, gpu->data,
             static_cast<uint32_T>(actualSize) * sizeof(creal32_T),
             cudaMemcpyDeviceToHost);
}

static void gpuEmxMemcpyGpuToCpu_real32_T(emxArray_real32_T *cpu,
                                          emxArray_real32_T *gpu)
{
  int32_T actualSize;
  actualSize = 1;
  for (int32_T i{0}; i < cpu->numDimensions; i++) {
    actualSize *= cpu->size[i];
  }
  cudaMemcpy(cpu->data, gpu->data,
             static_cast<uint32_T>(actualSize) * sizeof(real32_T),
             cudaMemcpyDeviceToHost);
}

static void gpuEmxReset_creal32_T(emxArray_creal32_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_creal32_T));
}

static void gpuEmxReset_real32_T(emxArray_real32_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_real32_T));
}

static void gpuEmxReset_real_T(emxArray_real_T *gpu)
{
  std::memset(gpu, 0, sizeof(emxArray_real_T));
}

static const mxArray *length(const mxArray *m1, emlrtMCInfo *location)
{
  const mxArray *m;
  const mxArray *pArray;
  pArray = m1;
  return emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 1, &m, 1, &pArray, "length",
                               true, location);
}

static real_T rt_powd_snf(real_T u0, real_T u1)
{
  real_T y;
  if (std::isnan(u0) || std::isnan(u1)) {
    y = rtNaN;
  } else {
    real_T b;
    real_T c;
    b = std::abs(u0);
    c = std::abs(u1);
    if (std::isinf(u1)) {
      if (b == 1.0) {
        y = 1.0;
      } else if (b > 1.0) {
        if (u1 > 0.0) {
          y = rtInf;
        } else {
          y = 0.0;
        }
      } else if (u1 > 0.0) {
        y = 0.0;
      } else {
        y = rtInf;
      }
    } else if (c == 0.0) {
      y = 1.0;
    } else if (c == 1.0) {
      if (u1 > 0.0) {
        y = u0;
      } else {
        y = 1.0 / u0;
      }
    } else if (u1 == 2.0) {
      y = u0 * u0;
    } else if ((u1 == 0.5) && (u0 >= 0.0)) {
      y = std::sqrt(u0);
    } else if ((u0 < 0.0) && (u1 > std::floor(u1))) {
      y = rtNaN;
    } else {
      y = std::pow(u0, u1);
    }
  }
  return y;
}

void ec_CWTsingle(const emxArray_real32_T *x, real_T fs, real_T freqLims[2],
                  boolean_T doAvg, real_T freqsPerOctave, emxArray_real32_T *wt,
                  emxArray_real32_T *freqs, emxArray_real32_T *coi)
{
  static const int32_T iv[2]{1, 7};
  static const int32_T iv1[2]{1, 5};
  static const char_T u[7]{'s', 'p', 'r', 'i', 'n', 't', 'f'};
  static const char_T formatSpec[5]{'%', '2', '.', '2', 'f'};
  dim3 block;
  dim3 grid;
  emxArray_char_T *b_tmpStr;
  emxArray_creal32_T gpu_cfs;
  emxArray_creal32_T gpu_cfsdft;
  emxArray_creal32_T gpu_cfstmp;
  emxArray_creal32_T gpu_xdft;
  emxArray_creal32_T *cfs;
  emxArray_creal32_T *cfsdft;
  emxArray_creal32_T *cfstmp;
  emxArray_creal32_T *xdft;
  emxArray_real32_T b_gpu_coi;
  emxArray_real32_T b_gpu_wt;
  emxArray_real32_T b_gpu_y;
  emxArray_real32_T gpu_cf;
  emxArray_real32_T gpu_freqs;
  emxArray_real32_T gpu_psidft;
  emxArray_real32_T gpu_wt;
  emxArray_real32_T gpu_x;
  emxArray_real32_T gpu_xv;
  emxArray_real32_T gpu_y;
  emxArray_real32_T *b_wt;
  emxArray_real32_T *d_y;
  emxArray_real32_T *e_y;
  emxArray_real32_T *xv;
  emxArray_real_T gpu_coi;
  emxArray_real_T gpu_omega;
  emxArray_real_T gpu_scales;
  emxArray_real_T *b_coi;
  emxArray_real_T *omega;
  emxArray_real_T *scales;
  const mxArray *b_y;
  const mxArray *c_y;
  const mxArray *m;
  const mxArray *tmpStr;
  const mxArray *y;
  creal32_T *b_gpu_cfsdft;
  real_T(*gpu_freqLims)[2];
  int32_T M;
  int32_T N;
  int32_T Nfilt;
  int32_T Norig;
  int32_T Npad;
  int32_T Ns;
  int32_T k;
  real32_T maxwavcf;
  uint32_T xSize[2];
  uint32_T(*gpu_xSize)[2];
  boolean_T b[2];
  boolean_T(*gpu_b)[2];
  boolean_T IsOdd;
  boolean_T b_dirtyOnGpu;
  boolean_T coi_dirtyOnGpu;
  boolean_T freqs_dirtyOnGpu;
  boolean_T wt_dirtyOnCpu;
  boolean_T wt_dirtyOnGpu;
  boolean_T xSize_dirtyOnCpu;
  boolean_T xdft_dirtyOnCpu;
  gpuEmxReset_real32_T(&b_gpu_wt);
  gpuEmxReset_real32_T(&b_gpu_y);
  gpuEmxReset_real32_T(&gpu_wt);
  gpuEmxReset_real32_T(&gpu_y);
  gpuEmxReset_real32_T(&gpu_freqs);
  gpuEmxReset_real32_T(&b_gpu_coi);
  gpuEmxReset_real_T(&gpu_coi);
  gpuEmxReset_real32_T(&gpu_cf);
  gpuEmxReset_creal32_T(&gpu_cfs);
  gpuEmxReset_real_T(&gpu_scales);
  gpuEmxReset_creal32_T(&gpu_cfstmp);
  mwCudaMalloc(&b_gpu_cfsdft, 8UL);
  mwCudaMalloc(&gpu_xSize, 8UL);
  gpuEmxReset_creal32_T(&gpu_cfsdft);
  gpuEmxReset_real32_T(&gpu_psidft);
  gpuEmxReset_creal32_T(&gpu_xdft);
  gpuEmxReset_real_T(&gpu_omega);
  gpuEmxReset_real32_T(&gpu_xv);
  gpuEmxReset_real32_T(&gpu_x);
  mwCudaMalloc(&gpu_b, 2UL);
  mwCudaMalloc(&gpu_freqLims, 16UL);
  xSize_dirtyOnCpu = false;
  xdft_dirtyOnCpu = false;
  wt_dirtyOnGpu = false;
  wt_dirtyOnCpu = true;
  freqs_dirtyOnGpu = false;
  coi_dirtyOnGpu = false;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  //  Input validation
  if ((!(fs != 0.0)) || (fs < 1.0)) {
    fs = 1000.0;
  }
  if (freqLims[0] <= 0.0) {
    freqLims[0] = 1.0;
  }
  if (freqLims[1] > fs / 2.0) {
    freqLims[1] = fs / 2.0;
  }
  //  Initialize
  //  Add kernelfun pragma to trigger kernel creation
  if (!psidft_not_empty) {
    real_T maxscale;
    real_T s0;
    boolean_T exitg1;
    N = static_cast<int32_T>(std::trunc(static_cast<real_T>(x->size[0]) / 2.0));
    cudaMemcpy(*gpu_freqLims, freqLims, 16UL, cudaMemcpyHostToDevice);
    ec_CWTsingle_kernel1<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_freqLims,
                                                                  *gpu_b);
    b_dirtyOnGpu = true;
    IsOdd = true;
    k = 0;
    exitg1 = false;
    while ((!exitg1) && (k <= 1)) {
      if (b_dirtyOnGpu) {
        cudaMemcpy(b, *gpu_b, 2UL, cudaMemcpyDeviceToHost);
      }
      b_dirtyOnGpu = false;
      if (!b[k]) {
        IsOdd = false;
        exitg1 = true;
      } else {
        k++;
      }
    }
    if (!IsOdd) {
      maxscale = static_cast<real_T>(x->size[0]) / 11.001547073884861;
      if (maxscale <
          0.68998891650046823 * rt_powd_snf(2.0, 1.0 / freqsPerOctave)) {
        maxscale = 0.68998891650046823 * rt_powd_snf(2.0, 1.0 / freqsPerOctave);
      }
      maxscale = 1.0 / (maxscale * 3.3384403542183319) * fs;
      if (freqLims[0] < maxscale) {
        ec_CWTsingle_kernel2<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
            maxscale, *gpu_freqLims);
        cudaMemcpy(freqLims, *gpu_freqLims, 16UL, cudaMemcpyDeviceToHost);
      }
      if (freqLims[1] > fs / 2.0) {
        ec_CWTsingle_kernel3<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
            fs, *gpu_freqLims);
        cudaMemcpy(freqLims, *gpu_freqLims, 16UL, cudaMemcpyDeviceToHost);
      }
      if (freqLims[1] == 0.0) {
        s0 = rtMinusInf;
      } else if (freqLims[1] < 0.0) {
        s0 = rtNaN;
      } else if ((!std::isinf(freqLims[1])) && (!std::isnan(freqLims[1]))) {
        maxscale = std::frexp(freqLims[1], &M);
        if (maxscale == 0.5) {
          s0 = static_cast<real_T>(M) - 1.0;
        } else if ((M == 1) && (maxscale < 0.75)) {
          s0 = std::log(2.0 * maxscale) / 0.69314718055994529;
        } else {
          s0 =
              std::log(maxscale) / 0.69314718055994529 + static_cast<real_T>(M);
        }
      } else {
        s0 = freqLims[1];
      }
      if ((!std::isinf(freqLims[0])) && (!std::isnan(freqLims[0]))) {
        maxscale = std::frexp(freqLims[0], &Nfilt);
        if (maxscale == 0.5) {
          maxscale = static_cast<real_T>(Nfilt) - 1.0;
        } else if ((Nfilt == 1) && (maxscale < 0.75)) {
          maxscale = std::log(2.0 * maxscale) / 0.69314718055994529;
        } else {
          maxscale = std::log(maxscale) / 0.69314718055994529 +
                     static_cast<real_T>(Nfilt);
        }
      } else {
        maxscale = freqLims[0];
      }
      if (!(s0 - maxscale >= 1.0 / freqsPerOctave)) {
        tmpStr = nullptr;
        y = nullptr;
        m = emlrtCreateCharArray(2, &iv[0]);
        emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m, &u[0]);
        emlrtAssign(&y, m);
        b_y = nullptr;
        m = emlrtCreateCharArray(2, &iv1[0]);
        emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 5, m, &formatSpec[0]);
        emlrtAssign(&b_y, m);
        c_y = nullptr;
        m = emlrtCreateDoubleScalar(1.0 / freqsPerOctave);
        emlrtAssign(&c_y, m);
        emlrtAssign(&tmpStr, feval(y, b_y, c_y, &emlrtMCI));
        emlrt_marshallIn(length(emlrtAlias(tmpStr), &b_emlrtMCI),
                         "<output of length>");
        emxInit_char_T(&b_tmpStr, 2, &q_emlrtRTEI, true);
        emlrt_marshallIn(emlrtAlias(tmpStr), "tmpStr", b_tmpStr);
        emxFree_char_T(&b_tmpStr);
        emlrtDestroyArray(&tmpStr);
      }
    }
    if (x->size[0] > 100000) {
      maxscale = std::frexp(static_cast<real_T>(x->size[0]), &Npad);
      if (maxscale == 0.5) {
        maxscale = static_cast<real_T>(Npad) - 1.0;
      } else {
        maxscale = std::log(maxscale) / 0.69314718055994529 +
                   static_cast<real_T>(Npad);
      }
      maxscale = std::ceil(maxscale);
      N = static_cast<int32_T>(maxscale);
    }
    N <<= 1;
    if ((x->size[0] > 0) && (N > MAX_int32_T - x->size[0])) {
      N = MAX_int32_T;
    } else {
      N += x->size[0];
    }
    M = static_cast<int32_T>(std::trunc(static_cast<real_T>(N) / 2.0));
    emxInit_real_T(&omega, 2, &r_emlrtRTEI, true);
    k = omega->size[0] * omega->size[1];
    omega->size[0] = 1;
    omega->size[1] = N;
    emxEnsureCapacity_real_T(omega, k, &e_emlrtRTEI);
    gpuEmxEnsureCapacity_real_T(omega, &gpu_omega);
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(M + 1L), &grid,
                                           &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      ec_CWTsingle_kernel4<<<grid, block>>>(
          N, 6.2831853071795862 / static_cast<real_T>(N), M, gpu_omega);
    }
    ec_CWTsingle_kernel5<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(*gpu_freqLims,
                                                                  *gpu_b);
    b_dirtyOnGpu = true;
    IsOdd = true;
    k = 0;
    exitg1 = false;
    while ((!exitg1) && (k <= 1)) {
      if (b_dirtyOnGpu) {
        cudaMemcpy(b, *gpu_b, 2UL, cudaMemcpyDeviceToHost);
      }
      b_dirtyOnGpu = false;
      if (!b[k]) {
        IsOdd = false;
        exitg1 = true;
      } else {
        k++;
      }
    }
    emxInit_real_T(&scales, 2, &s_emlrtRTEI, true);
    if (!IsOdd) {
      ec_CWTsingle_kernel7<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
          fs, *gpu_freqLims);
      cudaMemcpy(freqLims, *gpu_freqLims, 16UL, cudaMemcpyDeviceToHost);
      s0 = 1.8820720577620569 / freqLims[1];
      maxscale = 1.8820720577620569 / freqLims[0] / s0;
      if (maxscale == 0.0) {
        maxscale = rtMinusInf;
      } else if (maxscale < 0.0) {
        maxscale = rtNaN;
      } else if ((!std::isinf(maxscale)) && (!std::isnan(maxscale))) {
        maxscale = std::frexp(maxscale, &Ns);
        if (maxscale == 0.5) {
          maxscale = static_cast<real_T>(Ns) - 1.0;
        } else if ((Ns == 1) && (maxscale < 0.75)) {
          maxscale = std::log(2.0 * maxscale) / 0.69314718055994529;
        } else {
          maxscale = std::log(maxscale) / 0.69314718055994529 +
                     static_cast<real_T>(Ns);
        }
      }
      maxscale = std::floor(freqsPerOctave * maxscale);
      if (maxscale < 2.147483648E+9) {
        if (maxscale >= -2.147483648E+9) {
          N = static_cast<int32_T>(maxscale);
        } else {
          N = MIN_int32_T;
        }
      } else if (maxscale >= 2.147483648E+9) {
        N = MAX_int32_T;
      } else {
        N = 0;
      }
      if (N > 2147483646) {
        Ns = MAX_int32_T;
      } else {
        Ns = N + 1;
      }
      k = scales->size[0] * scales->size[1];
      scales->size[0] = 1;
      scales->size[1] = Ns;
      emxEnsureCapacity_real_T(scales, k, &h_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(scales, &gpu_scales);
      b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>((Ns - 1) + 1L),
                                             &grid, &block, 1024U, 65535U);
      if (b_dirtyOnGpu) {
        ec_CWTsingle_kernel8<<<grid, block>>>(
            rt_powd_snf(2.0, 1.0 / freqsPerOctave), s0, Ns, gpu_scales);
      }
    } else {
      maxscale = static_cast<real_T>(x->size[0]) / 11.001547073884861;
      if (maxscale <
          0.68998891650046823 * rt_powd_snf(2.0, 1.0 / freqsPerOctave)) {
        maxscale = 0.68998891650046823 * rt_powd_snf(2.0, 1.0 / freqsPerOctave);
      }
      maxscale /= 0.68998891650046823;
      if (maxscale == 0.0) {
        maxscale = rtMinusInf;
      } else if ((!std::isinf(maxscale)) && (!std::isnan(maxscale))) {
        maxscale = std::frexp(maxscale, &Ns);
        if (maxscale == 0.5) {
          maxscale = static_cast<real_T>(Ns) - 1.0;
        } else if ((Ns == 1) && (maxscale < 0.75)) {
          maxscale = std::log(2.0 * maxscale) / 0.69314718055994529;
        } else {
          maxscale = std::log(maxscale) / 0.69314718055994529 +
                     static_cast<real_T>(Ns);
        }
      }
      maxscale = std::floor(std::fmax(maxscale, 1.0 / freqsPerOctave) *
                            freqsPerOctave);
      if (maxscale < 2.147483648E+9) {
        if (maxscale >= -2.147483648E+9) {
          N = static_cast<int32_T>(maxscale);
        } else {
          N = MIN_int32_T;
        }
      } else if (maxscale >= 2.147483648E+9) {
        N = MAX_int32_T;
      } else {
        N = 0;
      }
      if (N > 2147483646) {
        Ns = MAX_int32_T;
      } else {
        Ns = N + 1;
      }
      k = scales->size[0] * scales->size[1];
      scales->size[0] = 1;
      scales->size[1] = Ns;
      emxEnsureCapacity_real_T(scales, k, &g_emlrtRTEI);
      gpuEmxEnsureCapacity_real_T(scales, &gpu_scales);
      b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>((Ns - 1) + 1L),
                                             &grid, &block, 1024U, 65535U);
      if (b_dirtyOnGpu) {
        ec_CWTsingle_kernel6<<<grid, block>>>(
            rt_powd_snf(2.0, 1.0 / freqsPerOctave), Ns, gpu_scales);
      }
    }
    Ns = scales->size[1] - 1;
    N = omega->size[1];
    k = psidft->size[0] * psidft->size[1];
    psidft->size[0] = scales->size[1];
    psidft->size[1] = omega->size[1];
    emxEnsureCapacity_real32_T(psidft, k, &j_emlrtRTEI);
    k = cf->size[0];
    cf->size[0] = scales->size[1];
    emxEnsureCapacity_real32_T(cf, k, &j_emlrtRTEI);
    M = static_cast<int32_T>(
            std::trunc(static_cast<real_T>(omega->size[1]) / 2.0)) +
        1;
    k = psidft->size[0];
    b_dirtyOnGpu =
        mwGetLaunchParameters1D(static_cast<real_T>(((N - 1) + 1L) * (Ns + 1L)),
                                &grid, &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_psidft, psidft);
      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_cf, cf);
      ec_CWTsingle_kernel9<<<grid, block>>>(fs, gpu_omega, gpu_scales, M, N, Ns,
                                            k, gpu_cf, gpu_psidft);
      gpuEmxMemcpyGpuToCpu_real32_T(psidft, &gpu_psidft);
      gpuEmxMemcpyGpuToCpu_real32_T(cf, &gpu_cf);
    }
    emxFree_real_T(&scales);
    emxFree_real_T(&omega);
    psidft_not_empty = ((psidft->size[0] != 0) && (psidft->size[1] != 0));
  }
  Norig = x->size[0];
  Npad = static_cast<int32_T>(
      std::trunc(static_cast<real_T>(psidft->size[1] - x->size[0]) / 2.0));
  Ns = psidft->size[0] - 1;
  emxInit_real32_T(&xv, 2, &c_emlrtRTEI, true);
  k = xv->size[0] * xv->size[1];
  xv->size[0] = 1;
  xv->size[1] = psidft->size[1];
  emxEnsureCapacity_real32_T(xv, k, &c_emlrtRTEI);
  gpuEmxEnsureCapacity_real32_T(xv, &gpu_xv);
  emxInit_creal32_T(&cfs, 2, &q_emlrtRTEI, true);
  k = cfs->size[0] * cfs->size[1];
  cfs->size[0] = psidft->size[0];
  cfs->size[1] = x->size[0];
  emxEnsureCapacity_creal32_T(cfs, k, &c_emlrtRTEI);
  gpuEmxEnsureCapacity_creal32_T(cfs, &gpu_cfs);
  emxInit_creal32_T(&cfstmp, 2, &c_emlrtRTEI, true);
  N = xv->size[1] - 1;
  if (Npad > 0) {
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(N + 1L), &grid,
                                           &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_x, x);
      ec_CWTsingle_kernel11<<<grid, block>>>(gpu_x, Norig, Npad, N, gpu_xv);
    }
  } else {
    b_dirtyOnGpu = mwGetLaunchParameters1D(
        static_cast<real_T>((Norig - 1) + 1L), &grid, &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_x, x);
      ec_CWTsingle_kernel10<<<grid, block>>>(gpu_x, Norig, gpu_xv);
    }
  }
  emxInit_creal32_T(&xdft, 2, &d_emlrtRTEI, true);
  if (xv->size[1] == 0) {
    xdft->size[0] = 1;
    xdft->size[1] = 0;
  } else if (xv->size[1] -
                 (static_cast<int32_T>(static_cast<uint32_T>(xv->size[1]) >> 1)
                  << 1) ==
             1) {
    cufftHandle fftPlanHandle;
    k = xdft->size[0] * xdft->size[1];
    xdft->size[0] = 1;
    xdft->size[1] = xv->size[1];
    emxEnsureCapacity_creal32_T(xdft, k, &d_emlrtRTEI);
    gpuEmxEnsureCapacity_creal32_T(xdft, &gpu_xdft);
    N = xv->size[1] - 1;
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(N + 1L), &grid,
                                           &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      ec_CWTsingle_kernel12<<<grid, block>>>(gpu_xv, N, gpu_xdft);
    }
    N = xdft->size[1];
    fftPlanHandle = acquireCUFFTPlan(1, &N, &N, 1, 1, CUFFT_C2C, 1);
    cufftExecC2C(fftPlanHandle, (cufftComplex *)&gpu_xdft.data[0],
                 (cufftComplex *)&gpu_xdft.data[0], CUFFT_FORWARD);
  } else {
    N = xv->size[1];
    for (Nfilt = 0; Nfilt < 2; Nfilt++) {
      xSize[Nfilt] = static_cast<uint32_T>(xv->size[Nfilt]);
      xSize_dirtyOnCpu = true;
    }
    cufftHandle b_fftPlanHandle;
    k = xdft->size[0] * xdft->size[1];
    xdft->size[0] = 1;
    xdft->size[1] = static_cast<int32_T>(xSize[1]);
    emxEnsureCapacity_creal32_T(xdft, k, &f_emlrtRTEI);
    gpuEmxEnsureCapacity_creal32_T(xdft, &gpu_xdft);
    b_fftPlanHandle = acquireCUFFTPlan(1, &N, &N, 1, 1, CUFFT_R2C, 1);
    cufftExecR2C(b_fftPlanHandle, (cufftReal *)&gpu_xv.data[0],
                 (cufftComplex *)&gpu_xdft.data[0]);
    b_dirtyOnGpu = true;
    N = static_cast<int32_T>(
        static_cast<real_T>(static_cast<int32_T>(xSize[1]) + 1) / 2.0);
    for (Nfilt = 0; Nfilt <= N - 2; Nfilt++) {
      if (b_dirtyOnGpu) {
        gpuEmxMemcpyGpuToCpu_creal32_T(xdft, &gpu_xdft);
      }
      xdft->data[(static_cast<int32_T>(xSize[1]) - Nfilt) - 1].re =
          xdft->data[Nfilt + 1].re;
      xdft->data[(static_cast<int32_T>(xSize[1]) - Nfilt) - 1].im =
          -xdft->data[Nfilt + 1].im;
      b_dirtyOnGpu = false;
      xdft_dirtyOnCpu = true;
    }
  }
  emxFree_real32_T(&xv);
  M = psidft->size[0] - 1;
  Nfilt = psidft->size[1];
  emxInit_creal32_T(&cfsdft, 2, &d_emlrtRTEI, true);
  k = cfsdft->size[0] * cfsdft->size[1];
  cfsdft->size[0] = psidft->size[0];
  cfsdft->size[1] = psidft->size[1];
  emxEnsureCapacity_creal32_T(cfsdft, k, &d_emlrtRTEI);
  gpuEmxEnsureCapacity_creal32_T(cfsdft, &gpu_cfsdft);
  N = cfsdft->size[0];
  k = psidft->size[0];
  b_dirtyOnGpu = mwGetLaunchParameters1D(
      static_cast<real_T>(((Nfilt - 1) + 1L) * (M + 1L)), &grid, &block, 1024U,
      65535U);
  if (b_dirtyOnGpu) {
    if (xdft_dirtyOnCpu) {
      gpuEmxMemcpyCpuToGpu_creal32_T(&gpu_xdft, xdft);
    }
    gpuEmxMemcpyCpuToGpu_real32_T(&gpu_psidft, psidft);
    ec_CWTsingle_kernel13<<<grid, block>>>(gpu_xdft, Nfilt, M, N, k, gpu_psidft,
                                           gpu_cfsdft);
    gpuEmxMemcpyGpuToCpu_real32_T(psidft, &gpu_psidft);
  }
  emxFree_creal32_T(&xdft);
  if ((cfsdft->size[0] == 0) || (cfsdft->size[1] == 0)) {
    for (Nfilt = 0; Nfilt < 2; Nfilt++) {
      xSize[Nfilt] = static_cast<uint32_T>(cfsdft->size[Nfilt]);
      xSize_dirtyOnCpu = true;
    }
    N = cfsdft->size[1];
    if (xSize_dirtyOnCpu) {
      cudaMemcpy(*gpu_xSize, xSize, 8UL, cudaMemcpyHostToDevice);
    }
    ec_CWTsingle_kernel16<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(N,
                                                                   *gpu_xSize);
    k = cfstmp->size[0] * cfstmp->size[1];
    cudaMemcpy(xSize, *gpu_xSize, 8UL, cudaMemcpyDeviceToHost);
    cfstmp->size[0] = static_cast<int32_T>(xSize[0]);
    cfstmp->size[1] = cfsdft->size[1];
    emxEnsureCapacity_creal32_T(cfstmp, k, &c_emlrtRTEI);
    gpuEmxEnsureCapacity_creal32_T(cfstmp, &gpu_cfstmp);
    N = static_cast<int32_T>(xSize[0]) * static_cast<int32_T>(xSize[1]) - 1;
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(N + 1L), &grid,
                                           &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      ec_CWTsingle_kernel17<<<grid, block>>>(N, gpu_cfstmp);
    }
  } else {
    cufftHandle c_fftPlanHandle;
    N = cfsdft->size[1];
    c_fftPlanHandle = acquireCUFFTPlan(1, &N, &N, cfsdft->size[0], 1, CUFFT_C2C,
                                       cfsdft->size[0]);
    cufftExecC2C(c_fftPlanHandle, (cufftComplex *)&gpu_cfsdft.data[0],
                 (cufftComplex *)&gpu_cfsdft.data[0], CUFFT_INVERSE);
    k = cfstmp->size[0] * cfstmp->size[1];
    cfstmp->size[0] = cfsdft->size[0];
    cfstmp->size[1] = cfsdft->size[1];
    emxEnsureCapacity_creal32_T(cfstmp, k, &c_emlrtRTEI);
    gpuEmxEnsureCapacity_creal32_T(cfstmp, &gpu_cfstmp);
    N = cfsdft->size[1];
    ec_CWTsingle_kernel14<<<dim3(1U, 1U, 1U), dim3(32U, 1U, 1U)>>>(
        N, b_gpu_cfsdft);
    N = cfsdft->size[0] * cfsdft->size[1] - 1;
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(N + 1L), &grid,
                                           &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      ec_CWTsingle_kernel15<<<grid, block>>>(b_gpu_cfsdft, gpu_cfsdft, N,
                                             gpu_cfstmp);
    }
  }
  emxFree_creal32_T(&cfsdft);
  if (Npad > 0) {
    N = cfs->size[0];
    Nfilt = cfstmp->size[0];
    b_dirtyOnGpu = mwGetLaunchParameters1D(
        static_cast<real_T>(((Norig - 1) + 1L) * (Ns + 1L)), &grid, &block,
        1024U, 65535U);
    if (b_dirtyOnGpu) {
      ec_CWTsingle_kernel19<<<grid, block>>>(gpu_cfstmp, Npad, Norig, Ns, N,
                                             Nfilt, gpu_cfs);
    }
  } else {
    N = cfs->size[0];
    Nfilt = cfstmp->size[0];
    b_dirtyOnGpu = mwGetLaunchParameters1D(
        static_cast<real_T>(((Norig - 1) + 1L) * (Ns + 1L)), &grid, &block,
        1024U, 65535U);
    if (b_dirtyOnGpu) {
      ec_CWTsingle_kernel18<<<grid, block>>>(gpu_cfstmp, Norig, Ns, N, Nfilt,
                                             gpu_cfs);
    }
  }
  emxFree_creal32_T(&cfstmp);
  if (cf->size[0] == 0) {
    maxwavcf = rtNaNF;
  } else {
    Npad = cf->size[0];
    maxwavcf = cf->data[0];
    for (Nfilt = 0; Nfilt <= Npad - 2; Nfilt++) {
      if (std::isnan(cf->data[Nfilt + 1])) {
        IsOdd = false;
      } else if (std::isnan(maxwavcf)) {
        IsOdd = true;
      } else {
        IsOdd = (maxwavcf < cf->data[Nfilt + 1]);
      }
      if (IsOdd) {
        maxwavcf = cf->data[Nfilt + 1];
      }
    }
  }
  emxInit_real_T(&b_coi, 1, &c_emlrtRTEI, true);
  k = b_coi->size[0];
  b_coi->size[0] = x->size[0];
  emxEnsureCapacity_real_T(b_coi, k, &c_emlrtRTEI);
  gpuEmxEnsureCapacity_real_T(b_coi, &gpu_coi);
  IsOdd = (x->size[0] -
               (static_cast<int32_T>(static_cast<uint32_T>(x->size[0]) >> 1)
                << 1) ==
           1);
  M = static_cast<int32_T>(std::round(static_cast<real_T>(x->size[0]) / 2.0));
  b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>((Norig - 1) + 1L),
                                         &grid, &block, 1024U, 65535U);
  if (b_dirtyOnGpu) {
    ec_CWTsingle_kernel20<<<grid, block>>>(maxwavcf, 1.0 / fs, IsOdd, M, Norig,
                                           gpu_coi);
  }
  k = coi->size[0];
  coi->size[0] = b_coi->size[0];
  emxEnsureCapacity_real32_T(coi, k, &c_emlrtRTEI);
  N = b_coi->size[0] - 1;
  b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(N + 1L), &grid,
                                         &block, 1024U, 65535U);
  if (b_dirtyOnGpu) {
    gpuEmxMemcpyCpuToGpu_real32_T(&b_gpu_coi, coi);
    ec_CWTsingle_kernel21<<<grid, block>>>(gpu_coi, N, b_gpu_coi);
    coi_dirtyOnGpu = true;
  }
  emxFree_real_T(&b_coi);
  k = freqs->size[0];
  freqs->size[0] = cf->size[0];
  emxEnsureCapacity_real32_T(freqs, k, &i_emlrtRTEI);
  N = cf->size[0] - 1;
  b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(N + 1L), &grid,
                                         &block, 1024U, 65535U);
  if (b_dirtyOnGpu) {
    gpuEmxMemcpyCpuToGpu_real32_T(&gpu_freqs, freqs);
    gpuEmxMemcpyCpuToGpu_real32_T(&gpu_cf, cf);
    ec_CWTsingle_kernel22<<<grid, block>>>(N, gpu_cf, gpu_freqs);
    freqs_dirtyOnGpu = true;
    gpuEmxMemcpyGpuToCpu_real32_T(cf, &gpu_cf);
  }
  N = cfs->size[0] * cfs->size[1] - 1;
  for (Nfilt = 0; Nfilt < 2; Nfilt++) {
    xSize[Nfilt] = static_cast<uint32_T>(cfs->size[Nfilt]);
  }
  emxInit_real32_T(&d_y, 2, &t_emlrtRTEI, true);
  k = d_y->size[0] * d_y->size[1];
  d_y->size[0] = static_cast<int32_T>(xSize[0]);
  d_y->size[1] = static_cast<int32_T>(xSize[1]);
  emxEnsureCapacity_real32_T(d_y, k, &k_emlrtRTEI);
  gpuEmxEnsureCapacity_real32_T(d_y, &gpu_y);
  b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(N + 1L), &grid,
                                         &block, 1024U, 65535U);
  if (b_dirtyOnGpu) {
    ec_CWTsingle_kernel23<<<grid, block>>>(gpu_cfs, N, gpu_y);
  }
  emxFree_creal32_T(&cfs);
  k = wt->size[0] * wt->size[1];
  wt->size[0] = d_y->size[1];
  wt->size[1] = d_y->size[0];
  emxEnsureCapacity_real32_T(wt, k, &l_emlrtRTEI);
  N = d_y->size[0] - 1;
  Nfilt = d_y->size[1] - 1;
  k = wt->size[0];
  M = d_y->size[0];
  b_dirtyOnGpu =
      mwGetLaunchParameters1D(static_cast<real_T>((Nfilt + 1L) * (N + 1L)),
                              &grid, &block, 1024U, 65535U);
  if (b_dirtyOnGpu) {
    gpuEmxMemcpyCpuToGpu_real32_T(&gpu_wt, wt);
    ec_CWTsingle_kernel24<<<grid, block>>>(gpu_y, Nfilt, N, k, M, gpu_wt);
    wt_dirtyOnCpu = false;
    wt_dirtyOnGpu = true;
  }
  emxFree_real32_T(&d_y);
  if (doAvg) {
    emxInit_real32_T(&e_y, 1, &u_emlrtRTEI, true);
    Npad = wt->size[1];
    if (wt->size[1] == 0) {
      for (Nfilt = 0; Nfilt < 2; Nfilt++) {
        xSize[Nfilt] = static_cast<uint32_T>(wt->size[Nfilt]);
      }
      k = e_y->size[0];
      e_y->size[0] = static_cast<int32_T>(xSize[0]);
      emxEnsureCapacity_real32_T(e_y, k, &n_emlrtRTEI);
      gpuEmxEnsureCapacity_real32_T(e_y, &b_gpu_y);
      b_dirtyOnGpu = mwGetLaunchParameters1D(
          static_cast<real_T>((static_cast<int32_T>(xSize[0]) - 1) + 1L), &grid,
          &block, 1024U, 65535U);
      if (b_dirtyOnGpu) {
        ec_CWTsingle_kernel27<<<grid, block>>>(
            static_cast<int32_T>(xSize[0]) - 1, b_gpu_y);
      }
    } else {
      M = wt->size[0] - 1;
      k = e_y->size[0];
      e_y->size[0] = wt->size[0];
      emxEnsureCapacity_real32_T(e_y, k, &m_emlrtRTEI);
      gpuEmxEnsureCapacity_real32_T(e_y, &b_gpu_y);
      b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(M + 1L), &grid,
                                             &block, 1024U, 65535U);
      if (b_dirtyOnGpu) {
        if (wt_dirtyOnCpu) {
          gpuEmxMemcpyCpuToGpu_real32_T(&gpu_wt, wt);
        }
        wt_dirtyOnCpu = false;
        ec_CWTsingle_kernel25<<<grid, block>>>(gpu_wt, M, b_gpu_y);
      }
      for (k = 0; k <= Npad - 2; k++) {
        b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(M + 1L),
                                               &grid, &block, 1024U, 65535U);
        if (b_dirtyOnGpu) {
          if (wt_dirtyOnCpu) {
            gpuEmxMemcpyCpuToGpu_real32_T(&gpu_wt, wt);
          }
          wt_dirtyOnCpu = false;
          ec_CWTsingle_kernel26<<<grid, block>>>(gpu_wt, (k + 1) * (M + 1), M,
                                                 b_gpu_y);
        }
      }
    }
    maxwavcf = static_cast<real32_T>(wt->size[1]);
    emxInit_real32_T(&b_wt, 1, &q_emlrtRTEI, true);
    k = b_wt->size[0];
    b_wt->size[0] = e_y->size[0];
    emxEnsureCapacity_real32_T(b_wt, k, &o_emlrtRTEI);
    gpuEmxEnsureCapacity_real32_T(b_wt, &b_gpu_wt);
    N = e_y->size[0] - 1;
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(N + 1L), &grid,
                                           &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      ec_CWTsingle_kernel28<<<grid, block>>>(maxwavcf, b_gpu_y, N, b_gpu_wt);
    }
    emxFree_real32_T(&e_y);
    k = wt->size[0] * wt->size[1];
    wt->size[0] = b_wt->size[0];
    wt->size[1] = 1;
    emxEnsureCapacity_real32_T(wt, k, &p_emlrtRTEI);
    if (!wt_dirtyOnCpu) {
      gpuEmxEnsureCapacity_real32_T(wt, &gpu_wt);
    }
    N = b_wt->size[0] - 1;
    b_dirtyOnGpu = mwGetLaunchParameters1D(static_cast<real_T>(N + 1L), &grid,
                                           &block, 1024U, 65535U);
    if (b_dirtyOnGpu) {
      if (wt_dirtyOnCpu) {
        gpuEmxMemcpyCpuToGpu_real32_T(&gpu_wt, wt);
      }
      ec_CWTsingle_kernel29<<<grid, block>>>(b_gpu_wt, N, gpu_wt);
      wt_dirtyOnGpu = true;
    }
    emxFree_real32_T(&b_wt);
  }
  //  % Get number of freqs
  //  nFrames = size(x,1);
  //  freqs = cwtfilterbank(SignalLength=nFrames,SamplingFrequency=fs,...
  //      VoicesPerOctave=freqsPerOctave,FrequencyLimits=freqLims);
  //  freqs = freqs.centerFrequencies';
  //
  //  % Initialize
  //  coder.gpu.kernelfun; % Add kernelfun pragma to trigger kernel creation
  //  nChs = size(x,2);
  //  nFreqs = numel(freqs);
  //  if ~doAvg
  //      wt = coder.nullcopy(zeros(nFrames,nChs,nFreqs));
  //  else
  //      wt = coder.nullcopy(zeros(nFrames,nChs));
  //  end
  //
  //  % Do CWT
  //  coder.gpu.kernel();
  //  if ~doAvg
  //      for ch = 1:nChs
  //          wt(:,ch,:) = abs(cwt(x(:,ch),'morse',fs,...
  //              VoicesPerOctave=freqsPerOctave,FrequencyLimits=freqLims))';
  //      end
  //  else
  //      for ch = 1:nChs
  //          wt(:,ch) = mean(abs(cwt(x(:,ch),'morse',fs,...
  //              VoicesPerOctave=freqsPerOctave,FrequencyLimits=freqLims)),1)';
  //      end
  //  end
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  if (wt_dirtyOnGpu) {
    gpuEmxMemcpyGpuToCpu_real32_T(wt, &gpu_wt);
  }
  if (freqs_dirtyOnGpu) {
    gpuEmxMemcpyGpuToCpu_real32_T(freqs, &gpu_freqs);
  }
  if (coi_dirtyOnGpu) {
    gpuEmxMemcpyGpuToCpu_real32_T(coi, &b_gpu_coi);
  }
  mwCudaFree(&(*gpu_freqLims)[0]);
  mwCudaFree(&(*gpu_b)[0]);
  gpuEmxFree_real32_T(&gpu_x);
  gpuEmxFree_real32_T(&gpu_xv);
  gpuEmxFree_real_T(&gpu_omega);
  gpuEmxFree_creal32_T(&gpu_xdft);
  gpuEmxFree_real32_T(&gpu_psidft);
  gpuEmxFree_creal32_T(&gpu_cfsdft);
  mwCudaFree(&(*gpu_xSize)[0]);
  mwCudaFree(b_gpu_cfsdft);
  gpuEmxFree_creal32_T(&gpu_cfstmp);
  gpuEmxFree_real_T(&gpu_scales);
  gpuEmxFree_creal32_T(&gpu_cfs);
  gpuEmxFree_real32_T(&gpu_cf);
  gpuEmxFree_real_T(&gpu_coi);
  gpuEmxFree_real32_T(&b_gpu_coi);
  gpuEmxFree_real32_T(&gpu_freqs);
  gpuEmxFree_real32_T(&gpu_y);
  gpuEmxFree_real32_T(&gpu_wt);
  gpuEmxFree_real32_T(&b_gpu_y);
  gpuEmxFree_real32_T(&b_gpu_wt);
}

// End of code generation (ec_CWTsingle.cu)
