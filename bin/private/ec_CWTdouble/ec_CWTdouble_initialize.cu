//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_CWTdouble_initialize.cu
//
// Code generation for function 'ec_CWTdouble_initialize'
//

// Include files
#include "ec_CWTdouble_initialize.h"
#include "_coder_ec_CWTdouble_mex.h"
#include "cwt.h"
#include "ec_CWTdouble_data.h"
#include "rt_nonfinite.h"
#include "MWMemoryManager.hpp"

// Function Declarations
static void ec_CWTdouble_once();

// Function Definitions
static void ec_CWTdouble_once()
{
  mex_InitInfAndNan();
  mwMemoryManagerInit(256U, 1U, 8U, 2048U);
  cwt_init();
}

void ec_CWTdouble_initialize()
{
  mexFunctionCreateRootTLS();
  emlrtClearAllocCountR2012b(emlrtRootTLSGlobal, false, 0U, nullptr);
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtLicenseCheckR2022a(emlrtRootTLSGlobal,
                          "EMLRT:runTime:MexFunctionNeedsLicense",
                          "distrib_computing_toolbox", 2);
  emlrtLicenseCheckR2022a(emlrtRootTLSGlobal,
                          "EMLRT:runTime:MexFunctionNeedsLicense",
                          "wavelet_toolbox", 2);
  if (emlrtFirstTimeR2012b(emlrtRootTLSGlobal)) {
    ec_CWTdouble_once();
  }
  emlrtInitGPU(emlrtRootTLSGlobal);
  cudaGetLastError();
}

// End of code generation (ec_CWTdouble_initialize.cu)
