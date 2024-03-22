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
#include "ec_wtcc_data.h"
#include "rt_nonfinite.h"

// Variable Definitions
static emlrtMCInfo d_emlrtMCI{
    14,        // lineNo
    25,        // colNo
    "warning", // fName
    "/usr/local/MATLAB/R2024a/toolbox/shared/coder/coder/lib/+coder/+internal/"
    "warning.m" // pName
};

static emlrtMCInfo e_emlrtMCI{
    14,        // lineNo
    9,         // colNo
    "warning", // fName
    "/usr/local/MATLAB/R2024a/toolbox/shared/coder/coder/lib/+coder/+internal/"
    "warning.m" // pName
};

// Function Declarations
static void b_feval(const mxArray *m, const mxArray *m1, emlrtMCInfo *location);

static const mxArray *feval(const mxArray *m1, const mxArray *m2,
                            emlrtMCInfo *location);

// Function Definitions
static void b_feval(const mxArray *m, const mxArray *m1, emlrtMCInfo *location)
{
  const mxArray *pArrays[2];
  pArrays[0] = m;
  pArrays[1] = m1;
  emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 0, nullptr, 2, &pArrays[0], "feval",
                        true, location);
}

static const mxArray *feval(const mxArray *m1, const mxArray *m2,
                            emlrtMCInfo *location)
{
  const mxArray *pArrays[2];
  const mxArray *m;
  pArrays[0] = m1;
  pArrays[1] = m2;
  return emlrtCallMATLABR2012b(emlrtRootTLSGlobal, 1, &m, 2, &pArrays[0],
                               "feval", true, location);
}

//
//
namespace coder {
namespace internal {
void warning()
{
  static const int32_T iv[2]{1, 7};
  static const int32_T iv1[2]{1, 7};
  static const int32_T iv2[2]{1, 39};
  static const char_T msgID[39]{
      's', 'i', 'g', 'n', 'a', 'l', ':', 'c', 'h', 'e', 'c', 'k', '_',
      'o', 'r', 'd', 'e', 'r', ':', 'I', 'n', 'v', 'a', 'l', 'i', 'd',
      'O', 'r', 'd', 'e', 'r', 'R', 'o', 'u', 'n', 'd', 'i', 'n', 'g'};
  static const char_T b_u[7]{'m', 'e', 's', 's', 'a', 'g', 'e'};
  static const char_T u[7]{'w', 'a', 'r', 'n', 'i', 'n', 'g'};
  const mxArray *b_y;
  const mxArray *c_y;
  const mxArray *m;
  const mxArray *m1;
  const mxArray *m2;
  const mxArray *y;
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
  emlrtInitCharArrayR2013a(emlrtRootTLSGlobal, 39, m2, &msgID[0]);
  emlrtAssign(&c_y, m2);
  b_feval(y, feval(b_y, c_y, &d_emlrtMCI), &e_emlrtMCI);
}

} // namespace internal
} // namespace coder

// End of code generation (warning.cu)
