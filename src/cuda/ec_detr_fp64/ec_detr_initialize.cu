//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_detr_initialize.cu
//
// Code generation for function 'ec_detr_initialize'
//

// Include files
#include "ec_detr_initialize.h"
#include "_coder_ec_detr_mex.h"
#include "ec_detr_data.h"
#include "rt_nonfinite.h"
#include "MWCUBLASUtils.hpp"
#include "MWCUSOLVERUtils.hpp"

// Function Definitions
void ec_detr_initialize()
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
  cublasEnsureInitialization(CUBLAS_POINTER_MODE_HOST);
  cusolverEnsureInitialization();
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

// End of code generation (ec_detr_initialize.cu)
