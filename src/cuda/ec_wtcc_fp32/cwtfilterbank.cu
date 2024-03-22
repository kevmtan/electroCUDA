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
#include "cwtfreqlimits.h"
#include "ec_wtcc_data.h"
#include "ec_wtcc_emxutil.h"
#include "ec_wtcc_mexutil.h"
#include "ec_wtcc_types.h"
#include "log2.h"
#include "rt_nonfinite.h"
#include "wavCFandSD.h"
#include "wavbpfilters.h"
#include <cmath>

// Variable Definitions
static emlrtMCInfo b_emlrtMCI{
    53,                                                                // lineNo
    14,                                                                // colNo
    "nonConstPrint",                                                   // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/strfun/sprintf.m" // pName
};

static emlrtMCInfo c_emlrtMCI{
    55,                                                                // lineNo
    15,                                                                // colNo
    "nonConstPrint",                                                   // fName
    "/usr/local/MATLAB/R2024a/toolbox/eml/lib/matlab/strfun/sprintf.m" // pName
};

static emlrtRTEInfo wb_emlrtRTEI{
    999,             // lineNo
    17,              // colNo
    "cwtfilterbank", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "cwtfilterbank.m" // pName
};

static emlrtRTEInfo xb_emlrtRTEI{
    1000,            // lineNo
    17,              // colNo
    "cwtfilterbank", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "cwtfilterbank.m" // pName
};

static emlrtRTEInfo yb_emlrtRTEI{
    1009,            // lineNo
    13,              // colNo
    "cwtfilterbank", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "cwtfilterbank.m" // pName
};

static emlrtRTEInfo ac_emlrtRTEI{
    1278,            // lineNo
    13,              // colNo
    "cwtfilterbank", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "cwtfilterbank.m" // pName
};

static emlrtRTEInfo bc_emlrtRTEI{
    952,             // lineNo
    34,              // colNo
    "cwtfilterbank", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "cwtfilterbank.m" // pName
};

static emlrtRTEInfo cc_emlrtRTEI{
    952,             // lineNo
    45,              // colNo
    "cwtfilterbank", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "cwtfilterbank.m" // pName
};

static emlrtRTEInfo dc_emlrtRTEI{
    217,             // lineNo
    21,              // colNo
    "cwtfilterbank", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "cwtfilterbank.m" // pName
};

static emlrtRTEInfo ec_emlrtRTEI{
    18,             // lineNo
    5,              // colNo
    "wavbpfilters", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "wavbpfilters.m" // pName
};

static emlrtRTEInfo gc_emlrtRTEI{
    31,             // lineNo
    9,              // colNo
    "wavbpfilters", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "wavbpfilters.m" // pName
};

static emlrtRTEInfo hc_emlrtRTEI{
    26,             // lineNo
    9,              // colNo
    "wavbpfilters", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "wavbpfilters.m" // pName
};

static emlrtRTEInfo ic_emlrtRTEI{
    33,             // lineNo
    9,              // colNo
    "wavbpfilters", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "wavbpfilters.m" // pName
};

static emlrtRTEInfo jc_emlrtRTEI{
    27,             // lineNo
    9,              // colNo
    "wavbpfilters", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "wavbpfilters.m" // pName
};

static emlrtRTEInfo kc_emlrtRTEI{
    956,             // lineNo
    13,              // colNo
    "cwtfilterbank", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "cwtfilterbank.m" // pName
};

static emlrtRTEInfo lc_emlrtRTEI{
    227,             // lineNo
    13,              // colNo
    "cwtfilterbank", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "cwtfilterbank.m" // pName
};

static emlrtRTEInfo nc_emlrtRTEI{
    228,             // lineNo
    13,              // colNo
    "cwtfilterbank", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "cwtfilterbank.m" // pName
};

static emlrtRTEInfo oc_emlrtRTEI{
    1276,            // lineNo
    30,              // colNo
    "cwtfilterbank", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "cwtfilterbank.m" // pName
};

