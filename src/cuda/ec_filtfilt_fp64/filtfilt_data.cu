//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// filtfilt_data.cu
//
// Code generation for function 'filtfilt_data'
//

// Include files
#include "filtfilt_data.h"
#include "rt_nonfinite.h"

// Variable Definitions
emlrtCTX emlrtRootTLSGlobal{nullptr};

emlrtContext emlrtContextGlobal{
    true,                                               // bFirstTime
    false,                                              // bInitialized
    131659U,                                            // fVersionInfo
    nullptr,                                            // fErrorFunction
    "filtfilt",                                         // fFunctionName
    nullptr,                                            // fRTCallStack
    false,                                              // bDebugMode
    {3130694236U, 2616137409U, 972914731U, 129233577U}, // fSigWrd
    nullptr                                             // fSigMem
};

emlrtRTEInfo sd_emlrtRTEI{
    1,               // lineNo
    1,               // colNo
    "gpufilterImpl", // fName
    "/usr/local/MATLAB/R2024b/toolbox/eml/lib/matlab/datafun/private/"
    "gpufilterImpl.p" // pName
};

// End of code generation (filtfilt_data.cu)
