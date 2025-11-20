//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// _coder_ec_detr_fp_mex.cu
//
// Code generation for function '_coder_ec_detr_fp_mex'
//

// Include files
#include "_coder_ec_detr_fp_mex.h"
#include "_coder_ec_detr_fp_api.h"
#include "ec_detr_fp_data.h"
#include "ec_detr_fp_initialize.h"
#include "ec_detr_fp_terminate.h"
#include "rt_nonfinite.h"
#include "MWLocationStringifyNvtx3.h"
#include "nvtx3/nvToolsExt.h"
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
  nvtxRangePushA("#fcn#mexFunction#" MW_AT_LOCATION);
  nvtxMarkA("#mexAtExit#" MW_AT_LINE);
  mexAtExit(&ec_detr_fp_atexit);
  nvtxMarkA("#ec_detr_fp_initialize#" MW_AT_LINE);
  ec_detr_fp_initialize();
  try {
    nvtxMarkA("#unsafe_ec_detr_fp_mexFunction#" MW_AT_LINE);
    unsafe_ec_detr_fp_mexFunction(nlhs, plhs, nrhs, prhs);
    nvtxMarkA("#ec_detr_fp_terminate#" MW_AT_LINE);
    ec_detr_fp_terminate();
  } catch (...) {
    emlrtCleanupOnException((emlrtCTX *)emlrtRootTLSGlobal);
    throw;
  }
  nvtxRangePop();
}

emlrtCTX mexFunctionCreateRootTLS()
{
  emlrtCTX p;
  nvtxRangePushA("#fcn#mexFunctionCreateRootTLS#" MW_AT_LOCATION);
  emlrtCreateRootTLSR2022a(&emlrtRootTLSGlobal, &emlrtContextGlobal, nullptr, 1,
                           (void *)&emlrtExceptionBridge, "UTF-8", true);
  p = emlrtRootTLSGlobal;
  nvtxRangePop();
  return p;
}

void unsafe_ec_detr_fp_mexFunction(int32_T nlhs, mxArray *plhs[3], int32_T nrhs,
                                   const mxArray *prhs[5])
{
  const mxArray *b_prhs[5];
  const mxArray *outputs[3];
  int32_T b;
  nvtxRangePushA("#fcn#unsafe_ec_detr_fp_mexFunction#" MW_AT_LOCATION);
  // Check for proper number of arguments.
  if (nrhs != 5) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal, "EMLRT:runTime:WrongNumberOfInputs",
                        5, 12, 5, 4, 10, "ec_detr_fp");
  }
  if (nlhs > 3) {
    emlrtErrMsgIdAndTxt(emlrtRootTLSGlobal,
                        "EMLRT:runTime:TooManyOutputArguments", 3, 4, 10,
                        "ec_detr_fp");
  }
  // Call the function.
  profileLoopStart("unsafe_ec_detr_fp_mexFunction_loop_0", __LINE__, 4 + 1, "");
  for (int32_T c{0}; c < 5; c++) {
    b_prhs[c] = prhs[c];
  }
  profileLoopEnd();
  nvtxMarkA("#ec_detr_fp_api#" MW_AT_LINE);
  ec_detr_fp_api(b_prhs, nlhs, outputs);
  // Copy over outputs to the caller.
  if (nlhs < 1) {
    b = 1;
  } else {
    b = nlhs;
  }
  emlrtReturnArrays(b, &plhs[0], &outputs[0]);
  nvtxRangePop();
}

// End of code generation (_coder_ec_detr_fp_mex.cu)
