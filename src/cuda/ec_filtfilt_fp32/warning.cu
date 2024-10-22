//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// warning.cu
//
// Code generation for function 'warning'
//

// Include files
#include "warning.h"
#include "filtfilt_data.h"
#include "rt_nonfinite.h"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"

// Variable Definitions
static emlrtMCInfo emlrtMCI{
    14,        // lineNo
    25,        // colNo
    "warning", // fName
    "/usr/local/MATLAB/R2024b/toolbox/shared/coder/coder/lib/+coder/+internal/"
    "warning.m" // pName
};

static emlrtMCInfo b_emlrtMCI{
    14,        // lineNo
    9,         // colNo
    "warning", // fName
    "/usr/local/MATLAB/R2024b/toolbox/shared/coder/coder/lib/+coder/+internal/"
    "warning.m" // pName
};

// Function Declarations
static void b_feval(const mxArray *m, const mxArray *m1, emlrtMCInfo *location);

static const mxArray *feval(const mxArray *m1, const mxArray *m2,
                            const mxArray *m3, const mxArray *m4,
                            emlrtMCInfo *location);

static const mxArray *feval(const mxArray *m1, const mxArray *m2,
                            emlrtMCInfo *location);

// Function Definitions
static void b_feval(const mxArray *m, const mxArray *m1, emlrtMCInfo *location)
{
  const mxArray *pArrays[2];
  nvtxRangePushA("#fcn#b_feval#" MW_AT_LOCATION);
  pArrays[0] = m;
  pArrays[1] = m1;
  emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 0, nullptr, 2, &pArrays[0], "feval",
                        true, location);
  nvtxRangePop();
}

static const mxArray *feval(const mxArray *m1, const mxArray *m2,
                            const mxArray *m3, const mxArray *m4,
                            emlrtMCInfo *location)
{
  const mxArray *pArrays[4];
  const mxArray *m;
  const mxArray *m5;
  nvtxRangePushA("#fcn#feval#" MW_AT_LOCATION);
  pArrays[0] = m1;
  pArrays[1] = m2;
  pArrays[2] = m3;
  pArrays[3] = m4;
  m5 = emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 1, &m, 4, &pArrays[0], "feval",
                             true, location);
  nvtxRangePop();
  return m5;
}

static const mxArray *feval(const mxArray *m1, const mxArray *m2,
                            emlrtMCInfo *location)
{
  const mxArray *pArrays[2];
  const mxArray *m;
  const mxArray *m3;
  nvtxRangePushA("#fcn#feval#" MW_AT_LOCATION);
  pArrays[0] = m1;
  pArrays[1] = m2;
  m3 = emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 1, &m, 2, &pArrays[0], "feval",
                             true, location);
  nvtxRangePop();
  return m3;
}

//
//
namespace coder {
namespace internal {
void b_warning()
{
  static const int32_T iv[2]{1, 7};
  static const int32_T iv1[2]{1, 7};
  static const int32_T iv2[2]{1, 22};
  static const char_T c_u[22]{'s', 'i', 'g', 'n', 'a', 'l', ':', 'f',
                              'i', 'l', 't', 'f', 'i', 'l', 't', ':',
                              'P', 'a', 'r', 's', 'e', 'B'};
  static const char_T b_u[7]{'m', 'e', 's', 's', 'a', 'g', 'e'};
  static const char_T u[7]{'w', 'a', 'r', 'n', 'i', 'n', 'g'};
  const mxArray *propValues[1];
  const mxArray *b_y;
  const mxArray *c_y;
  const mxArray *d_y;
  const mxArray *m;
  const mxArray *m1;
  const mxArray *m2;
  const mxArray *m3;
  const mxArray *y;
  const char_T *propClasses[1]{"coder.internal.string"};
  const char_T *propNames[1]{"Value"};
  nvtxRangePushA("#fcn#b_warning#" MW_AT_LOCATION);
  y = nullptr;
  m = emlrtCreateCharArray(2, &iv[0]);
  emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m, &u[0]);
  emlrtAssign(&y, m);
  b_y = nullptr;
  m1 = emlrtCreateCharArray(2, &iv1[0]);
  emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m1, &b_u[0]);
  emlrtAssign(&b_y, m1);
  c_y = nullptr;
  m2 = nullptr;
  emlrtAssign(&c_y, emlrtCreateClassInstance2022a(emlrtRootTLSGlobal,
                                                  "coder.internal.string"));
  m2 = nullptr;
  d_y = nullptr;
  m3 = emlrtCreateCharArray(2, &iv2[0]);
  emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 22, m3, &c_u[0]);
  emlrtAssign(&d_y, m3);
  emlrtAssign(&m2, d_y);
  propValues[0] = m2;
  emlrtSetAllProperties(emlrtRootTLSGlobal, &c_y, 0, 1,
                        (const char_T **)&propNames[0],
                        (const char_T **)&propClasses[0], &propValues[0]);
  emlrtAssign(&c_y, emlrtConvertInstanceToRedirectSource(
                        emlrtRootTLSGlobal, c_y, 0, "coder.internal.string"));
  nvtxMarkA("#b_feval#" MW_AT_LINE);
  nvtxMarkA("#feval#" MW_AT_LINE);
  b_feval(y, feval(b_y, c_y, &emlrtMCI), &b_emlrtMCI);
  nvtxRangePop();
}

