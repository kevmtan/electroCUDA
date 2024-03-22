//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// cwtfilterbank.cu
//
// Code generation for function 'cwtfilterbank'
//

// Include files
#include "cwtfilterbank.h"
#include "bsxfun.h"
#include "cwtfreqlimits.h"
#include "ec_cwtAvg_data.h"
#include "ec_cwtAvg_emxutil.h"
#include "ec_cwtAvg_mexutil.h"
#include "ec_cwtAvg_types.h"
#include "log2.h"
#include "morsebpfilters.h"
#include "rt_nonfinite.h"
#include "wavCFandSD.h"
#include "wavbpfilters.h"
#include <cmath>

// Variable Definitions
static emlrtMCInfo emlrtMCI{
    53,                                                                // lineNo
    14,                                                                // colNo
    "nonConstPrint",                                                   // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/strfun/sprintf.m" // pName
};

static emlrtMCInfo b_emlrtMCI{
    55,                                                                // lineNo
    15,                                                                // colNo
    "nonConstPrint",                                                   // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/strfun/sprintf.m" // pName
};

static emlrtRTEInfo db_emlrtRTEI{
    999,             // lineNo
    17,              // colNo
    "cwtfilterbank", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "cwtfilterbank.m" // pName
};

static emlrtRTEInfo eb_emlrtRTEI{
    1000,            // lineNo
    17,              // colNo
    "cwtfilterbank", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "cwtfilterbank.m" // pName
};

static emlrtRTEInfo fb_emlrtRTEI{
    1009,            // lineNo
    13,              // colNo
    "cwtfilterbank", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "cwtfilterbank.m" // pName
};

static emlrtRTEInfo hb_emlrtRTEI{
    1278,            // lineNo
    13,              // colNo
    "cwtfilterbank", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "cwtfilterbank.m" // pName
};

static emlrtRTEInfo ib_emlrtRTEI{
    217,             // lineNo
    21,              // colNo
    "cwtfilterbank", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "cwtfilterbank.m" // pName
};

static emlrtRTEInfo jb_emlrtRTEI{
    18,             // lineNo
    5,              // colNo
    "wavbpfilters", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "wavbpfilters.m" // pName
};

static emlrtRTEInfo kb_emlrtRTEI{
    31,             // lineNo
    9,              // colNo
    "wavbpfilters", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "wavbpfilters.m" // pName
};

static emlrtRTEInfo lb_emlrtRTEI{
    18,               // lineNo
    5,                // colNo
    "morsebpfilters", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "morsebpfilters.m" // pName
};

static emlrtRTEInfo mb_emlrtRTEI{
    33,             // lineNo
    9,              // colNo
    "wavbpfilters", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "wavbpfilters.m" // pName
};

static emlrtRTEInfo nb_emlrtRTEI{
    25,               // lineNo
    5,                // colNo
    "morsebpfilters", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "morsebpfilters.m" // pName
};

static emlrtRTEInfo qb_emlrtRTEI{
    41,             // lineNo
    1,              // colNo
    "wavbpfilters", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "wavbpfilters.m" // pName
};

static emlrtRTEInfo sb_emlrtRTEI{
    33,               // lineNo
    1,                // colNo
    "morsebpfilters", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "morsebpfilters.m" // pName
};

static emlrtRTEInfo tb_emlrtRTEI{
    956,             // lineNo
    13,              // colNo
    "cwtfilterbank", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "cwtfilterbank.m" // pName
};

static emlrtRTEInfo ub_emlrtRTEI{
    227,             // lineNo
    13,              // colNo
    "cwtfilterbank", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "cwtfilterbank.m" // pName
};

static emlrtRTEInfo vb_emlrtRTEI{
    228,             // lineNo
    13,              // colNo
    "cwtfilterbank", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "cwtfilterbank.m" // pName
};

static emlrtRTEInfo wb_emlrtRTEI{
    1276,            // lineNo
    30,              // colNo
    "cwtfilterbank", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "cwtfilterbank.m" // pName
};

static emlrtRTEInfo xb_emlrtRTEI{
    1276,            // lineNo
    25,              // colNo
    "cwtfilterbank", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "cwtfilterbank.m" // pName
};

static emlrtRTEInfo yb_emlrtRTEI{
    16,             // lineNo
    5,              // colNo
    "wavbpfilters", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "wavbpfilters.m" // pName
};

static emlrtRTEInfo ac_emlrtRTEI{
    32,             // lineNo
    18,             // colNo
    "getCWTScales", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "getCWTScales.m" // pName
};

static emlrtRTEInfo bc_emlrtRTEI{
    16,               // lineNo
    5,                // colNo
    "morsebpfilters", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "morsebpfilters.m" // pName
};

static emlrtRTEInfo cc_emlrtRTEI{
    26,             // lineNo
    9,              // colNo
    "wavbpfilters", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "wavbpfilters.m" // pName
};

static emlrtRTEInfo dc_emlrtRTEI{
    32,             // lineNo
    13,             // colNo
    "getCWTScales", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "getCWTScales.m" // pName
};

static emlrtRTEInfo ec_emlrtRTEI{
    21,               // lineNo
    1,                // colNo
    "morsebpfilters", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "morsebpfilters.m" // pName
};

