//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_filtfilt1_initialize.cu
//
// Code generation for function 'ec_filtfilt1_initialize'
//

// Include files
#include "ec_filtfilt1_initialize.h"
#include "_coder_ec_filtfilt1_mex.h"
#include "ec_filtfilt1_data.h"
#include "rt_nonfinite.h"

// Function Definitions
void ec_filtfilt1_initialize()
{
  mex_InitInfAndNan();
  emlrtInitGPU(emlrtRootTLSGlobal);
  cudaGetLastError();
  mexFunctionCreateRootTLS();
  emlrtClearAllocCountR2012b(emlrtRootTLSGlobal, false, 0U, nullptr);
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  emlrtLicenseCheckR2022a(emlrtRootTLSGlobal,
                          "EMLRT:runTime:MexFunctionNeedsLicense",
                          "distrib_computing_toolbox", 2);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

// End of code generation (ec_filtfilt1_initialize.cu)
