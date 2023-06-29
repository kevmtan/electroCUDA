//
// Prerelease License - for engineering feedback and testing purposes
// only. Not for sale.
//
// _coder_ec_detr_mex.cu
//
// Code generation for function '_coder_ec_detr_mex'
//

// Include files
#include "_coder_ec_detr_mex.h"
#include "ec_detr.h"
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
  mexAtExit(&ec_detr_atexit);
  // Module initialization.
  ec_detr_initialize();
  try {
    // Dispatch the entry-point.
    unsafe_ec_detr_mexFunction(nlhs, plhs, nrhs, prhs);
    // Module termination.
    ec_detr_terminate();
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

void unsafe_ec_detr_mexFunction(int32_T nlhs, mxArray *plhs[3], int32_T nrhs,
                                const mxArray *prhs[5])
{
  const mxArray *b_prhs[5];
  const mxArray *outputs[3];
  int32_T b;
  // Check for proper number of arguments.
  if (nrhs != 5) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal, "EMLRT:runTime:WrongNumberOfInputs",
                        5, 12, 5, 4, 7, "ec_detr");
  }
  if (nlhs > 3) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal,
                        "EMLRT:runTime:TooManyOutputArguments", 3, 4, 7,
                        "ec_detr");
  }
  // Call the function.
  for (int32_T c{0}; c < 5; c++) {
    b_prhs[c] = prhs[c];
  }
  ec_detr_api(b_prhs, nlhs, outputs);
  // Copy over outputs to the caller.
  if (nlhs < 1) {
    b = 1;
  } else {
    b = nlhs;
  }
  emlrtReturnArrays(b, &plhs[0], &outputs[0]);
}

// End of code generation (_coder_ec_detr_mex.cu)
