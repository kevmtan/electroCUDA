//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// ec_CWTsingle_terminate.cu
//
// Code generation for function 'ec_CWTsingle_terminate'
//

// Include files
#include "ec_CWTsingle_terminate.h"
#include "_coder_ec_CWTsingle_mex.h"
#include "cwt.h"
#include "ec_CWTsingle_data.h"
#include "rt_nonfinite.h"
#include "MWMemoryManager.hpp"

// Function Definitions
void ec_CWTsingle_atexit()
{
  mexFunctionCreateRootTLS();
  emlrtEnterRtStackR2012b(emlrtRootTLSGlobal);
  cwt_free();
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

void ec_CWTsingle_terminate()
{
  cudaError_t errCode;
  errCode = cudaGetLastError();
  if (errCode != cudaSuccess) {
    emlrtThinCUDAError(static_cast<uint32_T>(errCode),
                       (char_T *)cudaGetErrorString(errCode),
                       (char_T *)cudaGetErrorName(errCode),
                       (char_T *)"SafeBuild", emlrtRootTLSGlobal);
  }
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  mwMemoryManagerTerminate();
}

// End of code generation (ec_CWTsingle_terminate.cu)