static emlrtRTEInfo fc_emlrtRTEI{
    34,             // lineNo
    42,             // colNo
    "wavbpfilters", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "wavbpfilters.m" // pName
};

static emlrtRTEInfo gc_emlrtRTEI{
    175,             // lineNo
    25,              // colNo
    "cwtfilterbank", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "cwtfilterbank.m" // pName
};

static emlrtRTEInfo hc_emlrtRTEI{
    934,             // lineNo
    26,              // colNo
    "cwtfilterbank", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "cwtfilterbank.m" // pName
};

static emlrtRTEInfo ic_emlrtRTEI{
    816,             // lineNo
    25,              // colNo
    "cwtfilterbank", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "cwtfilterbank.m" // pName
};

// Function Declarations
static void b_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_char_T *ret);

namespace coder {
static cwtfilterbank *cwtfilterbank_setProperties(cwtfilterbank *self,
                                                  real_T varargin_4,
                                                  real_T varargin_6,
                                                  const real_T varargin_8[2],
                                                  real_T varargin_10);

}
static void emlrt_marshallIn(const mxArray *tmpStr, const char_T *identifier,
                             emxArray_char_T *y);

static void emlrt_marshallIn(const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             emxArray_char_T *y);

static const mxArray *feval(const mxArray *m1, const mxArray *m2,
                            const mxArray *m3, emlrtMCInfo *location);

static const mxArray *length(const mxArray *m1, emlrtMCInfo *location);

// Function Definitions
static void b_emlrt_marshallIn(const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               emxArray_char_T *ret)
{
  static const int32_T dims[2]{1, -1};
  int32_T iv[2];
  int32_T i;
  boolean_T bv[2]{false, true};
  emlrtCheckVsBuiltInR2012b(emlrtRootTLSGlobal, msgId, src, "char", false, 2U,
                            (const void *)&dims[0], &bv[0], &iv[0]);
  i = ret->size[0] * ret->size[1];
  ret->size[0] = iv[0];
  ret->size[1] = iv[1];
  emxEnsureCapacity_char_T(ret, i, static_cast<emlrtRTEInfo *>(nullptr));
  emlrtImportArrayR2015b(emlrtRootTLSGlobal, src, &ret->data[0], 1, false);
  emlrtDestroyArray(&src);
}