//
//
void c_warning()
{
  static const int32_T iv[2]{1, 7};
  static const int32_T iv1[2]{1, 7};
  static const int32_T iv2[2]{1, 21};
  static const char_T msgID[21]{'M', 'A', 'T', 'L', 'A', 'B', ':',
                                's', 'i', 'n', 'g', 'u', 'l', 'a',
                                'r', 'M', 'a', 't', 'r', 'i', 'x'};
  static const char_T b_u[7]{'m', 'e', 's', 's', 'a', 'g', 'e'};
  static const char_T u[7]{'w', 'a', 'r', 'n', 'i', 'n', 'g'};
  const mxArray *b_y;
  const mxArray *c_y;
  const mxArray *m;
  const mxArray *m1;
  const mxArray *m2;
  const mxArray *y;
  nvtxRangePushA("#fcn#c_warning#" MW_AT_LOCATION);
  y = nullptr;
  m = emlrtCreateCharArray(2, &iv[0]);
  emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m, &u[0]);
  emlrtAssign(&y, m);
  b_y = nullptr;
  m1 = emlrtCreateCharArray(2, &iv1[0]);
  emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m1, &b_u[0]);
  emlrtAssign(&b_y, m1);
  c_y = nullptr;
  m2 = emlrtCreateCharArray(2, &iv2[0]);
  emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 21, m2, &msgID[0]);
  emlrtAssign(&c_y, m2);
  nvtxMarkA("#b_feval#" MW_AT_LINE);
  nvtxMarkA("#feval#" MW_AT_LINE);
  b_feval(y, feval(b_y, c_y, &emlrtMCI), &b_emlrtMCI);
  nvtxRangePop();
}

