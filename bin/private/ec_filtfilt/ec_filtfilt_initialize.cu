//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_filtfilt_initialize.cu
//
// Code generation for function 'ec_filtfilt_initialize'
//

// Include files
#include "ec_filtfilt_initialize.h"
#include "_coder_ec_filtfilt_mex.h"
#include "ec_filtfilt_data.h"
#include "rt_nonfinite.h"
#include "MWMemoryManager.hpp"

// Function Declarations
static void ec_filtfilt_once();

// Function Definitions
static void ec_filtfilt_once()
{
  mwMemoryManagerInit(256U, 1U, 8U, 2048U);
}

void ec_filtfilt_initialize()
{
  mex_InitInfAndNan();
  mexFunctionCreateRootTLS();
  emlrtClearAllocCountR2012b(emlrtRootTLSGlobal, false, 0U, nullptr);
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtLicenseCheckR2022a(emlrtRootTLSGlobal,
                          "EMLRT:runTime:MexFunctionNeedsLicense",
                          "distrib_computing_toolbox", 2);
  emlrtLicenseCheckR2022a(emlrtRootTLSGlobal,
                          "EMLRT:runTime:MexFunctionNeedsLicense",
                          "signal_toolbox", 2);
  if (emlrtFirstTimeR2012b(emlrtRootTLSGlobal)) {
    ec_filtfilt_once();
  }
  emlrtInitGPU(emlrtRootTLSGlobal);
  cudaGetLastError();
}

// End of code generation (ec_filtfilt_initialize.cu)