//
//
namespace coder {
static cwtfilterbank *cwtfilterbank_setProperties(cwtfilterbank *self,
                                                  real_T varargin_4,
                                                  real_T varargin_6,
                                                  const real_T varargin_8[2],
                                                  real_T varargin_10)
{
  static const int32_T iv[2]{1, 7};
  static const int32_T iv1[2]{1, 2};
  static const int32_T iv2[2]{1, 7};
  static const int32_T iv3[2]{1, 5};
  static const char_T b[10]{'r', 'e', 'f', 'l', 'e', 'c', 't', 'i', 'o', 'n'};
  static const char_T cv2[10]{'r', 'e', 'f', 'l', 'e', 'c', 't', 'i', 'o', 'n'};
  static const char_T u[7]{'s', 'p', 'r', 'i', 'n', 't', 'f'};
  static const char_T b_cv[5]{'M', 'o', 'r', 's', 'e'};
  static const char_T b_formatSpec[5]{'%', '2', '.', '2', 'f'};
  static const char_T cv3[5]{'M', 'o', 'r', 's', 'e'};
  static const char_T cv4[5]{'m', 'o', 'r', 's', 'e'};
  static const char_T formatSpec[2]{'%', 'f'};
  cwtfilterbank *b_self;
  emxArray_char_T *d_tmpStr;
  emxArray_char_T *tmpStr;
  const mxArray *b_tmpStr;
  const mxArray *b_y;
  const mxArray *c_tmpStr;
  const mxArray *c_y;
  const mxArray *d_y;
  const mxArray *e_y;
  const mxArray *f_y;
  const mxArray *m;
  const mxArray *m1;
  const mxArray *m2;
  const mxArray *m3;
  const mxArray *m4;
  const mxArray *m5;
  const mxArray *y;
  real_T NyquistRange_idx_1;
  real_T cf;
  real_T sigmat;
  int32_T exitg2;
  int32_T k;
  char_T a[10];
  char_T wav[5];
  boolean_T b_b[2];
  boolean_T exitg1;
  boolean_T freqsep;
  boolean_T guard1;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  b_self = self;
  b_self->CutOff = 50.0;
  b_self->Gamma = 3.0;
  b_self->Beta = 20.0;
  for (k = 0; k < 5; k++) {
    b_self->Wavelet[k] = b_cv[k];
  }
  b_self->TimeBandwidth = rtNaN;
  b_self->SignalLength = varargin_4;
  NyquistRange_idx_1 = b_self->SignalLength / 2.0;
  NyquistRange_idx_1 = std::floor(NyquistRange_idx_1);
  b_self->SignalPad = NyquistRange_idx_1;
  b_self->VoicesPerOctave = varargin_10;
  b_self->SamplingFrequency = varargin_6;
  b_self->WaveletParameters[0] = rtNaN;
  b_self->FrequencyLimits[0] = varargin_8[0];
  b_self->WaveletParameters[1] = rtNaN;
  b_self->FrequencyLimits[1] = varargin_8[1];
  for (k = 0; k < 10; k++) {
    b_self->Boundary[k] = b[k];
  }
  NyquistRange_idx_1 = b_self->TimeBandwidth;
  guard1 = false;
  if (!std::isnan(NyquistRange_idx_1)) {
    NyquistRange_idx_1 = b_self->WaveletParameters[0];
    b_b[0] = std::isnan(NyquistRange_idx_1);
    NyquistRange_idx_1 = b_self->WaveletParameters[1];
    b_b[1] = std::isnan(NyquistRange_idx_1);
    freqsep = true;
    k = 0;
    exitg1 = false;
    while ((!exitg1) && (k < 2)) {
      if (!b_b[k]) {
        freqsep = false;
        exitg1 = true;
      } else {
        k++;
      }
    }
    if (freqsep) {
      b_self->Beta = b_self->TimeBandwidth / b_self->Gamma;
    } else {
      guard1 = true;
    }
  } else {
    guard1 = true;
  }
  if (guard1) {
    NyquistRange_idx_1 = b_self->WaveletParameters[0];
    b_b[0] = std::isnan(NyquistRange_idx_1);
    NyquistRange_idx_1 = b_self->WaveletParameters[1];
    b_b[1] = std::isnan(NyquistRange_idx_1);
    freqsep = true;
    k = 0;
    exitg1 = false;
    while ((!exitg1) && (k < 2)) {
      if (!b_b[k]) {
        freqsep = false;
        exitg1 = true;
      } else {
        k++;
      }
    }
    if (!freqsep) {
      NyquistRange_idx_1 = b_self->TimeBandwidth;
      if (std::isnan(NyquistRange_idx_1)) {
        b_self->Gamma = b_self->WaveletParameters[0];
        b_self->Beta = b_self->WaveletParameters[1] / b_self->Gamma;
      }
    }
  }
  for (k = 0; k < 10; k++) {
    a[k] = b_self->Boundary[k];
  }
  freqsep = false;
  k = 0;
  do {
    exitg2 = 0;
    if (k + 1 < 11) {
      if (cv[static_cast<uint8_T>(a[k]) & 127] !=
          cv[static_cast<int32_T>(cv2[k])]) {
        exitg2 = 1;
      } else {
        k++;
      }
    } else {
      freqsep = true;
      exitg2 = 1;
    }
  } while (exitg2 == 0);
  if (freqsep) {
    if (b_self->SignalLength <= 100000.0) {
      NyquistRange_idx_1 = b_self->SignalLength / 2.0;
      NyquistRange_idx_1 = std::floor(NyquistRange_idx_1);
      b_self->SignalPad = NyquistRange_idx_1;
    } else {
      NyquistRange_idx_1 = b_log2(b_self->SignalLength);
      NyquistRange_idx_1 = std::ceil(NyquistRange_idx_1);
      b_self->SignalPad = NyquistRange_idx_1;
    }
  } else {
    b_self->SignalPad = 0.0;
  }
  NyquistRange_idx_1 = b_self->FrequencyLimits[0];
  b_b[0] = std::isnan(NyquistRange_idx_1);
  NyquistRange_idx_1 = b_self->FrequencyLimits[1];
  b_b[1] = std::isnan(NyquistRange_idx_1);
  freqsep = true;
  k = 0;
  exitg1 = false;
  while ((!exitg1) && (k < 2)) {
    if (!b_b[k]) {
      freqsep = false;
      exitg1 = true;
    } else {
      k++;
    }
  }
  if (!freqsep) {
    real_T FourierFactor;
    real_T be;
    real_T cutoff;
    real_T freqrange_idx_0;
    real_T freqrange_idx_1;
    real_T fs;
    real_T ga;
    real_T omegac;
    real_T varargin_1;
    real_T varargin_3;
    char_T b_wav[5];
    freqrange_idx_0 = b_self->FrequencyLimits[0];
    freqrange_idx_1 = b_self->FrequencyLimits[1];
    NyquistRange_idx_1 = b_self->SamplingFrequency / 2.0;
    emxInit_char_T(&tmpStr, 2, &ic_emlrtRTEI, true);
    if ((freqrange_idx_1 <= 0.0) || (freqrange_idx_0 >= NyquistRange_idx_1)) {
      b_tmpStr = nullptr;
      y = nullptr;
      m = emlrtCreateCharArray(2, &iv[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m, &u[0]);
      emlrtAssign(&y, m);
      b_y = nullptr;
      m1 = emlrtCreateCharArray(2, &iv1[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 2, m1, &formatSpec[0]);
      emlrtAssign(&b_y, m1);
      c_y = nullptr;
      m2 = emlrtCreateDoubleScalar(NyquistRange_idx_1);
      emlrtAssign(&c_y, m2);
      emlrtAssign(&b_tmpStr, feval(y, b_y, c_y, &emlrtMCI));
      emlrt_marshallIn(length(emlrtAlias(b_tmpStr), &b_emlrtMCI),
                       "<output of length>");
      emlrt_marshallIn(emlrtAlias(b_tmpStr), "tmpStr", tmpStr);
      emlrtDestroyArray(&b_tmpStr);
    }
    emxFree_char_T(&tmpStr);
    fs = b_self->SamplingFrequency;
    ga = b_self->Gamma;
    be = b_self->Beta;
    NyquistRange_idx_1 = b_self->SignalLength;
    varargin_3 = b_self->VoicesPerOctave;
    cutoff = b_self->CutOff;
    varargin_1 = b_self->SamplingFrequency;
    for (k = 0; k < 5; k++) {
      char_T c;
      c = b_self->Wavelet[k];
      wav[k] = cv[static_cast<uint8_T>(c) & 127];
    }
    omegac = 3.1415926535897931;
    cutoff /= 100.0;
    for (int32_T d{0}; d < 5; d++) {
      b_wav[d] = wav[d];
    }
    FourierFactor =
        wavelet::internal::cwt::wavCFandSD(b_wav, ga, be, &sigmat, &cf);
    sigmat = NyquistRange_idx_1 / (sigmat * 2.0);
    k = 0;
    do {
      exitg2 = 0;
      if (k + 1 < 6) {
        if (cv4[k] != wav[k]) {
          exitg2 = 1;
        } else {
          k++;
        }
      } else {
        freqsep = true;
        exitg2 = 1;
      }
    } while (exitg2 == 0);
    if (freqsep) {
      k = 0;
    } else {
      k = -1;
    }
    if (k == 0) {
      omegac =
          wavelet::internal::cwt::getFreqFromCutoffMorse(cutoff, cf, ga, be);
    }
    NyquistRange_idx_1 = omegac / 3.1415926535897931;
    if (sigmat < NyquistRange_idx_1 * rt_powd_snf(2.0, 1.0 / varargin_3)) {
      sigmat = NyquistRange_idx_1 * rt_powd_snf(2.0, 1.0 / varargin_3);
    }
    NyquistRange_idx_1 = 1.0 / (sigmat * FourierFactor) * varargin_1;
    if (freqrange_idx_0 < NyquistRange_idx_1) {
      b_self->FrequencyLimits[0] = NyquistRange_idx_1;
      freqrange_idx_0 = b_self->FrequencyLimits[0];
    }
    if (freqrange_idx_1 > fs / 2.0) {
      b_self->FrequencyLimits[1] = fs / 2.0;
      freqrange_idx_1 = b_self->FrequencyLimits[1];
    }
    freqsep = (b_log2(freqrange_idx_1) - b_log2(freqrange_idx_0) >=
               1.0 / b_self->VoicesPerOctave);
    if (!freqsep) {
      varargin_1 = 1.0 / b_self->VoicesPerOctave;
      c_tmpStr = nullptr;
      d_y = nullptr;
      m3 = emlrtCreateCharArray(2, &iv2[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m3, &u[0]);
      emlrtAssign(&d_y, m3);
      e_y = nullptr;
      m4 = emlrtCreateCharArray(2, &iv3[0]);
      emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 5, m4, &b_formatSpec[0]);
      emlrtAssign(&e_y, m4);
      f_y = nullptr;
      m5 = emlrtCreateDoubleScalar(varargin_1);
      emlrtAssign(&f_y, m5);
      emlrtAssign(&c_tmpStr, feval(d_y, e_y, f_y, &emlrtMCI));
      emlrt_marshallIn(length(emlrtAlias(c_tmpStr), &b_emlrtMCI),
                       "<output of length>");
      emxInit_char_T(&d_tmpStr, 2, &ic_emlrtRTEI, true);
      emlrt_marshallIn(emlrtAlias(c_tmpStr), "tmpStr", d_tmpStr);
      emxFree_char_T(&d_tmpStr);
      emlrtDestroyArray(&c_tmpStr);
    }
  }
  for (k = 0; k < 5; k++) {
    wav[k] = b_self->Wavelet[k];
  }
  freqsep = false;
  k = 0;
  do {
    exitg2 = 0;
    if (k + 1 < 6) {
      if (cv[static_cast<uint8_T>(wav[k]) & 127] !=
          cv[static_cast<int32_T>(cv3[k])]) {
        exitg2 = 1;
      } else {
        k++;
      }
    } else {
      freqsep = true;
      exitg2 = 1;
    }
  } while (exitg2 == 0);
  if (!freqsep) {
    b_self->CutOff = 10.0;
  }
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  return b_self;
}

} // namespace coder
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

static void emlrt_marshallIn(const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             emxArray_char_T *y)
{
  b_emlrt_marshallIn(emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
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

static const mxArray *length(const mxArray *m1, emlrtMCInfo *location)
{
  const mxArray *m;
  const mxArray *pArray;
  pArray = m1;
  return emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 1, &m, 1, &pArray, "length",
                               true, location);
}

//
//
namespace coder {
cwtfilterbank *cwtfilterbank_cwtfilterbank(cwtfilterbank *self,
                                           real_T varargin_4, real_T varargin_6,
                                           const real_T varargin_8[2],
                                           real_T varargin_10)
{
  static const char_T cv1[5]{'m', 'o', 'r', 's', 'e'};
  static const char_T cv2[5]{'M', 'o', 'r', 's', 'e'};
  cwtfilterbank *b_self;
  emxArray_real_T *absomega;
  emxArray_real_T *b_somega;
  emxArray_real_T *b_x;
  emxArray_real_T *b_y;
  emxArray_real_T *c_b;
  emxArray_real_T *c_y;
  emxArray_real_T *d_b;
  emxArray_real_T *d_y;
  emxArray_real_T *expnt;
  emxArray_real_T *f;
  emxArray_real_T *omega_tmp1;
  emxArray_real_T *omega_tmp2;
  emxArray_real_T *powscales;
  emxArray_real_T *psidft;
  emxArray_real_T *somega;
  emxArray_real_T *w;
  real_T N;
  real_T b;
  real_T be;
  real_T cf;
  real_T cutoff;
  real_T fo;
  real_T ga;
  int32_T b_i;
  int32_T exitg2;
  int32_T i;
  int32_T i2;
  int32_T loop_ub;
  int32_T nx;
  char_T x[5];
  boolean_T b_b[2];
  boolean_T exitg1;
  boolean_T y;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  b_self = self;
  b_self = cwtfilterbank_setProperties(b_self, varargin_4, varargin_6,
                                       varargin_8, varargin_10);
  N = b_self->SignalLength + 2.0 * b_self->SignalPad;
  b = std::trunc(N / 2.0);
  emxInit_real_T(&omega_tmp1, 2, &db_emlrtRTEI, true);
  if (std::isnan(b)) {
    i = omega_tmp1->size[0] * omega_tmp1->size[1];
    omega_tmp1->size[0] = 1;
    omega_tmp1->size[1] = 1;
    emxEnsureCapacity_real_T(omega_tmp1, i, &db_emlrtRTEI);
    omega_tmp1->data[0] = rtNaN;
  } else if (b < 1.0) {
    omega_tmp1->size[0] = 1;
    omega_tmp1->size[1] = 0;
  } else {
    i = omega_tmp1->size[0] * omega_tmp1->size[1];
    omega_tmp1->size[0] = 1;
    omega_tmp1->size[1] = static_cast<int32_T>(b - 1.0) + 1;
    emxEnsureCapacity_real_T(omega_tmp1, i, &db_emlrtRTEI);
    for (i = 0; i <= static_cast<int32_T>(b - 1.0); i++) {
      omega_tmp1->data[i] = static_cast<real_T>(i) + 1.0;
    }
  }
  emxInit_real_T(&omega_tmp2, 2, &eb_emlrtRTEI, true);
  i = omega_tmp2->size[0] * omega_tmp2->size[1];
  omega_tmp2->size[0] = 1;
  omega_tmp2->size[1] = omega_tmp1->size[1];
  emxEnsureCapacity_real_T(omega_tmp2, i, &eb_emlrtRTEI);
  cutoff = 6.2831853071795862 / N;
  for (i = 0; i < omega_tmp1->size[1]; i++) {
    omega_tmp2->data[i] = omega_tmp1->data[i] * cutoff;
  }
  emxFree_real_T(&omega_tmp1);
  b = std::trunc((N - 1.0) / 2.0);
  if (b < 1.0) {
    b_i = 0;
    nx = 1;
    i2 = -1;
  } else {
    b_i = static_cast<int32_T>(b) - 1;
    nx = -1;
    i2 = 0;
  }
  i = b_self->Omega->size[0] * b_self->Omega->size[1];
  b_self->Omega->size[0] = 1;
  b_self->Omega->size[1] = (omega_tmp2->size[1] + div_s32(i2 - b_i, nx)) + 2;
  emxEnsureCapacity_real_T(b_self->Omega, i, &fb_emlrtRTEI);
  b_self->Omega->data[0] = 0.0;
  loop_ub = omega_tmp2->size[1];
  for (i = 0; i < loop_ub; i++) {
    b_self->Omega->data[i + 1] = omega_tmp2->data[i];
  }
  loop_ub = div_s32(i2 - b_i, nx);
  for (i = 0; i <= loop_ub; i++) {
    b_self->Omega->data[(i + omega_tmp2->size[1]) + 1] =
        -omega_tmp2->data[b_i + nx * i];
  }
  emxFree_real_T(&omega_tmp2);
  cutoff = b_self->FrequencyLimits[0];
  b_b[0] = std::isnan(cutoff);
  cutoff = b_self->FrequencyLimits[1];
  b_b[1] = std::isnan(cutoff);
  y = true;
  i2 = 0;
  exitg1 = false;
  while ((!exitg1) && (i2 < 2)) {
    if (!b_b[i2]) {
      y = false;
      exitg1 = true;
    } else {
      i2++;
    }
  }
  if (!y) {
    real_T nv;
    real_T omegac;
    char_T c_x[5];
    cutoff = b_self->FrequencyLimits[0];
    cutoff /= b_self->SamplingFrequency;
    cutoff = cutoff * 2.0 * 3.1415926535897931;
    omegac = cutoff;
    cutoff = b_self->FrequencyLimits[1];
    cutoff /= b_self->SamplingFrequency;
    cutoff = cutoff * 2.0 * 3.1415926535897931;
    nv = b_self->VoicesPerOctave;
    N = rt_powd_snf(2.0, 1.0 / nv);
    for (int32_T d{0}; d < 5; d++) {
      c_x[d] = b_self->Wavelet[d];
    }
    wavelet::internal::cwt::wavCFandSD(c_x, b_self->Gamma, b_self->Beta, &fo,
                                       &cf);
    fo = cf / cutoff;
    emxInit_real_T(&b_y, 2, &wb_emlrtRTEI, true);
    b = nv * b_log2(cf / omegac / fo);
    if (std::isnan(b)) {
      i = b_y->size[0] * b_y->size[1];
      b_y->size[0] = 1;
      b_y->size[1] = 1;
      emxEnsureCapacity_real_T(b_y, i, &gb_emlrtRTEI);
      b_y->data[0] = rtNaN;
    } else if (b < 0.0) {
      b_y->size[0] = 1;
      b_y->size[1] = 0;
    } else {
      i = b_y->size[0] * b_y->size[1];
      b_y->size[0] = 1;
      b_y->size[1] = static_cast<int32_T>(b) + 1;
      emxEnsureCapacity_real_T(b_y, i, &gb_emlrtRTEI);
      for (i = 0; i <= static_cast<int32_T>(b); i++) {
        b_y->data[i] = i;
      }
    }
    emxInit_real_T(&c_b, 2, &xb_emlrtRTEI, true);
    i = c_b->size[0] * c_b->size[1];
    c_b->size[0] = 1;
    c_b->size[1] = b_y->size[1];
    emxEnsureCapacity_real_T(c_b, i, &o_emlrtRTEI);
    nx = b_y->size[1];
    for (i2 = 0; i2 < nx; i2++) {
      c_b->data[i2] = rt_powd_snf(N, b_y->data[i2]);
    }
    emxFree_real_T(&b_y);
    i = b_self->Scales->size[0] * b_self->Scales->size[1];
    b_self->Scales->size[0] = 1;
    b_self->Scales->size[1] = c_b->size[1];
    emxEnsureCapacity_real_T(b_self->Scales, i, &hb_emlrtRTEI);
    for (i = 0; i < c_b->size[1]; i++) {
      b_self->Scales->data[i] = fo * c_b->data[i];
    }
    emxFree_real_T(&c_b);
  } else {
    real_T nv;
    real_T omegac;
    char_T c_x[5];
    N = b_self->SignalLength;
    ga = b_self->Gamma;
    be = b_self->Beta;
    nv = b_self->VoicesPerOctave;
    cutoff = b_self->CutOff;
    for (i2 = 0; i2 < 5; i2++) {
      char_T c;
      c = b_self->Wavelet[i2];
      x[i2] = cv[static_cast<uint8_T>(c) & 127];
    }
    omegac = 3.1415926535897931;
    cutoff /= 100.0;
    for (int32_T e{0}; e < 5; e++) {
      c_x[e] = x[e];
    }
    wavelet::internal::cwt::wavCFandSD(c_x, ga, be, &fo, &cf);
    b = N / (fo * 2.0);
    y = false;
    nx = 0;
    do {
      exitg2 = 0;
      if (nx + 1 < 6) {
        if (cv1[nx] != x[nx]) {
          exitg2 = 1;
        } else {
          nx++;
        }
      } else {
        y = true;
        exitg2 = 1;
      }
    } while (exitg2 == 0);
    if (y) {
      nx = 0;
    } else {
      nx = -1;
    }
    if (nx == 0) {
      omegac =
          wavelet::internal::cwt::getFreqFromCutoffMorse(cutoff, cf, ga, be);
    }
    fo = omegac / 3.1415926535897931;
    if (b < fo * rt_powd_snf(2.0, 1.0 / nv)) {
      b = fo * rt_powd_snf(2.0, 1.0 / nv);
    }
    N = rt_powd_snf(2.0, 1.0 / nv);
    emxInit_real_T(&c_y, 2, &ac_emlrtRTEI, true);
    b = std::fmax(b_log2(b / fo), 1.0 / nv) * nv;
    if (std::isnan(b)) {
      i = c_y->size[0] * c_y->size[1];
      c_y->size[0] = 1;
      c_y->size[1] = 1;
      emxEnsureCapacity_real_T(c_y, i, &gb_emlrtRTEI);
      c_y->data[0] = rtNaN;
    } else if (b < 0.0) {
      c_y->size[0] = 1;
      c_y->size[1] = 0;
    } else {
      i = c_y->size[0] * c_y->size[1];
      c_y->size[0] = 1;
      c_y->size[1] = static_cast<int32_T>(b) + 1;
      emxEnsureCapacity_real_T(c_y, i, &gb_emlrtRTEI);
      for (i = 0; i <= static_cast<int32_T>(b); i++) {
        c_y->data[i] = i;
      }
    }
    emxInit_real_T(&d_b, 2, &dc_emlrtRTEI, true);
    i = d_b->size[0] * d_b->size[1];
    d_b->size[0] = 1;
    d_b->size[1] = c_y->size[1];
    emxEnsureCapacity_real_T(d_b, i, &o_emlrtRTEI);
    nx = c_y->size[1];
    for (i2 = 0; i2 < nx; i2++) {
      d_b->data[i2] = rt_powd_snf(N, c_y->data[i2]);
    }
    emxFree_real_T(&c_y);
    i = b_self->Scales->size[0] * b_self->Scales->size[1];
    b_self->Scales->size[0] = 1;
    b_self->Scales->size[1] = d_b->size[1];
    emxEnsureCapacity_real_T(b_self->Scales, i, &ib_emlrtRTEI);
    for (i = 0; i < d_b->size[1]; i++) {
      b_self->Scales->data[i] = fo * d_b->data[i];
    }
    emxFree_real_T(&d_b);
  }
  for (i = 0; i < 5; i++) {
    x[i] = b_self->Wavelet[i];
  }
  y = false;
  nx = 0;
  do {
    exitg2 = 0;
    if (nx + 1 < 6) {
      if (cv[static_cast<uint8_T>(x[nx]) & 127] !=
          cv[static_cast<int32_T>(cv2[nx])]) {
        exitg2 = 1;
      } else {
        nx++;
      }
    } else {
      y = true;
      exitg2 = 1;
    }
  } while (exitg2 == 0);
  emxInit_real_T(&psidft, 2, &gc_emlrtRTEI, true);
  emxInit_real_T(&f, 2, &hc_emlrtRTEI, true);
  if (y) {
    ga = b_self->Gamma;
    be = b_self->Beta;
    emxInit_real_T(&b_somega, 2, &bc_emlrtRTEI, true);
    if (b_self->Scales->size[1] == 1) {
      bsxfun(b_self->Scales, b_self->Omega, b_somega);
    } else {
      i = b_somega->size[0] * b_somega->size[1];
      b_somega->size[0] = b_self->Scales->size[1];
      b_somega->size[1] = b_self->Omega->size[1];
      emxEnsureCapacity_real_T(b_somega, i, &lb_emlrtRTEI);
      loop_ub = b_self->Omega->size[1];
      for (i = 0; i < loop_ub; i++) {
        nx = b_self->Scales->size[1];
        for (i2 = 0; i2 < nx; i2++) {
          b_somega->data[i2 + b_somega->size[0] * i] =
              b_self->Scales->data[i2] * b_self->Omega->data[i];
        }
      }
    }
    fo = std::exp(1.0 / ga * (std::log(be) - std::log(ga)));
    nx = b_somega->size[0] * b_somega->size[1];
    emxInit_real_T(&absomega, 2, &ec_emlrtRTEI, true);
    i = absomega->size[0] * absomega->size[1];
    absomega->size[0] = b_somega->size[0];
    absomega->size[1] = b_somega->size[1];
    emxEnsureCapacity_real_T(absomega, i, &n_emlrtRTEI);
    for (i2 = 0; i2 < nx; i2++) {
      absomega->data[i2] = std::abs(b_somega->data[i2]);
    }
    emxInit_real_T(&powscales, 2, &nb_emlrtRTEI, true);
    if (ga == 3.0) {
      i = powscales->size[0] * powscales->size[1];
      powscales->size[0] = absomega->size[0];
      powscales->size[1] = absomega->size[1];
      emxEnsureCapacity_real_T(powscales, i, &nb_emlrtRTEI);
      for (i = 0; i < absomega->size[0] * absomega->size[1]; i++) {
        powscales->data[i] =
            absomega->data[i] * absomega->data[i] * absomega->data[i];
      }
    } else {
      i = powscales->size[0] * powscales->size[1];
      powscales->size[0] = absomega->size[0];
      powscales->size[1] = absomega->size[1];
      emxEnsureCapacity_real_T(powscales, i, &o_emlrtRTEI);
      nx = absomega->size[0] * absomega->size[1];
      for (i2 = 0; i2 < nx; i2++) {
        powscales->data[i2] = rt_powd_snf(absomega->data[i2], ga);
      }
    }
    nx = absomega->size[0] * absomega->size[1];
    for (i2 = 0; i2 < nx; i2++) {
      absomega->data[i2] = std::log(absomega->data[i2]);
    }
    b = 2.0 * std::exp(-be * std::log(fo) + rt_powd_snf(fo, ga));
    emxInit_real_T(&b_x, 2, &ob_emlrtRTEI, true);
    if ((absomega->size[0] == powscales->size[0]) &&
        (absomega->size[1] == powscales->size[1])) {
      i = b_x->size[0] * b_x->size[1];
      b_x->size[0] = absomega->size[0];
      b_x->size[1] = absomega->size[1];
      emxEnsureCapacity_real_T(b_x, i, &ob_emlrtRTEI);
      for (i = 0; i < absomega->size[0] * absomega->size[1]; i++) {
        b_x->data[i] = be * absomega->data[i] - powscales->data[i];
      }
    } else {
      binary_expand_op_2(b_x, be, absomega, powscales);
    }
    emxFree_real_T(&powscales);
    emxFree_real_T(&absomega);
    nx = b_x->size[0] * b_x->size[1];
    for (i2 = 0; i2 < nx; i2++) {
      b_x->data[i2] = std::exp(b_x->data[i2]);
    }
    if ((b_x->size[0] == b_somega->size[0]) &&
        (b_x->size[1] == b_somega->size[1])) {
      i = psidft->size[0] * psidft->size[1];
      psidft->size[0] = b_x->size[0];
      psidft->size[1] = b_x->size[1];
      emxEnsureCapacity_real_T(psidft, i, &rb_emlrtRTEI);
      for (i = 0; i < b_x->size[0] * b_x->size[1]; i++) {
        psidft->data[i] =
            b * b_x->data[i] * static_cast<real_T>(b_somega->data[i] > 0.0);
      }
    } else {
      binary_expand_op_1(psidft, b, b_x, b_somega);
    }
    emxFree_real_T(&b_x);
    emxFree_real_T(&b_somega);
    i = f->size[0] * f->size[1];
    f->size[0] = 1;
    f->size[1] = b_self->Scales->size[1];
    emxEnsureCapacity_real_T(f, i, &sb_emlrtRTEI);
    for (i = 0; i < b_self->Scales->size[1]; i++) {
      f->data[i] = fo / b_self->Scales->data[i] / 6.2831853071795862;
    }
  } else {
    emxInit_real_T(&somega, 2, &yb_emlrtRTEI, true);
    if (b_self->Scales->size[1] == 1) {
      bsxfun(b_self->Scales, b_self->Omega, somega);
    } else {
      i = somega->size[0] * somega->size[1];
      somega->size[0] = b_self->Scales->size[1];
      somega->size[1] = b_self->Omega->size[1];
      emxEnsureCapacity_real_T(somega, i, &jb_emlrtRTEI);
      loop_ub = b_self->Omega->size[1];
      for (i = 0; i < loop_ub; i++) {
        nx = b_self->Scales->size[1];
        for (i2 = 0; i2 < nx; i2++) {
          somega->data[i2 + somega->size[0] * i] =
              b_self->Scales->data[i2] * b_self->Omega->data[i];
        }
      }
    }
    emxInit_real_T(&w, 2, &kb_emlrtRTEI, true);
    i = w->size[0] * w->size[1];
    w->size[0] = somega->size[0];
    w->size[1] = somega->size[1];
    emxEnsureCapacity_real_T(w, i, &kb_emlrtRTEI);
    for (i = 0; i < somega->size[0] * somega->size[1]; i++) {
      w->data[i] = (somega->data[i] - 5.0) / 0.6;
    }
    emxFree_real_T(&somega);
    emxInit_real_T(&expnt, 2, &cc_emlrtRTEI, true);
    i = expnt->size[0] * expnt->size[1];
    expnt->size[0] = w->size[0];
    expnt->size[1] = w->size[1];
    emxEnsureCapacity_real_T(expnt, i, &mb_emlrtRTEI);
    for (i = 0; i < w->size[0] * w->size[1]; i++) {
      expnt->data[i] = -1.0 / (1.0 - w->data[i] * w->data[i]);
    }
    nx = expnt->size[0] * expnt->size[1];
    for (i2 = 0; i2 < nx; i2++) {
      expnt->data[i2] = std::exp(expnt->data[i2]);
    }
    nx = w->size[0] * w->size[1];
    emxInit_real_T(&d_y, 2, &fc_emlrtRTEI, true);
    i = d_y->size[0] * d_y->size[1];
    d_y->size[0] = w->size[0];
    d_y->size[1] = w->size[1];
    emxEnsureCapacity_real_T(d_y, i, &n_emlrtRTEI);
    for (i2 = 0; i2 < nx; i2++) {
      d_y->data[i2] = std::abs(w->data[i2]);
    }
    emxFree_real_T(&w);
    if ((expnt->size[0] == d_y->size[0]) && (expnt->size[1] == d_y->size[1])) {
      i = psidft->size[0] * psidft->size[1];
      psidft->size[0] = expnt->size[0];
      psidft->size[1] = expnt->size[1];
      emxEnsureCapacity_real_T(psidft, i, &pb_emlrtRTEI);
      for (i = 0; i < expnt->size[0] * expnt->size[1]; i++) {
        psidft->data[i] =
            5.43656365691809 * expnt->data[i] *
            static_cast<real_T>(d_y->data[i] < 0.99999999999999978);
      }
    } else {
      binary_expand_op_3(psidft, expnt, d_y);
    }
    emxFree_real_T(&d_y);
    emxFree_real_T(&expnt);
    nx = psidft->size[0] * psidft->size[1] - 1;
    for (b_i = 0; b_i <= nx; b_i++) {
      if (std::isnan(psidft->data[b_i])) {
        psidft->data[b_i] = 0.0;
      }
    }
    i = f->size[0] * f->size[1];
    f->size[0] = 1;
    f->size[1] = b_self->Scales->size[1];
    emxEnsureCapacity_real_T(f, i, &qb_emlrtRTEI);
    for (i = 0; i < b_self->Scales->size[1]; i++) {
      f->data[i] = 0.79577471545947676 / b_self->Scales->data[i];
    }
  }
  i = f->size[0] * f->size[1];
  f->size[0] = 1;
  emxEnsureCapacity_real_T(f, i, &tb_emlrtRTEI);
  i = f->size[1] - 1;
  for (i2 = 0; i2 <= i; i2++) {
    f->data[i2] *= b_self->SamplingFrequency;
  }
  i = b_self->PsiDFT->size[0] * b_self->PsiDFT->size[1];
  b_self->PsiDFT->size[0] = psidft->size[0];
  b_self->PsiDFT->size[1] = psidft->size[1];
  emxEnsureCapacity_real_T(b_self->PsiDFT, i, &ub_emlrtRTEI);
  for (i = 0; i < psidft->size[0] * psidft->size[1]; i++) {
    b_self->PsiDFT->data[i] = psidft->data[i];
  }
  emxFree_real_T(&psidft);
  i = b_self->WaveletCenterFrequencies->size[0];
  b_self->WaveletCenterFrequencies->size[0] = f->size[1];
  emxEnsureCapacity_real_T(b_self->WaveletCenterFrequencies, i, &vb_emlrtRTEI);
  for (i = 0; i < f->size[1]; i++) {
    b_self->WaveletCenterFrequencies->data[i] = f->data[i];
  }
  emxFree_real_T(&f);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  return b_self;
}

} // namespace coder

// End of code generation (cwtfilterbank.cu)
