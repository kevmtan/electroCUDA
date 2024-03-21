//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// _coder_ec_cwt_mex.cu
//
// Code generation for function '_coder_ec_cwt_mex'
//

// Include files
#include "_coder_ec_cwt_mex.h"
#include "ec_cwt.h"
#include "ec_cwt_types.h"
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
  ec_cwtStackData *ec_cwtStackDataGlobal{nullptr};
  ec_cwtStackDataGlobal = static_cast<ec_cwtStackData *>(new ec_cwtStackData);
  mexAtExit(&ec_cwt_atexit);
  // Module initialization.
  ec_cwt_initialize();
  try { // Dispatch the entry-point.
    unsafe_ec_cwt_mexFunction(ec_cwtStackDataGlobal, nlhs, plhs, nrhs, prhs);
    // Module termination.
    ec_cwt_terminate();
  } catch (...) {
    emlrtCleanupOnException((emlrtCTX *)emlrtRootTLSGlobal);
    throw;
  }
  delete ec_cwtStackDataGlobal;
}

emlrtCTX mexFunctionCreateRootTLS()
{
  emlrtCreateRootTLSR2022a(&emlrtRootTLSGlobal, &emlrtContextGlobal, nullptr, 1,
                           (void *)&emlrtExceptionBridge, "UTF-8", true);
  return emlrtRootTLSGlobal;
}

void unsafe_ec_cwt_mexFunction(ec_cwtStackData *SD, int32_T nlhs,
                               mxArray *plhs[2], int32_T nrhs,
                               const mxArray *prhs[5])
{
  const mxArray *outputs[2];
  int32_T b;
  // Check for proper number of arguments.
  if (nrhs != 5) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal,
                        "EMLRT:runTime:WrongNumberOfInputsFAVDefaultValues", 5,
                        12, 5, 4, 6, "ec_cwt");
  }
  if (nlhs > 2) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal,
                        "EMLRT:runTime:TooManyOutputArguments", 3, 4, 6,
                        "ec_cwt");
  }
  // Call the function.
  b_ec_cwt_api(SD, prhs, nlhs, outputs);
  // Copy over outputs to the caller.
  if (nlhs < 1) {
    b = 1;
  } else {
    b = nlhs;
  }
  emlrtReturnArrays(b, &plhs[0], &outputs[0]);
}

// End of code generation (_coder_ec_cwt_mex.cu)
