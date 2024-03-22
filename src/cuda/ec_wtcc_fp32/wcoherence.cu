//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// wcoherence.cu
//
// Code generation for function 'wcoherence'
//

// Include files
#include "wcoherence.h"
#include "bsxfun.h"
#include "cwtfilterbank.h"
#include "cwtfreqlimits.h"
#include "div.h"
#include "ec_wtcc_data.h"
#include "ec_wtcc_emxutil.h"
#include "ec_wtcc_mexutil.h"
#include "ec_wtcc_types.h"
#include "fft.h"
#include "ifft.h"
#include "log2.h"
#include "rt_nonfinite.h"
#include "smoothCFS.h"
#include "wt.h"
#include "MWCudaDimUtility.hpp"
#include "MWLaunchParametersUtilities.hpp"
#include <cmath>

// Variable Definitions
static emlrtRTEInfo fb_emlrtRTEI{
    187,                                                            // lineNo
    1,                                                              // colNo
    "wcoherence",                                                   // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/wcoherence.m" // pName
};

static emlrtRTEInfo gb_emlrtRTEI{
    102,  // lineNo
    5,    // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

static emlrtRTEInfo mb_emlrtRTEI{
    219,                                                            // lineNo
    1,                                                              // colNo
    "wcoherence",                                                   // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/wcoherence.m" // pName
};

static emlrtRTEInfo ob_emlrtRTEI{
    170,                                                            // lineNo
    5,                                                              // colNo
    "wcoherence",                                                   // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/wcoherence.m" // pName
};

static emlrtRTEInfo pb_emlrtRTEI{
    1,                                                              // lineNo
    37,                                                             // colNo
    "wcoherence",                                                   // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/wcoherence.m" // pName
};

static emlrtRTEInfo rb_emlrtRTEI{
    161,  // lineNo
    1,    // colNo
    "wt", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/wt.m" // pName
};

static emlrtRTEInfo sb_emlrtRTEI{
    216,                                                            // lineNo
    39,                                                             // colNo
    "wcoherence",                                                   // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/wcoherence.m" // pName
};

static emlrtRTEInfo tb_emlrtRTEI{
    217,                                                            // lineNo
    39,                                                             // colNo
    "wcoherence",                                                   // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/wcoherence.m" // pName
};

static emlrtRTEInfo ub_emlrtRTEI{
    220,                                                            // lineNo
    7,                                                              // colNo
    "wcoherence",                                                   // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/wcoherence.m" // pName
};

// Function Declarations
static void binary_expand_op_1(emxArray_creal32_T *in1,
                               const emxArray_creal32_T *in2,
                               const emxArray_creal32_T *in3);

static real32_T rt_hypotf_snf(real32_T u0, real32_T u1);

static __global__ void wcoherence_kernel26(const int32_T i, const int32_T b,
                                           emxArray_real32_T x);

// Function Definitions
static void binary_expand_op_1(emxArray_creal32_T *in1,
                               const emxArray_creal32_T *in2,
                               const emxArray_creal32_T *in3)
{
  int32_T aux_0_1;
  int32_T aux_1_1;
  int32_T b;
  int32_T i;
  int32_T stride_0_0;
  int32_T stride_0_1;
  int32_T stride_1_0;
  int32_T stride_1_1;
  i = in1->size[0] * in1->size[1];
  if (in3->size[0] == 1) {
    in1->size[0] = in2->size[0];
  } else {
    in1->size[0] = in3->size[0];
  }
  if (in3->size[1] == 1) {
    in1->size[1] = in2->size[1];
  } else {
    in1->size[1] = in3->size[1];
  }
  emxEnsureCapacity_creal32_T(in1, i, &mb_emlrtRTEI);
  stride_0_0 = (in2->size[0] != 1);
  stride_0_1 = (in2->size[1] != 1);
  stride_1_0 = (in3->size[0] != 1);
  stride_1_1 = (in3->size[1] != 1);
  aux_0_1 = 0;
  aux_1_1 = 0;
  if (in3->size[1] == 1) {
    b = in2->size[1];
  } else {
    b = in3->size[1];
  }
  for (i = 0; i < b; i++) {
    int32_T c;
    if (in3->size[0] == 1) {
      c = in2->size[0];
    } else {
      c = in3->size[0];
    }
    for (int32_T i1{0}; i1 < c; i1++) {
      real32_T in3_im;
      real32_T in3_re;
      in3_re = in3->data[i1 * stride_1_0 + in3->size[0] * aux_1_1].re;
      in3_im = -in3->data[i1 * stride_1_0 + in3->size[0] * aux_1_1].im;
      in1->data[i1 + in1->size[0] * i].re =
          in2->data[i1 * stride_0_0 + in2->size[0] * aux_0_1].re * in3_re -
          in2->data[i1 * stride_0_0 + in2->size[0] * aux_0_1].im * in3_im;
      in1->data[i1 + in1->size[0] * i].im =
          in2->data[i1 * stride_0_0 + in2->size[0] * aux_0_1].re * in3_im +
          in2->data[i1 * stride_0_0 + in2->size[0] * aux_0_1].im * in3_re;
    }
    aux_1_1 += stride_1_1;
    aux_0_1 += stride_0_1;
  }
}

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

static __global__ __launch_bounds__(1024, 1) void wcoherence_kernel26(
    const int32_T i, const int32_T b, emxArray_real32_T x)
{
  uint64_T gStride;
  uint64_T gThreadId;
  uint64_T loopEnd;
  gThreadId = mwGetGlobalThreadIndex();
  gStride = mwGetTotalThreadsLaunched();
  loopEnd = static_cast<uint64_T>(b);
  for (uint64_T idx{gThreadId}; idx <= loopEnd; idx += gStride) {
    int32_T b_j1;
    int32_T j2;
    real32_T xtmp;
    b_j1 = static_cast<int32_T>(idx);
    j2 = i - b_j1;
    xtmp = x.data[b_j1];
    x.data[b_j1] = x.data[j2 - 1];
    x.data[j2 - 1] = xtmp;
  }
}

//
//
namespace coder {
void wcoherence(const emxArray_real32_T *x, const emxArray_real32_T *y,
                real_T varargin_1, const real_T varargin_3[2],
                real_T varargin_5, emxArray_real32_T *wcoh,
                emxArray_creal32_T *cpu_wcs, boolean_T *wcs_outdatedOnCpu,
                emxArray_creal32_T *gpu_wcs, boolean_T *wcs_outdatedOnGpu)
{
  static const int32_T iv[2]{1, 7};
  static const int32_T iv1[2]{1, 7};
  static const char_T rfmt[7]{'%', '2', '3', '.', '1', '5', 'e'};
  cwtfilterbank fb;
  dim3 block;
  dim3 grid;
  emxArray_creal32_T gpu_xposdft;
  emxArray_creal32_T *cfspos;
  emxArray_creal32_T *cpu_xposdft;
  emxArray_creal32_T *cwtx;
  emxArray_creal32_T *r;
  emxArray_real32_T b_gpu_y;
  emxArray_real32_T gpu_x;
  emxArray_real32_T gpu_xv;
  emxArray_real32_T gpu_y;
  emxArray_real32_T *b_cpu_y;
  emxArray_real32_T *coitmp;
  emxArray_real32_T *cpu_x;
  emxArray_real32_T *cpu_xv;
  emxArray_real32_T *cpu_y;
  emxArray_real32_T *f;
  emxArray_real32_T *g_y;
  emxArray_real32_T *i_y;
  emxArray_real32_T *j_y;
  emxArray_real32_T *k_y;
  emxArray_real32_T *psihat;
  emxArray_real_T gpu_scales;
  emxArray_real_T *cpu_scales;
  const mxArray *d_y;
  const mxArray *e_y;
  const mxArray *f_y;
  const mxArray *h_y;
  const mxArray *m;
  const mxArray *m1;
  const mxArray *m2;
  const mxArray *m3;
  real_T FLimits[2];
  real_T Norig;
  real_T b_y;
  real_T c_y;
  real_T maxperiod;
  real_T minperiod;
  real_T ns;
  int32_T b_i;
  int32_T i;
  int32_T i3;
  int32_T i5;
  int32_T k;
  int32_T nd2;
  char_T unusedExpr[23];
  boolean_T exitg1;
  boolean_T guard1;
  boolean_T scales_outdatedOnGpu;
  boolean_T xposdft_outdatedOnCpu;
  boolean_T xposdft_outdatedOnGpu;
  boolean_T xv_outdatedOnCpu;
  boolean_T xv_outdatedOnGpu;
  gpuEmxReset_real32_T(&b_gpu_y);
  gpuEmxReset_real32_T(&gpu_y);
  gpuEmxReset_real32_T(&gpu_x);
  gpuEmxReset_creal32_T(&gpu_xposdft);
  gpuEmxReset_real32_T(&gpu_xv);
  gpuEmxReset_real_T(&gpu_scales);
  xposdft_outdatedOnCpu = false;
  xposdft_outdatedOnGpu = false;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  emxInitStruct_cwtfilterbank(&fb, &ob_emlrtRTEI, true);
  b_y = std::trunc(b_log2(static_cast<real_T>(x->size[0])));
  FLimits[0] = varargin_3[0];
  FLimits[1] = varargin_3[1];
  c_y = std::trunc(b_log2(static_cast<real_T>(x->size[0])));
  if (!(b_y - 1.0 <= c_y - 1.0)) {
    d_y = nullptr;
    m = emlrtCreateCharArray(2, &iv[0]);
    emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m, &rfmt[0]);
    emlrtAssign(&d_y, m);
    e_y = nullptr;
    m1 = emlrtCreateDoubleScalar(c_y - 1.0);
    emlrtAssign(&e_y, m1);
    emlrt_marshallIn(b_sprintf(d_y, e_y, &emlrtMCI), "<output of sprintf>",
                     unusedExpr);
  }
  guard1 = false;
  if ((varargin_1 == 0.0) || std::isnan(varargin_1)) {
    xposdft_outdatedOnCpu = true;
    k = 0;
    exitg1 = false;
    while ((!exitg1) && (k < 2)) {
      if (!(varargin_3[k] == 0.0)) {
        xposdft_outdatedOnCpu = false;
        exitg1 = true;
      } else {
        k++;
      }
    }
    if (xposdft_outdatedOnCpu) {
      wavelet::internal::cwt::cwtfreqlimits(static_cast<real_T>(x->size[0]),
                                            10.0, 1.0, varargin_5, &maxperiod,
                                            &Norig, &ns, &c_y, &minperiod);
      FLimits[0] = rt_powd_snf(2.0, -(b_y - 1.0)) * c_y;
      FLimits[1] = c_y;
    } else {
      guard1 = true;
    }
  } else {
    guard1 = true;
  }
  if (guard1 && ((!(varargin_1 == 0.0)) && (!std::isnan(varargin_1)))) {
    xposdft_outdatedOnCpu = true;
    k = 0;
    exitg1 = false;
    while ((!exitg1) && (k < 2)) {
      if (!(varargin_3[k] == 0.0)) {
        xposdft_outdatedOnCpu = false;
        exitg1 = true;
      } else {
        k++;
      }
    }
    if (xposdft_outdatedOnCpu) {
      wavelet::internal::cwt::cwtfreqlimits(
          static_cast<real_T>(x->size[0]), 10.0, varargin_1, varargin_5,
          &maxperiod, &Norig, &ns, &c_y, &minperiod);
      FLimits[0] = rt_powd_snf(2.0, -(b_y - 1.0)) * c_y;
      FLimits[1] = c_y;
    }
  }
  cwtfilterbank_cwtfilterbank(&fb, static_cast<real_T>(x->size[0]), FLimits,
                              varargin_1, varargin_5);
  emxInit_real_T(&cpu_scales, 2, &fb_emlrtRTEI, true);
  scales_outdatedOnGpu = false;
  i = cpu_scales->size[0] * cpu_scales->size[1];
  cpu_scales->size[0] = 1;
  cpu_scales->size[1] = fb.Scales->size[1];
  emxEnsureCapacity_real_T(cpu_scales, i, &fb_emlrtRTEI);
  for (i = 0; i < fb.Scales->size[1]; i++) {
    cpu_scales->data[i] = fb.Scales->data[i];
    scales_outdatedOnGpu = true;
  }
  ns = std::fmin(std::floor(static_cast<real_T>(cpu_scales->size[1]) / 2.0),
                 varargin_5);
  emxInit_creal32_T(&cwtx, 2, &pb_emlrtRTEI, true);
  emxInit_real32_T(&f, 1, &pb_emlrtRTEI, true);
  emxInit_real32_T(&coitmp, 1, &pb_emlrtRTEI, true);
  cwtfilterbank_wt(&fb, x, cwtx, f, coitmp);
  emxFree_real32_T(&coitmp);
  emxFree_real32_T(&f);
  emxInit_real32_T(&psihat, 2, &gb_emlrtRTEI, true);
  i = psihat->size[0] * psihat->size[1];
  psihat->size[0] = fb.PsiDFT->size[0];
  psihat->size[1] = fb.PsiDFT->size[1];
  emxEnsureCapacity_real32_T(psihat, i, &gb_emlrtRTEI);
  for (i = 0; i < fb.PsiDFT->size[0] * fb.PsiDFT->size[1]; i++) {
    psihat->data[i] = static_cast<real32_T>(fb.PsiDFT->data[i]);
  }
  emxInit_real32_T(&cpu_xv, 2, &hb_emlrtRTEI, true);
  xv_outdatedOnCpu = false;
  xv_outdatedOnGpu = false;
  i = cpu_xv->size[0] * cpu_xv->size[1];
  cpu_xv->size[0] = 1;
  cpu_xv->size[1] = y->size[0];
  emxEnsureCapacity_real32_T(cpu_xv, i, &hb_emlrtRTEI);
  for (i = 0; i < y->size[0]; i++) {
    cpu_xv->data[i] = y->data[i];
    xv_outdatedOnGpu = true;
  }
  Norig = fb.SignalLength;
  if (fb.SignalPad > 0.0) {
    boolean_T validLaunchParams;
    c_y = fb.SignalPad;
    if (c_y < 1.0) {
      b_i = 0;
    } else {
      b_i = static_cast<int32_T>(c_y);
    }
    c_y = (static_cast<real_T>(y->size[0]) - fb.SignalPad) + 1.0;
    if (c_y > y->size[0]) {
      k = 0;
      i3 = 1;
      i5 = -1;
    } else {
      k = y->size[0] - 1;
      i3 = -1;
      i5 = static_cast<int32_T>(c_y) - 1;
    }
    emxInit_real32_T(&cpu_x, 2, &ib_emlrtRTEI, true);
    xposdft_outdatedOnCpu = false;
    i = cpu_x->size[0] * cpu_x->size[1];
    cpu_x->size[0] = 1;
    cpu_x->size[1] = b_i;
    emxEnsureCapacity_real32_T(cpu_x, i, &ib_emlrtRTEI);
    for (i = 0; i < b_i; i++) {
      cpu_x->data[i] = y->data[i];
      xposdft_outdatedOnCpu = true;
    }
    mwGetLaunchParameters1D(computeNumIters((b_i >> 1) - 1), &grid, &block,
                            2147483647U);
    gpuEmxEnsureCapacity_real32_T(cpu_x, &gpu_x, !xposdft_outdatedOnCpu);
    if (xposdft_outdatedOnCpu) {
      gpuEmxMemcpyCpuToGpu_real32_T(&gpu_x, cpu_x);
    }
    validLaunchParams = mwValidateLaunchParameters(grid, block);
    if (validLaunchParams) {
      wcoherence_kernel26<<<grid, block>>>(b_i, (b_i >> 1) - 1, gpu_x);
    }
    xposdft_outdatedOnCpu = true;
    xv_outdatedOnGpu = false;
    i = cpu_xv->size[0] * cpu_xv->size[1];
    cpu_xv->size[0] = 1;
    cpu_xv->size[1] = ((y->size[0] + cpu_x->size[1]) + div_s32(i5 - k, i3)) + 1;
    emxEnsureCapacity_real32_T(cpu_xv, i, &lb_emlrtRTEI);
    b_i = cpu_x->size[1];
    for (i = 0; i < b_i; i++) {
      if (xposdft_outdatedOnCpu) {
        gpuEmxMemcpyGpuToCpu_real32_T(cpu_x, &gpu_x);
      }
      xposdft_outdatedOnCpu = false;
      cpu_xv->data[i] = cpu_x->data[i];
      xv_outdatedOnGpu = true;
    }
    b_i = y->size[0];
    for (i = 0; i < b_i; i++) {
      cpu_xv->data[i + cpu_x->size[1]] = y->data[i];
      xv_outdatedOnGpu = true;
    }
    b_i = div_s32(i5 - k, i3);
    for (i = 0; i <= b_i; i++) {
      cpu_xv->data[(i + y->size[0]) + cpu_x->size[1]] = y->data[k + i3 * i];
      xv_outdatedOnGpu = true;
    }
    emxFree_real32_T(&cpu_x);
  }
  emxInit_creal32_T(&cpu_xposdft, 2, &qb_emlrtRTEI, true);
  fft(cpu_xv, &xv_outdatedOnCpu, &gpu_xv, &xv_outdatedOnGpu, cpu_xposdft,
      &xposdft_outdatedOnCpu, &gpu_xposdft, &xposdft_outdatedOnGpu);
  emxFree_real32_T(&cpu_xv);
  emxInit_creal32_T(&r, 2, &vb_emlrtRTEI, true);
  if (xposdft_outdatedOnCpu) {
    gpuEmxMemcpyGpuToCpu_creal32_T(cpu_xposdft, &gpu_xposdft);
  }
  bsxfun(cpu_xposdft, psihat, r);
  emxFree_creal32_T(&cpu_xposdft);
  emxFree_real32_T(&psihat);
  emxInit_creal32_T(&cfspos, 2, &rb_emlrtRTEI, true);
  ifft(r, cfspos);
  emxFree_creal32_T(&r);
  if (fb.SignalPad > 0.0) {
    maxperiod = fb.SignalPad + 1.0;
    c_y = fb.SignalPad + Norig;
    if (maxperiod > c_y) {
      nd2 = 0;
      k = 0;
    } else {
      nd2 = static_cast<int32_T>(maxperiod) - 1;
      k = static_cast<int32_T>(c_y);
    }
    i3 = cfspos->size[0];
    b_i = k - nd2;
    for (i = 0; i < b_i; i++) {
      for (i5 = 0; i5 < i3; i5++) {
        cfspos->data[i5 + i3 * i] =
            cfspos->data[i5 + cfspos->size[0] * (nd2 + i)];
      }
    }
    i = cfspos->size[0] * cfspos->size[1];
    cfspos->size[1] = k - nd2;
    emxEnsureCapacity_creal32_T(cfspos, i, &jb_emlrtRTEI);
  }
  nd2 = static_cast<int32_T>(
      std::trunc(static_cast<real_T>(cwtx->size[0]) / 2.0));
  if (!(ns <= nd2)) {
    f_y = nullptr;
    m2 = emlrtCreateCharArray(2, &iv1[0]);
    emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m2, &rfmt[0]);
    emlrtAssign(&f_y, m2);
    h_y = nullptr;
    m3 = emlrtCreateDoubleScalar(static_cast<real_T>(nd2));
    emlrtAssign(&h_y, m3);
    emlrt_marshallIn(b_sprintf(f_y, h_y, &emlrtMCI), "<output of sprintf>",
                     unusedExpr);
  }
  nd2 = cwtx->size[0] * cwtx->size[1];
  emxInit_real32_T(&g_y, 2, &sb_emlrtRTEI, true);
  i = g_y->size[0] * g_y->size[1];
  g_y->size[0] = cwtx->size[0];
  g_y->size[1] = cwtx->size[1];
  emxEnsureCapacity_real32_T(g_y, i, &h_emlrtRTEI);
  for (k = 0; k < nd2; k++) {
    g_y->data[k] = rt_hypotf_snf(cwtx->data[k].re, cwtx->data[k].im);
  }
  emxInit_real32_T(&cpu_y, 2, &sb_emlrtRTEI, true);
  xposdft_outdatedOnGpu = false;
  xposdft_outdatedOnCpu = false;
  i = cpu_y->size[0] * cpu_y->size[1];
  cpu_y->size[0] = g_y->size[0];
  cpu_y->size[1] = g_y->size[1];
  emxEnsureCapacity_real32_T(cpu_y, i, &kb_emlrtRTEI);
  nd2 = g_y->size[0] * g_y->size[1];
  for (k = 0; k < nd2; k++) {
    cpu_y->data[k] = g_y->data[k] * g_y->data[k];
    xposdft_outdatedOnCpu = true;
  }
  emxFree_real32_T(&g_y);
  wavelet::internal::cwt::smoothCFS(cpu_y, &xposdft_outdatedOnGpu, &gpu_y,
                                    &xposdft_outdatedOnCpu, cpu_scales,
                                    &gpu_scales, &scales_outdatedOnGpu, ns);
  nd2 = cfspos->size[0] * cfspos->size[1];
  emxInit_real32_T(&i_y, 2, &tb_emlrtRTEI, true);
  i = i_y->size[0] * i_y->size[1];
  i_y->size[0] = cfspos->size[0];
  i_y->size[1] = cfspos->size[1];
  emxEnsureCapacity_real32_T(i_y, i, &h_emlrtRTEI);
  for (k = 0; k < nd2; k++) {
    i_y->data[k] = rt_hypotf_snf(cfspos->data[k].re, cfspos->data[k].im);
  }
  emxInit_real32_T(&b_cpu_y, 2, &tb_emlrtRTEI, true);
  xv_outdatedOnGpu = false;
  xposdft_outdatedOnCpu = false;
  i = b_cpu_y->size[0] * b_cpu_y->size[1];
  b_cpu_y->size[0] = i_y->size[0];
  b_cpu_y->size[1] = i_y->size[1];
  emxEnsureCapacity_real32_T(b_cpu_y, i, &kb_emlrtRTEI);
  nd2 = i_y->size[0] * i_y->size[1];
  for (k = 0; k < nd2; k++) {
    b_cpu_y->data[k] = i_y->data[k] * i_y->data[k];
    xposdft_outdatedOnCpu = true;
  }
  emxFree_real32_T(&i_y);
  wavelet::internal::cwt::smoothCFS(b_cpu_y, &xv_outdatedOnGpu, &b_gpu_y,
                                    &xposdft_outdatedOnCpu, cpu_scales,
                                    &gpu_scales, &scales_outdatedOnGpu, ns);
  if ((cwtx->size[0] == cfspos->size[0]) &&
      (cwtx->size[1] == cfspos->size[1])) {
    *wcs_outdatedOnCpu = false;
    *wcs_outdatedOnGpu = false;
    i = cpu_wcs->size[0] * cpu_wcs->size[1];
    cpu_wcs->size[0] = cwtx->size[0];
    cpu_wcs->size[1] = cwtx->size[1];
    emxEnsureCapacity_creal32_T(cpu_wcs, i, &mb_emlrtRTEI);
    for (i = 0; i < cwtx->size[0] * cwtx->size[1]; i++) {
      real32_T cfspos_im;
      real32_T cfspos_re;
      cfspos_re = cfspos->data[i].re;
      cfspos_im = -cfspos->data[i].im;
      cpu_wcs->data[i].re =
          cwtx->data[i].re * cfspos_re - cwtx->data[i].im * cfspos_im;
      cpu_wcs->data[i].im =
          cwtx->data[i].re * cfspos_im + cwtx->data[i].im * cfspos_re;
      *wcs_outdatedOnGpu = true;
    }
  } else {
    if (*wcs_outdatedOnCpu) {
      gpuEmxMemcpyGpuToCpu_creal32_T(cpu_wcs, gpu_wcs);
    }
    binary_expand_op_1(cpu_wcs, cwtx, cfspos);
    *wcs_outdatedOnCpu = false;
    *wcs_outdatedOnGpu = true;
  }
  emxFree_creal32_T(&cfspos);
  emxFree_creal32_T(&cwtx);
  wavelet::internal::cwt::b_smoothCFS(cpu_wcs, wcs_outdatedOnCpu, gpu_wcs,
                                      wcs_outdatedOnGpu, cpu_scales,
                                      &gpu_scales, &scales_outdatedOnGpu, ns);
  emxFree_real_T(&cpu_scales);
  nd2 = cpu_wcs->size[0] * cpu_wcs->size[1];
  emxInit_real32_T(&j_y, 2, &ub_emlrtRTEI, true);
  i = j_y->size[0] * j_y->size[1];
  j_y->size[0] = cpu_wcs->size[0];
  j_y->size[1] = cpu_wcs->size[1];
  emxEnsureCapacity_real32_T(j_y, i, &h_emlrtRTEI);
  for (k = 0; k < nd2; k++) {
    if (*wcs_outdatedOnCpu) {
      gpuEmxMemcpyGpuToCpu_creal32_T(cpu_wcs, gpu_wcs);
    }
    *wcs_outdatedOnCpu = false;
    j_y->data[k] = rt_hypotf_snf(cpu_wcs->data[k].re, cpu_wcs->data[k].im);
  }
  emxInit_real32_T(&k_y, 2, &ub_emlrtRTEI, true);
  i = k_y->size[0] * k_y->size[1];
  k_y->size[0] = j_y->size[0];
  k_y->size[1] = j_y->size[1];
  emxEnsureCapacity_real32_T(k_y, i, &kb_emlrtRTEI);
  nd2 = j_y->size[0] * j_y->size[1];
  for (k = 0; k < nd2; k++) {
    k_y->data[k] = j_y->data[k] * j_y->data[k];
  }
  emxFree_real32_T(&j_y);
  if (cpu_y->size[0] == 1) {
    i3 = b_cpu_y->size[0];
  } else {
    i3 = cpu_y->size[0];
  }
  if (cpu_y->size[1] == 1) {
    nd2 = b_cpu_y->size[1];
  } else {
    nd2 = cpu_y->size[1];
  }
  if ((cpu_y->size[0] == b_cpu_y->size[0]) &&
      (cpu_y->size[1] == b_cpu_y->size[1]) && (k_y->size[0] == i3) &&
      (k_y->size[1] == nd2)) {
    i = wcoh->size[0] * wcoh->size[1];
    wcoh->size[0] = k_y->size[0];
    wcoh->size[1] = k_y->size[1];
    emxEnsureCapacity_real32_T(wcoh, i, &nb_emlrtRTEI);
    for (i = 0; i < k_y->size[0] * k_y->size[1]; i++) {
      if (xposdft_outdatedOnGpu) {
        gpuEmxMemcpyGpuToCpu_real32_T(cpu_y, &gpu_y);
      }
      xposdft_outdatedOnGpu = false;
      if (xv_outdatedOnGpu) {
        gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_y, &b_gpu_y);
      }
      xv_outdatedOnGpu = false;
      wcoh->data[i] = k_y->data[i] / (cpu_y->data[i] * b_cpu_y->data[i]);
    }
  } else {
    if (xposdft_outdatedOnGpu) {
      gpuEmxMemcpyGpuToCpu_real32_T(cpu_y, &gpu_y);
    }
    if (xv_outdatedOnGpu) {
      gpuEmxMemcpyGpuToCpu_real32_T(b_cpu_y, &b_gpu_y);
    }
    binary_expand_op(wcoh, k_y, cpu_y, b_cpu_y);
  }
  emxFree_real32_T(&k_y);
  emxFree_real32_T(&b_cpu_y);
  emxFree_real32_T(&cpu_y);
  nd2 = wcoh->size[0] * wcoh->size[1] - 1;
  for (b_i = 0; b_i <= nd2; b_i++) {
    if (wcoh->data[b_i] > 1.0F) {
      wcoh->data[b_i] = 1.0F;
    }
  }
  emxFreeStruct_cwtfilterbank(&fb);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  gpuEmxFree_real_T(&gpu_scales);
  gpuEmxFree_real32_T(&gpu_xv);
  gpuEmxFree_creal32_T(&gpu_xposdft);
  gpuEmxFree_real32_T(&gpu_x);
  gpuEmxFree_real32_T(&gpu_y);
  gpuEmxFree_real32_T(&b_gpu_y);
}

} // namespace coder

// End of code generation (wcoherence.cu)
