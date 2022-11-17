//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// cwt.cu
//
// Code generation for function 'cwt'
//

// Include files
#include "cwt.h"
#include "ec_CWTsingle_data.h"
#include "ec_CWTsingle_emxutil.h"
#include "ec_CWTsingle_types.h"
#include "rt_nonfinite.h"

// Variable Definitions
static emlrtRTEInfo emlrtRTEI{
    33,                                                  // lineNo
    12,                                                  // colNo
    "cwt",                                               // fName
    "/usr/local/MATLAB/R2022b/toolbox/wavelet/eml/cwt.m" // pName
};

static emlrtRTEInfo b_emlrtRTEI{
    32,                                                  // lineNo
    12,                                                  // colNo
    "cwt",                                               // fName
    "/usr/local/MATLAB/R2022b/toolbox/wavelet/eml/cwt.m" // pName
};

// Function Definitions
void cwt_free()
{
  emxFree_real32_T(&psidft);
  emxFree_real32_T(&cf);
}

void cwt_init()
{
  emxInit_real32_T(&cf, 1, &emlrtRTEI, false);
  emxInit_real32_T(&psidft, 2, &b_emlrtRTEI, false);
  psidft_not_empty = false;
}

// End of code generation (cwt.cu)