//
//
void warning()
{
  static const int32_T iv[2]{1, 7};
  static const int32_T iv1[2]{1, 7};
  static const int32_T iv2[2]{1, 24};
  static const char_T c_u[24]{'s', 'i', 'g', 'n', 'a', 'l', ':', 'f',
                              'i', 'l', 't', 'f', 'i', 'l', 't', ':',
                              'P', 'a', 'r', 's', 'e', 'S', 'O', 'S'};
  static const char_T b_u[7]{'m', 'e', 's', 's', 'a', 'g', 'e'};
  static const char_T u[7]{'w', 'a', 'r', 'n', 'i', 'n', 'g'};
  const mxArray *propValues[1];
  const mxArray *b_y;
  const mxArray *c_y;
  const mxArray *d_y;
  const mxArray *m;
  const mxArray *m1;
  const mxArray *m2;
  const mxArray *m3;
  const mxArray *y;
  const char_T *propClasses[1]{"coder.internal.string"};
  const char_T *propNames[1]{"Value"};
  nvtxRangePushA("#fcn#warning#" MW_AT_LOCATION);
  y = nullptr;
  m = emlrtCreateCharArray(2, &iv[0]);
  emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m, &u[0]);
  emlrtAssign(&y, m);
  b_y = nullptr;
  m1 = emlrtCreateCharArray(2, &iv1[0]);
  emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m1, &b_u[0]);
  emlrtAssign(&b_y, m1);
  c_y = nullptr;
  m2 = nullptr;
  emlrtAssign(&c_y, emlrtCreateClassInstance2022a(emlrtRootTLSGlobal,
                                                  "coder.internal.string"));
  m2 = nullptr;
  d_y = nullptr;
  m3 = emlrtCreateCharArray(2, &iv2[0]);
  emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 24, m3, &c_u[0]);
  emlrtAssign(&d_y, m3);
  emlrtAssign(&m2, d_y);
  propValues[0] = m2;
  emlrtSetAllProperties(emlrtRootTLSGlobal, &c_y, 0, 1,
                        (const char_T **)&propNames[0],
                        (const char_T **)&propClasses[0], &propValues[0]);
  emlrtAssign(&c_y, emlrtConvertInstanceToRedirectSource(
                        emlrtRootTLSGlobal, c_y, 0, "coder.internal.string"));
  nvtxMarkA("#b_feval#" MW_AT_LINE);
  nvtxMarkA("#feval#" MW_AT_LINE);
  b_feval(y, feval(b_y, c_y, &emlrtMCI), &b_emlrtMCI);
  nvtxRangePop();
}

//
//
void warning(int32_T varargin_1, const char_T varargin_2[14])
{
  static const int32_T iv[2]{1, 7};
  static const int32_T iv1[2]{1, 7};
  static const int32_T iv2[2]{1, 32};
  static const int32_T iv3[2]{1, 14};
  static const char_T msgID[32]{'C', 'o', 'd', 'e', 'r', ':', 'M', 'A',
                                'T', 'L', 'A', 'B', ':', 'r', 'a', 'n',
                                'k', 'D', 'e', 'f', 'i', 'c', 'i', 'e',
                                'n', 't', 'M', 'a', 't', 'r', 'i', 'x'};
  static const char_T b_u[7]{'m', 'e', 's', 's', 'a', 'g', 'e'};
  static const char_T u[7]{'w', 'a', 'r', 'n', 'i', 'n', 'g'};
  const mxArray *b_y;
  const mxArray *c_y;
  const mxArray *d_y;
  const mxArray *e_y;
  const mxArray *m;
  const mxArray *m1;
  const mxArray *m2;
  const mxArray *m3;
  const mxArray *m4;
  const mxArray *y;
  nvtxRangePushA("#fcn#warning#" MW_AT_LOCATION);
  y = nullptr;
  m = emlrtCreateCharArray(2, &iv[0]);
  emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m, &u[0]);
  emlrtAssign(&y, m);
  b_y = nullptr;
  m1 = emlrtCreateCharArray(2, &iv1[0]);
  emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 7, m1, &b_u[0]);
  emlrtAssign(&b_y, m1);
  c_y = nullptr;
  m2 = emlrtCreateCharArray(2, &iv2[0]);
  emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 32, m2, &msgID[0]);
  emlrtAssign(&c_y, m2);
  d_y = nullptr;
  m3 = emlrtCreateNumericMatrix(1, 1, mxINT32_CLASS, mxREAL);
  *static_cast<int32_T *>(emlrtMxGetData(m3)) = varargin_1;
  emlrtAssign(&d_y, m3);
  e_y = nullptr;
  m4 = emlrtCreateCharArray(2, &iv3[0]);
  emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 14, m4, &varargin_2[0]);
  emlrtAssign(&e_y, m4);
  nvtxMarkA("#b_feval#" MW_AT_LINE);
  nvtxMarkA("#feval#" MW_AT_LINE);
  b_feval(y, feval(b_y, c_y, d_y, e_y, &emlrtMCI), &b_emlrtMCI);
  nvtxRangePop();
}

} // namespace internal
} // namespace coder

// End of code generation (warning.cu)
