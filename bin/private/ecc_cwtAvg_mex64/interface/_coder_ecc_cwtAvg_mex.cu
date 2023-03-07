//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// _coder_ecc_cwtAvg_mex.cu
//
// Code generation for function '_coder_ecc_cwtAvg_mex'
//

// Include files
#include "_coder_ecc_cwtAvg_mex.h"
#include "ecc_cwtAvg.h"
#include "rt_nonfinite.h"
#include <stdexcept>

void emlrtExceptionBridge();
void emlrtExceptionBridge()
{
  throw std::runtime_error("");
}
// Function Definitions
void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs,
                 const mxArray *prhs[])
{
  mexAtExit(&ecc_cwtAvg_atexit);
  // Module initialization.
  ecc_cwtAvg_initialize();
  try {
    // Dispatch the entry-point.
    unsafe_ecc_cwtAvg_mexFunction(nlhs, plhs, nrhs, prhs);
    // Module termination.
    ecc_cwtAvg_terminate();
  } catch (...) {
    emlrtCleanupOnException((emlrtCTX *)emlrtRootTLSGlobal);
    throw;
  }
}

emlrtCTX mexFunctionCreateRootTLS()
{
  emlrtCreateRootTLSR2022a(&emlrtRootTLSGlobal, &emlrtContextGlobal, nullptr, 1,
                           (void *)&emlrtExceptionBridge, "UTF-8", true);
  return emlrtRootTLSGlobal;
}

void unsafe_ecc_cwtAvg_mexFunction(int32_T nlhs, mxArray *plhs[2], int32_T nrhs,
                                   const mxArray *prhs[4])
{
  const mxArray *outputs[2];
  int32_T b;
  // Check for proper number of arguments.
  if (nrhs != 4) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal,
                        "EMLRT:runTime:WrongNumberOfInputsFAVDefaultValues", 5,
                        12, 4, 4, 10, "ecc_cwtAvg");
  }
  if (nlhs > 2) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal,
                        "EMLRT:runTime:TooManyOutputArguments", 3, 4, 10,
                        "ecc_cwtAvg");
  }
  // Call the function.
  ecc_cwtAvg_api(prhs, nlhs, outputs);
  // Copy over outputs to the caller.
  if (nlhs < 1) {
    b = 1;
  } else {
    b = nlhs;
  }
  emlrtReturnArrays(b, &plhs[0], &outputs[0]);
}

// End of code generation (_coder_ecc_cwtAvg_mex.cu)