static emlrtRTEInfo pc_emlrtRTEI{
    1276,            // lineNo
    25,              // colNo
    "cwtfilterbank", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "cwtfilterbank.m" // pName
};

static emlrtRTEInfo qc_emlrtRTEI{
    16,             // lineNo
    5,              // colNo
    "wavbpfilters", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "wavbpfilters.m" // pName
};

static emlrtRTEInfo rc_emlrtRTEI{
    32,             // lineNo
    18,             // colNo
    "getCWTScales", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "getCWTScales.m" // pName
};

static emlrtRTEInfo sc_emlrtRTEI{
    32,             // lineNo
    13,             // colNo
    "getCWTScales", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "getCWTScales.m" // pName
};

static emlrtRTEInfo tc_emlrtRTEI{
    34,             // lineNo
    42,             // colNo
    "wavbpfilters", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/+wavelet/+internal/+cwt/"
    "wavbpfilters.m" // pName
};

static emlrtRTEInfo uc_emlrtRTEI{
    934,             // lineNo
    26,              // colNo
    "cwtfilterbank", // fName
    "/usr/local/MATLAB/R2024a/toolbox/wavelet/wavelet/@cwtfilterbank/"
    "cwtfilterbank.m" // pName
};

static emlrtRTEInfo vc_emlrtRTEI{
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
                                                  real_T varargin_2,
                                                  const real_T varargin_6[2],
                                                  real_T varargin_8,
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
                                                  real_T varargin_2,
                                                  const real_T varargin_6[2],
                                                  real_T varargin_8,
                                                  real_T varargin_10)
{
  static const int32_T iv[2]{1, 7};
  static const int32_T iv1[2]{1, 2};
  static const int32_T iv2[2]{1, 7};
  static const int32_T iv3[2]{1, 5};
  static const char_T b[10]{'r', 'e', 'f', 'l', 'e', 'c', 't', 'i', 'o', 'n'};
  static const char_T cv2[10]{'r', 'e', 'f', 'l', 'e', 'c', 't', 'i', 'o', 'n'};
  static const char_T u[7]{'s', 'p', 'r', 'i', 'n', 't', 'f'};
  static const char_T b_formatSpec[5]{'%', '2', '.', '2', 'f'};
  static const char_T cv3[4]{'b', 'u', 'm', 'p'};
  static const char_T cv4[4]{'a', 'm', 'o', 'r'};
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
  boolean_T b_b[2];
  boolean_T exitg1;
  boolean_T freqsep;
  boolean_T guard1;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  b_self = self;
  b_self->CutOff = 50.0;
  b_self->Gamma = 3.0;
  b_self->Beta = 20.0;
  b_self->Wavelet[0] = 'a';
  b_self->Wavelet[1] = 'm';
  b_self->Wavelet[2] = 'o';
  b_self->Wavelet[3] = 'r';
  b_self->TimeBandwidth = rtNaN;
  b_self->SignalLength = varargin_2;
  NyquistRange_idx_1 = b_self->SignalLength / 2.0;
  NyquistRange_idx_1 = std::floor(NyquistRange_idx_1);
  b_self->SignalPad = NyquistRange_idx_1;
  b_self->VoicesPerOctave = varargin_10;
  b_self->SamplingFrequency = varargin_8;
  b_self->WaveletParameters[0] = rtNaN;
  b_self->FrequencyLimits[0] = varargin_6[0];
  b_self->WaveletParameters[1] = rtNaN;
  b_self->FrequencyLimits[1] = varargin_6[1];
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
    char_T b_wav[4];
    char_T wav[4];
    char_T c;
    freqrange_idx_0 = b_self->FrequencyLimits[0];
    freqrange_idx_1 = b_self->FrequencyLimits[1];
    NyquistRange_idx_1 = b_self->SamplingFrequency / 2.0;
    emxInit_char_T(&tmpStr, 2, &vc_emlrtRTEI, true);
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
      emlrtAssign(&b_tmpStr, feval(y, b_y, c_y, &b_emlrtMCI));
      emlrt_marshallIn(length(emlrtAlias(b_tmpStr), &c_emlrtMCI),
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
    c = b_self->Wavelet[0];
    wav[0] = cv[static_cast<uint8_T>(c) & 127];
    c = b_self->Wavelet[1];
    wav[1] = cv[static_cast<uint8_T>(c) & 127];
    c = b_self->Wavelet[2];
    wav[2] = cv[static_cast<uint8_T>(c) & 127];
    c = b_self->Wavelet[3];
    wav[3] = cv[static_cast<uint8_T>(c) & 127];
    omegac = 3.1415926535897931;
    cutoff /= 100.0;
    b_wav[0] = wav[0];
    b_wav[1] = wav[1];
    b_wav[2] = wav[2];
    b_wav[3] = wav[3];
    FourierFactor =
        wavelet::internal::cwt::wavCFandSD(b_wav, ga, be, &sigmat, &cf);
    sigmat = NyquistRange_idx_1 / (sigmat * 2.0);
    k = 0;
    do {
      exitg2 = 0;
      if (k + 1 < 5) {
        if (cv3[k] != wav[k]) {
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
      k = 1;
    } else {
      k = 0;
      do {
        exitg2 = 0;
        if (k + 1 < 5) {
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
        k = 2;
      } else {
        k = -1;
      }
    }
    switch (k) {
    case 0:
      omegac =
          wavelet::internal::cwt::getFreqFromCutoffMorse(cutoff, cf, ga, be);
      break;
    case 1:
      omegac = wavelet::internal::cwt::getFreqFromCutoffBump(cutoff, cf);
      break;
    case 2:
      omegac = wavelet::internal::cwt::getFreqFromCutoffAmor(cutoff, cf);
      break;
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
      emlrtAssign(&c_tmpStr, feval(d_y, e_y, f_y, &b_emlrtMCI));
      emlrt_marshallIn(length(emlrtAlias(c_tmpStr), &c_emlrtMCI),
                       "<output of length>");
      emxInit_char_T(&d_tmpStr, 2, &vc_emlrtRTEI, true);
      emlrt_marshallIn(emlrtAlias(c_tmpStr), "tmpStr", d_tmpStr);
      emxFree_char_T(&d_tmpStr);
      emlrtDestroyArray(&c_tmpStr);
    }
  }
  b_self->CutOff = 10.0;
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
                                           real_T varargin_2,
                                           const real_T varargin_6[2],
                                           real_T varargin_8,
                                           real_T varargin_10)
{
  static const char_T cv1[4]{'b', 'u', 'm', 'p'};
  static const char_T cv2[4]{'a', 'm', 'o', 'r'};
  cwtfilterbank *b_self;
  emxArray_real_T *b_y;
  emxArray_real_T *c_b;
  emxArray_real_T *c_y;
  emxArray_real_T *d_b;
  emxArray_real_T *d_y;
  emxArray_real_T *daughter;
  emxArray_real_T *expnt;
  emxArray_real_T *f;
  emxArray_real_T *omega;
  emxArray_real_T *omega_tmp1;
  emxArray_real_T *omega_tmp2;
  emxArray_real_T *scales;
  emxArray_real_T *somega;
  emxArray_real_T *w;
  real_T N;
  real_T b;
  real_T cf;
  real_T ga;
  real_T nbSamp;
  int32_T b_i;
  int32_T exitg2;
  int32_T fc;
  int32_T i;
  int32_T loop_ub;
  int32_T nx;
  char_T wname[4];
  boolean_T b_b[2];
  boolean_T exitg1;
  boolean_T y;
  emlrtHeapReferenceStackEnterFcnR2012b(emlrtRootTLSGlobal);
  b_self = self;
  b_self = cwtfilterbank_setProperties(b_self, varargin_2, varargin_6,
                                       varargin_8, varargin_10);
  N = b_self->SignalLength + 2.0 * b_self->SignalPad;
  b = std::trunc(N / 2.0);
  emxInit_real_T(&omega_tmp1, 2, &wb_emlrtRTEI, true);
  if (std::isnan(b)) {
    i = omega_tmp1->size[0] * omega_tmp1->size[1];
    omega_tmp1->size[0] = 1;
    omega_tmp1->size[1] = 1;
    emxEnsureCapacity_real_T(omega_tmp1, i, &wb_emlrtRTEI);
    omega_tmp1->data[0] = rtNaN;
  } else if (b < 1.0) {
    omega_tmp1->size[0] = 1;
    omega_tmp1->size[1] = 0;
  } else {
    i = omega_tmp1->size[0] * omega_tmp1->size[1];
    omega_tmp1->size[0] = 1;
    omega_tmp1->size[1] = static_cast<int32_T>(b - 1.0) + 1;
    emxEnsureCapacity_real_T(omega_tmp1, i, &wb_emlrtRTEI);
    for (i = 0; i <= static_cast<int32_T>(b - 1.0); i++) {
      omega_tmp1->data[i] = static_cast<real_T>(i) + 1.0;
    }
  }
  emxInit_real_T(&omega_tmp2, 2, &xb_emlrtRTEI, true);
  i = omega_tmp2->size[0] * omega_tmp2->size[1];
  omega_tmp2->size[0] = 1;
  omega_tmp2->size[1] = omega_tmp1->size[1];
  emxEnsureCapacity_real_T(omega_tmp2, i, &xb_emlrtRTEI);
  nbSamp = 6.2831853071795862 / N;
  for (i = 0; i < omega_tmp1->size[1]; i++) {
    omega_tmp2->data[i] = omega_tmp1->data[i] * nbSamp;
  }
  emxFree_real_T(&omega_tmp1);
  N = std::trunc((N - 1.0) / 2.0);
  if (N < 1.0) {
    b_i = 0;
    nx = 1;
    fc = -1;
  } else {
    b_i = static_cast<int32_T>(N) - 1;
    nx = -1;
    fc = 0;
  }
  i = b_self->Omega->size[0] * b_self->Omega->size[1];
  b_self->Omega->size[0] = 1;
  b_self->Omega->size[1] = (omega_tmp2->size[1] + div_s32(fc - b_i, nx)) + 2;
  emxEnsureCapacity_real_T(b_self->Omega, i, &yb_emlrtRTEI);
  b_self->Omega->data[0] = 0.0;
  loop_ub = omega_tmp2->size[1];
  for (i = 0; i < loop_ub; i++) {
    b_self->Omega->data[i + 1] = omega_tmp2->data[i];
  }
  loop_ub = div_s32(fc - b_i, nx);
  for (i = 0; i <= loop_ub; i++) {
    b_self->Omega->data[(i + omega_tmp2->size[1]) + 1] =
        -omega_tmp2->data[b_i + nx * i];
  }
  emxFree_real_T(&omega_tmp2);
  nbSamp = b_self->FrequencyLimits[0];
  b_b[0] = std::isnan(nbSamp);
  nbSamp = b_self->FrequencyLimits[1];
  b_b[1] = std::isnan(nbSamp);
  y = true;
  loop_ub = 0;
  exitg1 = false;
  while ((!exitg1) && (loop_ub < 2)) {
    if (!b_b[loop_ub]) {
      y = false;
      exitg1 = true;
    } else {
      loop_ub++;
    }
  }
  if (!y) {
    real_T frange_idx_0;
    real_T nv;
    char_T b_wname[4];
    nbSamp = b_self->FrequencyLimits[0];
    nbSamp /= b_self->SamplingFrequency;
    nbSamp = nbSamp * 2.0 * 3.1415926535897931;
    frange_idx_0 = nbSamp;
    nbSamp = b_self->FrequencyLimits[1];
    nbSamp /= b_self->SamplingFrequency;
    nbSamp = nbSamp * 2.0 * 3.1415926535897931;
    nv = b_self->VoicesPerOctave;
    ga = rt_powd_snf(2.0, 1.0 / nv);
    b_wname[0] = b_self->Wavelet[0];
    b_wname[1] = b_self->Wavelet[1];
    b_wname[2] = b_self->Wavelet[2];
    b_wname[3] = b_self->Wavelet[3];
    wavelet::internal::cwt::wavCFandSD(b_wname, b_self->Gamma, b_self->Beta, &b,
                                       &cf);
    N = cf / nbSamp;
    emxInit_real_T(&b_y, 2, &oc_emlrtRTEI, true);
    b = nv * b_log2(cf / frange_idx_0 / N);
    if (std::isnan(b)) {
      i = b_y->size[0] * b_y->size[1];
      b_y->size[0] = 1;
      b_y->size[1] = 1;
      emxEnsureCapacity_real_T(b_y, i, &n_emlrtRTEI);
      b_y->data[0] = rtNaN;
    } else if (b < 0.0) {
      b_y->size[0] = 1;
      b_y->size[1] = 0;
    } else {
      i = b_y->size[0] * b_y->size[1];
      b_y->size[0] = 1;
      b_y->size[1] = static_cast<int32_T>(b) + 1;
      emxEnsureCapacity_real_T(b_y, i, &n_emlrtRTEI);
      for (i = 0; i <= static_cast<int32_T>(b); i++) {
        b_y->data[i] = i;
      }
    }
    emxInit_real_T(&c_b, 2, &pc_emlrtRTEI, true);
    i = c_b->size[0] * c_b->size[1];
    c_b->size[0] = 1;
    c_b->size[1] = b_y->size[1];
    emxEnsureCapacity_real_T(c_b, i, &kb_emlrtRTEI);
    nx = b_y->size[1];
    for (loop_ub = 0; loop_ub < nx; loop_ub++) {
      c_b->data[loop_ub] = rt_powd_snf(ga, b_y->data[loop_ub]);
    }
    emxFree_real_T(&b_y);
    i = b_self->Scales->size[0] * b_self->Scales->size[1];
    b_self->Scales->size[0] = 1;
    b_self->Scales->size[1] = c_b->size[1];
    emxEnsureCapacity_real_T(b_self->Scales, i, &ac_emlrtRTEI);
    for (i = 0; i < c_b->size[1]; i++) {
      b_self->Scales->data[i] = N * c_b->data[i];
    }
    emxFree_real_T(&c_b);
  } else {
    real_T be;
    real_T frange_idx_0;
    real_T nv;
    real_T omegac;
    char_T b_wname[4];
    char_T c;
    nbSamp = b_self->SignalLength;
    ga = b_self->Gamma;
    be = b_self->Beta;
    nv = b_self->VoicesPerOctave;
    N = b_self->CutOff;
    c = b_self->Wavelet[0];
    wname[0] = cv[static_cast<uint8_T>(c) & 127];
    c = b_self->Wavelet[1];
    wname[1] = cv[static_cast<uint8_T>(c) & 127];
    c = b_self->Wavelet[2];
    wname[2] = cv[static_cast<uint8_T>(c) & 127];
    c = b_self->Wavelet[3];
    wname[3] = cv[static_cast<uint8_T>(c) & 127];
    omegac = 3.1415926535897931;
    frange_idx_0 = N / 100.0;
    b_wname[0] = wname[0];
    b_wname[1] = wname[1];
    b_wname[2] = wname[2];
    b_wname[3] = wname[3];
    wavelet::internal::cwt::wavCFandSD(b_wname, ga, be, &b, &cf);
    b = nbSamp / (b * 2.0);
    y = false;
    nx = 0;
    do {
      exitg2 = 0;
      if (nx + 1 < 5) {
        if (cv1[nx] != wname[nx]) {
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
      nx = 1;
    } else {
      nx = 0;
      do {
        exitg2 = 0;
        if (nx + 1 < 5) {
          if (cv2[nx] != wname[nx]) {
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
        nx = 2;
      } else {
        nx = -1;
      }
    }
    switch (nx) {
    case 0:
      omegac = wavelet::internal::cwt::getFreqFromCutoffMorse(frange_idx_0, cf,
                                                              ga, be);
      break;
    case 1:
      omegac = wavelet::internal::cwt::getFreqFromCutoffBump(frange_idx_0, cf);
      break;
    case 2:
      omegac = wavelet::internal::cwt::getFreqFromCutoffAmor(frange_idx_0, cf);
      break;
    }
    N = omegac / 3.1415926535897931;
    if (b < N * rt_powd_snf(2.0, 1.0 / nv)) {
      b = N * rt_powd_snf(2.0, 1.0 / nv);
    }
    ga = rt_powd_snf(2.0, 1.0 / nv);
    emxInit_real_T(&c_y, 2, &rc_emlrtRTEI, true);
    b = std::fmax(b_log2(b / N), 1.0 / nv) * nv;
    if (std::isnan(b)) {
      i = c_y->size[0] * c_y->size[1];
      c_y->size[0] = 1;
      c_y->size[1] = 1;
      emxEnsureCapacity_real_T(c_y, i, &n_emlrtRTEI);
      c_y->data[0] = rtNaN;
    } else if (b < 0.0) {
      c_y->size[0] = 1;
      c_y->size[1] = 0;
    } else {
      i = c_y->size[0] * c_y->size[1];
      c_y->size[0] = 1;
      c_y->size[1] = static_cast<int32_T>(b) + 1;
      emxEnsureCapacity_real_T(c_y, i, &n_emlrtRTEI);
      for (i = 0; i <= static_cast<int32_T>(b); i++) {
        c_y->data[i] = i;
      }
    }
    emxInit_real_T(&d_b, 2, &sc_emlrtRTEI, true);
    i = d_b->size[0] * d_b->size[1];
    d_b->size[0] = 1;
    d_b->size[1] = c_y->size[1];
    emxEnsureCapacity_real_T(d_b, i, &kb_emlrtRTEI);
    nx = c_y->size[1];
    for (loop_ub = 0; loop_ub < nx; loop_ub++) {
      d_b->data[loop_ub] = rt_powd_snf(ga, c_y->data[loop_ub]);
    }
    emxFree_real_T(&c_y);
    i = b_self->Scales->size[0] * b_self->Scales->size[1];
    b_self->Scales->size[0] = 1;
    b_self->Scales->size[1] = d_b->size[1];
    emxEnsureCapacity_real_T(b_self->Scales, i, &dc_emlrtRTEI);
    for (i = 0; i < d_b->size[1]; i++) {
      b_self->Scales->data[i] = N * d_b->data[i];
    }
    emxFree_real_T(&d_b);
  }
  wname[0] = b_self->Wavelet[0];
  wname[1] = b_self->Wavelet[1];
  wname[2] = b_self->Wavelet[2];
  wname[3] = b_self->Wavelet[3];
  emxInit_real_T(&omega, 2, &bc_emlrtRTEI, true);
  i = omega->size[0] * omega->size[1];
  omega->size[0] = 1;
  omega->size[1] = b_self->Omega->size[1];
  emxEnsureCapacity_real_T(omega, i, &bc_emlrtRTEI);
  for (i = 0; i < b_self->Omega->size[1]; i++) {
    omega->data[i] = b_self->Omega->data[i];
  }
  emxInit_real_T(&scales, 2, &cc_emlrtRTEI, true);
  i = scales->size[0] * scales->size[1];
  scales->size[0] = 1;
  scales->size[1] = b_self->Scales->size[1];
  emxEnsureCapacity_real_T(scales, i, &cc_emlrtRTEI);
  for (i = 0; i < b_self->Scales->size[1]; i++) {
    scales->data[i] = b_self->Scales->data[i];
  }
  emxInit_real_T(&somega, 2, &qc_emlrtRTEI, true);
  if (scales->size[1] == 1) {
    i = somega->size[0] * somega->size[1];
    somega->size[0] = 1;
    if (omega->size[1] == 1) {
      somega->size[1] = 1;
    } else {
      somega->size[1] = omega->size[1];
    }
    emxEnsureCapacity_real_T(somega, i, &fc_emlrtRTEI);
    if (somega->size[1] != 0) {
      nx = (omega->size[1] != 1);
      fc = somega->size[1] - 1;
      for (loop_ub = 0; loop_ub <= fc; loop_ub++) {
        somega->data[loop_ub] = scales->data[0] * omega->data[nx * loop_ub];
      }
    }
  } else {
    i = somega->size[0] * somega->size[1];
    somega->size[0] = scales->size[1];
    somega->size[1] = omega->size[1];
    emxEnsureCapacity_real_T(somega, i, &ec_emlrtRTEI);
    loop_ub = omega->size[1];
    for (i = 0; i < loop_ub; i++) {
      fc = scales->size[1];
      for (nx = 0; nx < fc; nx++) {
        somega->data[nx + somega->size[0] * i] =
            scales->data[nx] * omega->data[i];
      }
    }
  }
  emxFree_real_T(&omega);
  y = false;
  nx = 0;
  do {
    exitg2 = 0;
    if (nx + 1 < 5) {
      if (cv2[nx] != wname[nx]) {
        exitg2 = 1;
      } else {
        nx++;
      }
    } else {
      y = true;
      exitg2 = 1;
    }
  } while (exitg2 == 0);
  emxInit_real_T(&expnt, 2, &hc_emlrtRTEI, true);
  emxInit_real_T(&daughter, 2, &mc_emlrtRTEI, true);
  if (y) {
    fc = 0;
  } else {
    fc = -1;
  }
  if (fc == 0) {
    fc = 6;
    i = expnt->size[0] * expnt->size[1];
    expnt->size[0] = somega->size[0];
    expnt->size[1] = somega->size[1];
    emxEnsureCapacity_real_T(expnt, i, &hc_emlrtRTEI);
    for (i = 0; i < somega->size[0] * somega->size[1]; i++) {
      expnt->data[i] = -((somega->data[i] - 6.0) * (somega->data[i] - 6.0)) /
                       2.0 * static_cast<real_T>(somega->data[i] > 0.0);
    }
    nx = expnt->size[0] * expnt->size[1];
    for (loop_ub = 0; loop_ub < nx; loop_ub++) {
      expnt->data[loop_ub] = std::exp(expnt->data[loop_ub]);
    }
    i = daughter->size[0] * daughter->size[1];
    daughter->size[0] = expnt->size[0];
    daughter->size[1] = expnt->size[1];
    emxEnsureCapacity_real_T(daughter, i, &jc_emlrtRTEI);
    for (i = 0; i < expnt->size[0] * expnt->size[1]; i++) {
      daughter->data[i] =
          2.0 * expnt->data[i] * static_cast<real_T>(somega->data[i] > 0.0);
    }
  } else {
    fc = 5;
    emxInit_real_T(&w, 2, &gc_emlrtRTEI, true);
    i = w->size[0] * w->size[1];
    w->size[0] = somega->size[0];
    w->size[1] = somega->size[1];
    emxEnsureCapacity_real_T(w, i, &gc_emlrtRTEI);
    for (i = 0; i < somega->size[0] * somega->size[1]; i++) {
      w->data[i] = (somega->data[i] - 5.0) / 0.6;
    }
    i = expnt->size[0] * expnt->size[1];
    expnt->size[0] = w->size[0];
    expnt->size[1] = w->size[1];
    emxEnsureCapacity_real_T(expnt, i, &ic_emlrtRTEI);
    for (i = 0; i < w->size[0] * w->size[1]; i++) {
      expnt->data[i] = -1.0 / (1.0 - w->data[i] * w->data[i]);
    }
    nx = expnt->size[0] * expnt->size[1];
    for (loop_ub = 0; loop_ub < nx; loop_ub++) {
      expnt->data[loop_ub] = std::exp(expnt->data[loop_ub]);
    }
    nx = w->size[0] * w->size[1];
    emxInit_real_T(&d_y, 2, &tc_emlrtRTEI, true);
    i = d_y->size[0] * d_y->size[1];
    d_y->size[0] = w->size[0];
    d_y->size[1] = w->size[1];
    emxEnsureCapacity_real_T(d_y, i, &h_emlrtRTEI);
    for (loop_ub = 0; loop_ub < nx; loop_ub++) {
      d_y->data[loop_ub] = std::abs(w->data[loop_ub]);
    }
    emxFree_real_T(&w);
    if ((expnt->size[0] == d_y->size[0]) && (expnt->size[1] == d_y->size[1])) {
      i = daughter->size[0] * daughter->size[1];
      daughter->size[0] = expnt->size[0];
      daughter->size[1] = expnt->size[1];
      emxEnsureCapacity_real_T(daughter, i, &mc_emlrtRTEI);
      for (i = 0; i < expnt->size[0] * expnt->size[1]; i++) {
        daughter->data[i] =
            5.43656365691809 * expnt->data[i] *
            static_cast<real_T>(d_y->data[i] < 0.99999999999999978);
      }
    } else {
      binary_expand_op_2(daughter, expnt, d_y);
    }
    emxFree_real_T(&d_y);
    nx = daughter->size[0] * daughter->size[1] - 1;
    for (b_i = 0; b_i <= nx; b_i++) {
      if (std::isnan(daughter->data[b_i])) {
        daughter->data[b_i] = 0.0;
      }
    }
  }
  emxFree_real_T(&expnt);
  emxFree_real_T(&somega);
  ga = static_cast<real_T>(fc) / 6.2831853071795862;
  emxInit_real_T(&f, 2, &uc_emlrtRTEI, true);
  i = f->size[0] * f->size[1];
  f->size[0] = 1;
  f->size[1] = scales->size[1];
  emxEnsureCapacity_real_T(f, i, &kc_emlrtRTEI);
  for (i = 0; i < scales->size[1]; i++) {
    f->data[i] = ga / scales->data[i] * b_self->SamplingFrequency;
  }
  emxFree_real_T(&scales);
  i = b_self->PsiDFT->size[0] * b_self->PsiDFT->size[1];
  b_self->PsiDFT->size[0] = daughter->size[0];
  b_self->PsiDFT->size[1] = daughter->size[1];
  emxEnsureCapacity_real_T(b_self->PsiDFT, i, &lc_emlrtRTEI);
  for (i = 0; i < daughter->size[0] * daughter->size[1]; i++) {
    b_self->PsiDFT->data[i] = daughter->data[i];
  }
  emxFree_real_T(&daughter);
  i = b_self->WaveletCenterFrequencies->size[0];
  b_self->WaveletCenterFrequencies->size[0] = f->size[1];
  emxEnsureCapacity_real_T(b_self->WaveletCenterFrequencies, i, &nc_emlrtRTEI);
  for (i = 0; i < f->size[1]; i++) {
    b_self->WaveletCenterFrequencies->data[i] = f->data[i];
  }
  emxFree_real_T(&f);
  emlrtHeapReferenceStackLeaveFcnR2012b(emlrtRootTLSGlobal);
  return b_self;
}

} // namespace coder

// End of code generation (cwtfilterbank.cu)
